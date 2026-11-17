#!/bin/bash
#----------------------------------------------------------------------------------------------------#
# smoke-elevated.sh — run Software smoke as root without a password prompt
#
# One-time (asks for sudo password once):
#   bun run smoke:nopasswd-install
#   # or: sudo bash scripts/smoke-elevated.sh install
#
# Then (no password):
#   bun run smoke:elevated -- --live-safe
#   bun run smoke:elevated -- --live-extended
#
# Uses sudo -n + /etc/sudoers.d/carcara-smoke (scoped to this smoke script only).
# Prefer this over pkexec on WSL — polkit often has no agent/TTY and hangs.
#----------------------------------------------------------------------------------------------------#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ELECTRON_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
SMOKE_SH="${SCRIPT_DIR}/smoke-software.sh"
SUDOERS_FILE="/etc/sudoers.d/carcara-smoke"

_die() { echo "[smoke-elevated:error] $*" >&2; exit 1; }

_real_user() {
	if [[ -n "${SUDO_USER:-}" && "${SUDO_USER}" != "root" ]]; then
		printf '%s\n' "${SUDO_USER}"
	else
		printf '%s\n' "$(id -un)"
	fi
}

_bun_dir() {
	local u home
	u="$(_real_user)"
	home="$(getent passwd "$u" | cut -d: -f6 || true)"
	if [[ -x "${home}/.bun/bin/bun" ]]; then
		printf '%s\n' "${home}/.bun/bin"
		return 0
	fi
	if command -v bun >/dev/null 2>&1; then
		dirname "$(command -v bun)"
		return 0
	fi
	return 1
}

install_nopasswd() {
	local user smoke bun_dir tmp
	if [[ "$(id -u)" -ne 0 ]]; then
		echo "[smoke-elevated] elevating once to install sudoers (password prompt)…"
		exec sudo -E bash "$0" install
	fi
	user="${SUDO_USER:-}"
	[[ -n "$user" && "$user" != "root" ]] || _die "SUDO_USER missing — run: sudo -E bash $0 install"
	smoke="$(readlink -f "$SMOKE_SH")"
	[[ -f "$smoke" ]] || _die "missing $smoke"
	bun_dir="$(_bun_dir)" || _die "bun not found for $user"

	tmp="$(mktemp)"
	cat >"$tmp" <<EOF
# Carcará Software smoke — passwordless elevation (personal machine only).
# Installed by carcara-electron/scripts/smoke-elevated.sh — remove to revoke:
#   sudo rm -f /etc/sudoers.d/carcara-smoke
Defaults:${user} !requiretty
${user} ALL=(root) NOPASSWD:SETENV: /bin/bash ${smoke} *
EOF
	chmod 440 "$tmp"
	if ! visudo -cf "$tmp" >/dev/null; then
		rm -f "$tmp"
		_die "generated sudoers failed visudo -cf"
	fi
	install -m 440 "$tmp" "$SUDOERS_FILE"
	rm -f "$tmp"
	echo "[smoke-elevated] installed $SUDOERS_FILE"
	echo "[smoke-elevated] try: bun run smoke:elevated -- --live-safe"
	echo "[smoke-elevated] Bun on PATH for children: ${bun_dir}"
}

run_elevated() {
	local bun_dir path_export
	[[ -f "$SMOKE_SH" ]] || _die "missing $SMOKE_SH"
	bun_dir="$(_bun_dir)" || _die "bun not found — install Bun for your user first"
	path_export="${bun_dir}:${PATH}"

	if [[ "$(id -u)" -eq 0 ]]; then
		export PATH="$path_export"
		export CARCARA_REPO_ROOT="$(cd "${ELECTRON_ROOT}/.." && pwd)"
		exec bash "$SMOKE_SH" "$@"
	fi

	if ! sudo -n true 2>/dev/null; then
		echo "[smoke-elevated] passwordless sudo not configured for smoke." >&2
		echo "[smoke-elevated] one-time: sudo bash ${SCRIPT_DIR}/smoke-elevated.sh install" >&2
		exit 1
	fi

	# Drop --pkexec under sudo -n root: already elevated; avoids polkit hang on WSL.
	local args=() a
	for a in "$@"; do
		[[ "$a" == "--pkexec" ]] && continue
		args+=("$a")
	done

	exec sudo -n -E env \
		"PATH=${path_export}" \
		"CARCARA_REPO_ROOT=$(cd "${ELECTRON_ROOT}/.." && pwd)" \
		"CARCARA_NONINTERACTIVE=1" \
		"HOME=${HOME}" \
		"SUDO_USER=$(id -un)" \
		/bin/bash "$SMOKE_SH" "${args[@]}"
}

usage() {
	cat <<'EOF'
usage: smoke-elevated.sh install | [smoke-software.sh args...]

  install   write /etc/sudoers.d/carcara-smoke (NOPASSWD for smoke-software.sh)
  (args)    run smoke-software.sh via sudo -n (no password)

Examples:
  sudo bash scripts/smoke-elevated.sh install
  bun run smoke:elevated -- --live-safe
  bun run smoke:elevated -- --live-extended
EOF
}

main() {
	case "${1:-}" in
		-h|--help) usage; exit 0 ;;
		install) shift; install_nopasswd "$@" ;;
		*) run_elevated "$@" ;;
	esac
}

main "$@"
