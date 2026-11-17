#!/bin/bash
#----------------------------------------------------------------------------------------------------#
# smoke-software.sh — Carcará 2.0 Software / pkexec smoke harness
# Modes:
#   (default)   static wiring + unprivileged runtime (ping, unknown action, pkexec probe)
#   --pkexec    also exercise elevated apt-dry-run via pkexec|root bridge
#   --live ACT… run real install/preset actions (needs root or working pkexec)
#   --live-core curated baseline install set (needs root|pkexec) — not versioned by “wave”
#----------------------------------------------------------------------------------------------------#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ELECTRON_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
REPO_ROOT="$(cd "${ELECTRON_ROOT}/.." && pwd)"
HELPER="${ELECTRON_ROOT}/helper/carcara-helper.sh"
SOFTWARE_TS="${ELECTRON_ROOT}/src/renderer/views/software.ts"
RUN_HELPER_NODE="${ELECTRON_ROOT}/src/run-helper-node.ts"
RUN_HELPER_BUN="${ELECTRON_ROOT}/scripts/run-helper.ts"

# Curated live sets. Extend these lists — do not add smoke:waveN scripts.
CORE_LIVE_ACTIONS=(
	install-git
	install-vscode
	install-insomnia
	install-firacode
	install-vlc
	install-discord
	install-spotify
	install-telegram
	install-dropbox
)

# Beyond baseline (catalog sample — apt/Flatpak/Snap mix; still idempotent when present).
EXTENDED_LIVE_ACTIONS=(
	install-firefox
	install-brave
	install-obs
	install-thunderbird
	install-postman
	install-whatsapp
	install-libreoffice
	install-bitwarden
)

PASS=0
FAIL=0
SKIP=0
MODE_PKEXEC=0
LIVE_ACTIONS=()

# sudo secure_path drops ~/.bun/bin — same recovery as repo-root start.sh.
_ensure_bun_on_path() {
	if command -v bun >/dev/null 2>&1; then
		return 0
	fi
	local candidates=() home="" c bun_bin=""
	if [[ -n "${SUDO_USER:-}" && "${SUDO_USER}" != "root" ]]; then
		home="$(getent passwd "${SUDO_USER}" | cut -d: -f6 || true)"
		[[ -n "$home" ]] && candidates+=("${home}/.bun/bin/bun")
	fi
	[[ -n "${HOME:-}" && "${HOME}" != /root ]] && candidates+=("${HOME}/.bun/bin/bun")
	candidates+=("/usr/local/bin/bun" "/usr/bin/bun")
	for c in "${candidates[@]}"; do
		if [[ -x "$c" ]]; then
			bun_bin="$c"
			break
		fi
	done
	[[ -z "$bun_bin" ]] && return 1
	export PATH="$(dirname "$bun_bin"):${PATH}"
	_log "Bun recovered for sudo PATH: ${bun_bin}"
	return 0
}

usage() {
	cat <<'EOF'
usage: smoke-software.sh [--pkexec] [--live <action>...] [--live-safe] [--live-core] [--live-extended] [--help]

  default         UI↔helper↔scripts wiring (incl. bash -n) + ping + pkexec probe
  --pkexec        also run apt-dry-run via bun helper bridge (root or pkexec)
  --live …        run install-* / preset-* for real (mutating; owner machine)
  --live-safe     shorthand: --live install-git (idempotent apt when git present)
  --live-core     curated baseline set — requires root or pkexec
  --live-extended baseline + catalog sample (firefox brave obs thunderbird
                  postman whatsapp libreoffice bitwarden)

Examples:
  bun run smoke:software
  # pkexec: unelevated user (NOT sudo) so the polkit dialog can run
  bun run smoke:software -- --pkexec --live-safe
  bun run smoke:software -- --pkexec --live-extended
  # sudo: never bare `sudo bun` (secure_path hides ~/.bun/bin)
  sudo env "PATH=$PATH" bun run smoke:software -- --live-core
  sudo bash scripts/smoke-software.sh --live-extended
EOF
}

while [[ $# -gt 0 ]]; do
	case "$1" in
		--pkexec) MODE_PKEXEC=1; shift ;;
		--live-safe)
			LIVE_ACTIONS+=("install-git")
			shift
			;;
		--live-core)
			LIVE_ACTIONS+=("${CORE_LIVE_ACTIONS[@]}")
			MODE_PKEXEC=1
			shift
			;;
		--live-extended)
			LIVE_ACTIONS+=("${CORE_LIVE_ACTIONS[@]}" "${EXTENDED_LIVE_ACTIONS[@]}")
			MODE_PKEXEC=1
			shift
			;;
		--live)
			shift
			while [[ $# -gt 0 && "$1" != --* ]]; do
				LIVE_ACTIONS+=("$1")
				shift
			done
			;;
		-h|--help) usage; exit 0 ;;
		*)
			echo "[smoke] unknown flag: $1" >&2
			usage >&2
			exit 2
			;;
	esac
done

_log() { printf '[smoke] %s\n' "$*"; }
_pass() { PASS=$((PASS + 1)); _log "PASS: $*"; }
_fail() { FAIL=$((FAIL + 1)); _log "FAIL: $*"; }
_skip() { SKIP=$((SKIP + 1)); _log "SKIP: $*"; }

_require_files() {
	local f
	for f in "$HELPER" "$SOFTWARE_TS" "$RUN_HELPER_NODE" "$RUN_HELPER_BUN"; do
		if [[ ! -f "$f" ]]; then
			_fail "missing $f"
			return 1
		fi
	done
	if [[ ! -x "$HELPER" ]]; then
		chmod +x "$HELPER" || true
	fi
	_pass "core files present"
}

# Actions referenced by the Software UI (tiles + presets).
_ui_actions() {
	grep -oE 'action: "(install|preset)-[a-z0-9-]+"' "$SOFTWARE_TS" \
		| sed -E 's/.*"(.*)"/\1/' \
		| sort -u
}

# Helper case arms that look like install-* / preset-*.
_helper_actions() {
	grep -E '^\s+(install|preset)-[a-z0-9-]+\)' "$HELPER" \
		| sed -E 's/.*\s((install|preset)-[a-z0-9-]+)\).*/\1/' \
		| sort -u
}

# Script path for a helper install/preset arm (from _run_carcara_script line that follows).
_helper_script_for() {
	local action="$1"
	awk -v act="$action" '
		$0 ~ "^[[:space:]]*" act "\\)" { want=1; next }
		want && /_run_carcara_script/ {
			sub(/^[^"]*"/, "")
			sub(/".*/, "")
			print
			exit
		}
		want && /^[[:space:]]*[a-z].*\)/ { exit }
	' "$HELPER"
}

_check_wiring() {
	local ui helper missing extra action rel script
	ui="$(_ui_actions)"
	helper="$(_helper_actions)"

	missing="$(comm -23 <(printf '%s\n' "$ui") <(printf '%s\n' "$helper") || true)"
	extra="$(comm -13 <(printf '%s\n' "$ui") <(printf '%s\n' "$helper") || true)"

	if [[ -n "$missing" ]]; then
		_fail "UI actions missing from helper:\n$missing"
	else
		_pass "all UI Software actions are in helper allowlist ($(printf '%s\n' "$ui" | grep -c . || true))"
	fi

	# Extra helper installs are OK (CLI-only), but log them.
	if [[ -n "$extra" ]]; then
		_log "note: helper-only actions (not on Software tiles): $(printf '%s' "$extra" | tr '\n' ' ')"
	fi

	while IFS= read -r action; do
		[[ -z "$action" ]] && continue
		rel="$(_helper_script_for "$action")"
		if [[ -z "$rel" ]]; then
			_fail "$action: no _run_carcara_script target in helper"
			continue
		fi
		script="${REPO_ROOT}/carcara/${rel}"
		if [[ -f "$script" ]]; then
			if bash -n "$script" 2>/dev/null; then
				_pass "$action → $rel (bash -n OK)"
			else
				_fail "$action → $rel (bash -n failed)"
			fi
		else
			_fail "$action → missing $script"
		fi
	done <<<"$helper"
}

_check_unknown_action() {
	local code=0
	set +e
	bash "$HELPER" "__smoke-unknown-action__" >/dev/null 2>&1
	code=$?
	set -e
	if [[ "$code" -eq 2 ]]; then
		_pass "unknown action exits 2"
	else
		_fail "unknown action exit=$code (want 2)"
	fi
}

_check_ping() {
	local code=0
	export CARCARA_REPO_ROOT="$REPO_ROOT"
	export CARCARA_NONINTERACTIVE=1
	export CARCARA_TEST_HOST="${CARCARA_TEST_HOST:-8.8.8.8}"
	export CARCARA_TEST_COUNT="${CARCARA_TEST_COUNT:-1}"
	set +e
	bash "$HELPER" ping
	code=$?
	set -e
	if [[ "$code" -eq 0 ]]; then
		_pass "helper ping (unprivileged)"
	else
		_fail "helper ping exit=$code"
	fi
}

_pkexec_probe() {
	local uid has_pkexec has_display
	uid="$(id -u)"
	has_pkexec=0
	has_display=0
	command -v pkexec >/dev/null 2>&1 && has_pkexec=1
	[[ -n "${DISPLAY:-}${WAYLAND_DISPLAY:-}" ]] && has_display=1

	_log "env: uid=$uid pkexec=$has_pkexec display=$has_display"

	if grep -qi microsoft /proc/version 2>/dev/null; then
		_log "host looks like WSL — approve polkit prompts in the GUI agent if shown"
	fi

	if [[ "$uid" -eq 0 ]]; then
		_pass "already root — helper skips pkexec (1.x parity); for real pkexec re-run as normal user"
	elif [[ "$has_pkexec" -eq 1 && "$has_display" -eq 1 ]]; then
		_pass "pkexec + display available for elevation path (unelevated)"
		if [[ "$MODE_PKEXEC" -eq 1 ]]; then
			_log "privileged helper actions will go through pkexec — approve the dialog if prompted"
		fi
	else
		_skip "pkexec elevation not available (install policykit-1, or use sudo with PATH preserved)"
	fi

	# Bridge decision parity: both Node and Bun bridges treat the same UNPRIVILEGED set.
	if grep -q 'dotfiles-bashrc' "$RUN_HELPER_NODE" && grep -q 'dotfiles-bashrc' "$RUN_HELPER_BUN"; then
		_pass "Bun + Node bridges share unprivileged allowlist marker"
	else
		_fail "UNPRIVILEGED sets look out of sync between run-helper bridges"
	fi

	if grep -q 'pkexec' "$RUN_HELPER_NODE" \
		&& grep -q 'CARCARA_REPO_ROOT' "$RUN_HELPER_NODE" \
		&& grep -q 'pkexec' "$RUN_HELPER_BUN" \
		&& grep -q 'CARCARA_REPO_ROOT' "$RUN_HELPER_BUN"; then
		_pass "pkexec bridges pass/honour CARCARA_REPO_ROOT"
	else
		_fail "pkexec env wiring incomplete (Node and/or Bun bridge)"
	fi
}

_run_elevated_dry() {
	local code=0
	export CARCARA_REPO_ROOT="$REPO_ROOT"
	export CARCARA_NONINTERACTIVE=1

	if [[ "$(id -u)" -ne 0 ]] && ! command -v pkexec >/dev/null 2>&1; then
		_skip "apt-dry-run needs root or pkexec"
		return 0
	fi

	if ! _ensure_bun_on_path; then
		_fail "bun not found for apt-dry-run under elevated PATH"
		return 0
	fi

	_log "running apt-dry-run via bun helper bridge…"
	set +e
	(
		cd "$ELECTRON_ROOT"
		bun run helper -- apt-dry-run
	)
	code=$?
	set -e
	if [[ "$code" -eq 0 ]]; then
		_pass "apt-dry-run via helper bridge"
	else
		_fail "apt-dry-run exit=$code"
	fi
}

_elevation_ok() {
	[[ "$(id -u)" -eq 0 ]] && return 0
	command -v pkexec >/dev/null 2>&1 || return 1
	[[ -n "${DISPLAY:-}${WAYLAND_DISPLAY:-}" ]] || return 1
	return 0
}

_run_live() {
	local action code
	if [[ "${#LIVE_ACTIONS[@]}" -eq 0 ]]; then
		return 0
	fi
	if ! _elevation_ok; then
		_fail "live installs need root or pkexec+display (try: sudo env \"PATH=\$PATH\" bun run smoke:software -- --live-core)"
		_log "queued (not run): ${LIVE_ACTIONS[*]}"
		return 0
	fi
	if ! _ensure_bun_on_path; then
		_fail "bun not found (sudo often hides ~/.bun/bin) — use: sudo env \"PATH=\$PATH\" bun run smoke:software -- --live-core"
		return 0
	fi
	export CARCARA_REPO_ROOT="$REPO_ROOT"
	export CARCARA_NONINTERACTIVE=1
	_log "LIVE mutating installs: ${LIVE_ACTIONS[*]}"
	for action in "${LIVE_ACTIONS[@]}"; do
		if [[ ! "$action" =~ ^(install|preset)-[a-z0-9-]+$ ]]; then
			_fail "refusing non-install action in --live: $action"
			continue
		fi
		_log "LIVE → $action"
		set +e
		(
			cd "$ELECTRON_ROOT"
			bun run helper -- "$action"
		)
		code=$?
		set -e
		if [[ "$code" -eq 0 ]]; then
			_pass "live $action"
		else
			_fail "live $action exit=$code"
		fi
	done
}

main() {
	_log "repo=$REPO_ROOT"
	_require_files
	_check_wiring
	_check_unknown_action
	_check_ping
	_pkexec_probe

	if [[ "$MODE_PKEXEC" -eq 1 ]]; then
		_run_elevated_dry
	fi
	_run_live

	_log "summary: pass=$PASS fail=$FAIL skip=$SKIP"
	if [[ "$FAIL" -gt 0 ]]; then
		exit 1
	fi
	exit 0
}

main
