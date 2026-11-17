#!/bin/bash
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: install_backends
# Descrição: API compartilhada de instalação (apt keyring, Flatpak, Snap) para Carcará 1.x / 2.0.
# Variáveis: $configYad : flags Yad opcionais para run_with_progress
#----------------------------------------------------------------------------------------------------#

# Source-only library (no side effects). Requires root for apt/snap/flatpak system installs.
# Safe to source multiple times.
# When sourced twice: return. Do not execute this file as a program.
if [[ -n "${CARCARA_BACKENDS_LOADED:-}" ]]; then
	return 0
fi
CARCARA_BACKENDS_LOADED=1

# --- logging (machine-friendly for Electron later) ---

carcara_log() {
	echo "[carcara] $*" >&2
}

carcara_err() {
	echo "[carcara:error] $*" >&2
}

# --- presence checks ---

# pkg_present <command|dpkg|flatpak|snap> <name>
# Returns 0 if present.
pkg_present() {
	local kind="${1:-}"
	local name="${2:-}"
	if [[ -z "$kind" || -z "$name" ]]; then
		carcara_err "pkg_present: usage: pkg_present <command|dpkg|flatpak|snap> <name>"
		return 2
	fi
	case "$kind" in
		command)
			command -v "$name" >/dev/null 2>&1
			;;
		dpkg)
			dpkg-query -W -f='${Status}' "$name" 2>/dev/null | grep -q "install ok installed"
			;;
		flatpak)
			command -v flatpak >/dev/null 2>&1 && flatpak info "$name" >/dev/null 2>&1
			;;
		snap)
			command -v snap >/dev/null 2>&1 && snap list "$name" >/dev/null 2>&1
			;;
		*)
			carcara_err "pkg_present: unknown kind '$kind'"
			return 2
			;;
	esac
}

# --- apt ---

# apt_install <pkg> [pkg...]
# Non-interactive apt-get install. Prints status; returns apt exit code.
apt_install() {
	if (($# < 1)); then
		carcara_err "apt_install: need at least one package"
		return 2
	fi
	carcara_log "apt_install: $*"
	DEBIAN_FRONTEND=noninteractive apt-get install -y "$@"
}

# ensure_apt_keyring_repo <name> <key_url> <deb_line>
# Writes /etc/apt/keyrings/<name>.gpg and /etc/apt/sources.list.d/<name>.list
# deb_line example: 'deb [arch=amd64 signed-by=/etc/apt/keyrings/name.gpg] https://example.com stable main'
# Prefer including signed-by= in deb_line. key_url must be an ASCII-armored or binary key fetchable by curl.
ensure_apt_keyring_repo() {
	local name="${1:-}"
	local key_url="${2:-}"
	local deb_line="${3:-}"
	local keyring="/etc/apt/keyrings/${name}.gpg"
	local list="/etc/apt/sources.list.d/${name}.list"

	if [[ -z "$name" || -z "$key_url" || -z "$deb_line" ]]; then
		carcara_err "ensure_apt_keyring_repo: usage: ensure_apt_keyring_repo <name> <key_url> <deb_line>"
		return 2
	fi

	if ! command -v curl >/dev/null 2>&1; then
		carcara_err "ensure_apt_keyring_repo: curl is required"
		return 1
	fi
	if ! command -v gpg >/dev/null 2>&1; then
		carcara_log "Installing gnupg for apt keyrings"
		apt_install gnupg || return 1
		hash -r 2>/dev/null || true
	fi

	if [[ ! -d /etc/apt/keyrings ]]; then
		install -d -m 0755 /etc/apt/keyrings || return 1
	fi

	if [[ ! -f "$keyring" ]]; then
		carcara_log "Fetching apt key for '$name' from $key_url"
		if ! curl -fsSL "$key_url" | gpg --dearmor -o "$keyring"; then
			carcara_err "Failed to install keyring $keyring"
			rm -f "$keyring"
			return 1
		fi
		chmod 0644 "$keyring" || true
	else
		carcara_log "Keyring already present: $keyring"
	fi

	if [[ ! -f "$list" ]] || ! grep -Fqx "$deb_line" "$list" 2>/dev/null; then
		carcara_log "Writing apt source $list"
		printf '%s\n' "$deb_line" >"$list" || return 1
		chmod 0644 "$list" || true
	else
		carcara_log "Apt source already present: $list"
	fi

	carcara_log "apt-get update (after keyring repo '$name')"
	DEBIAN_FRONTEND=noninteractive apt-get update
}

# --- flatpak ---

# ensure_flatpak_flathub
# Ensures flatpak binary and Flathub remote exist.
ensure_flatpak_flathub() {
	if ! command -v flatpak >/dev/null 2>&1; then
		carcara_log "Installing flatpak via apt"
		apt_install flatpak || return 1
		hash -r 2>/dev/null || true
	fi
	if ! command -v flatpak >/dev/null 2>&1; then
		carcara_err "flatpak still missing after apt_install"
		return 1
	fi
	if ! flatpak remote-list 2>/dev/null | awk '{print $1}' | grep -qx flathub; then
		carcara_log "Adding Flathub remote"
		flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo || return 1
	else
		carcara_log "Flathub remote already configured"
	fi
	return 0
}

# flatpak_install <app-id> [extra flatpak install args...]
flatpak_install() {
	local app_id="${1:-}"
	shift || true
	if [[ -z "$app_id" ]]; then
		carcara_err "flatpak_install: usage: flatpak_install <app-id> [args...]"
		return 2
	fi
	ensure_flatpak_flathub || return 1
	if pkg_present flatpak "$app_id"; then
		carcara_log "flatpak already installed: $app_id"
		return 0
	fi
	carcara_log "flatpak_install: $app_id $*"
	flatpak install -y flathub "$app_id" "$@"
}

# --- snap ---

# snap_install <snap-name> [--classic] [extra snap args...]
snap_install() {
	local name="${1:-}"
	shift || true
	if [[ -z "$name" ]]; then
		carcara_err "snap_install: usage: snap_install <name> [--classic] [args...]"
		return 2
	fi
	if ! command -v snap >/dev/null 2>&1; then
		carcara_log "Installing snapd via apt"
		apt_install snapd || return 1
		hash -r 2>/dev/null || true
	fi
	if ! command -v snap >/dev/null 2>&1; then
		carcara_err "snap still missing after apt_install snapd"
		return 1
	fi
	if pkg_present snap "$name"; then
		carcara_log "snap already installed: $name"
		return 0
	fi
	carcara_log "snap_install: $name $*"
	snap install "$name" "$@"
}

# --- progress wrapper ---

# run_with_progress <title> <command> [args...]
# Runs command; optional Yad pulsate. Preserves command exit code (PIPESTATUS).
# Always leaves command output on the terminal / pipe for logs (2.0-friendly).
run_with_progress() {
	local title="${1:-Carcará}"
	shift || true
	if (($# < 1)); then
		carcara_err "run_with_progress: usage: run_with_progress <title> <command> [args...]"
		return 2
	fi

	carcara_log "run_with_progress: $title → $*"

	if command -v yad >/dev/null 2>&1; then
		# shellcheck disable=SC2086
		"$@" 2>&1 | yad --progress \
			--title "$title" \
			--text "$title" \
			--progress-text="Aguarde…" \
			--pulsate \
			--auto-close \
			--width=500 \
			--center \
			--no-buttons
		# Prefer the command status, not Yad's
		return "${PIPESTATUS[0]}"
	fi

	"$@"
}

# Fim
