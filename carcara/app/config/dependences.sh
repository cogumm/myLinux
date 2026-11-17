#!/bin/bash
#---------------------------------------------------------------------------#
# Data criação: 15 de Fevereiro de 2020
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: dependences
# Descrição: Bootstrap idempotente — yad/zenity/curl/ping; snapd; flatpak+Flathub.
# Variáveis: $configYad (notify); CARCARA_NONINTERACTIVE; requires config.sh + backends
#---------------------------------------------------------------------------#
# Requires config.sh already sourced (isRoot, configYad*, install_backends).
# Install UI tools BEFORE any yad/zenity call (including testConnection).
# shellcheck disable=SC2154 # configYad exported by config.sh when sourced from startApp

_carcara_cmd_ok() {
	command -v "$1" >/dev/null 2>&1
}

# Apt-family only (Debian/Ubuntu/Mint…). Soft-detect via /etc/os-release.
_carcara_require_apt_family() {
	local id="" id_like=""
	if [[ -r /etc/os-release ]]; then
		# shellcheck disable=SC1091
		. /etc/os-release
		id="${ID:-}"
		id_like="${ID_LIKE:-}"
	fi
	case " ${id} ${id_like} " in
		*" debian "*|*" ubuntu "*)
			return 0
			;;
	esac
	if _carcara_cmd_ok apt-get && _carcara_cmd_ok dpkg; then
		carcara_log "os-release não é debian/ubuntu; apt-get presente — seguindo"
		return 0
	fi
	carcara_err "Carcará 1.x exige família apt (Debian/Ubuntu). ID=${id:-?} ID_LIKE=${id_like:-?}"
	return 1
}

_carcara_apt_update() {
	carcara_log "apt-get update (bootstrap)"
	DEBIAN_FRONTEND=noninteractive apt-get update
}

# Notify via Yad when available and interactive; otherwise terminal.
_carcara_notify() {
	local title="$1"
	local text="$2"
	if [[ -z "${CARCARA_NONINTERACTIVE:-}" ]] && _carcara_cmd_ok yad; then
		# Prefer no-button timeout dialog (configYad), not blocking configYadB.
		# shellcheck disable=SC2086
		yad --title "$title" --text "$text" $configYad
	else
		carcara_log "[$title] $text"
	fi
}

# Best-effort: enable snapd on systemd hosts (skip quietly on WSL/containers).
_carcara_snapd_ready() {
	if ! _carcara_cmd_ok snap; then
		return 1
	fi
	if [[ -d /run/systemd/system ]] && _carcara_cmd_ok systemctl; then
		systemctl enable --now snapd.socket >/dev/null 2>&1 || true
		systemctl start snapd >/dev/null 2>&1 || true
	fi
	return 0
}

dependences() {
	local missing=()
	local need_update=0

	carcara_log "dependences: starting bootstrap"

	_carcara_require_apt_family || return 1

	# --- required for 1.x TUI + network probe ---
	_carcara_cmd_ok yad || missing+=(yad)
	_carcara_cmd_ok zenity || missing+=(zenity)
	_carcara_cmd_ok curl || missing+=(curl)
	# testConnection / helper ping
	_carcara_cmd_ok ping || missing+=(iputils-ping)

	if ((${#missing[@]} > 0)); then
		need_update=1
		carcara_log "obrigatórias ausentes: ${missing[*]}"
		_carcara_apt_update || {
			carcara_err "apt-get update falhou — não dá para instalar dependências"
			return 1
		}
		if ! apt_install "${missing[@]}"; then
			carcara_err "Falha ao instalar: ${missing[*]}"
			return 1
		fi
		hash -r 2>/dev/null || true
	else
		carcara_log "obrigatórias OK (yad zenity curl ping)"
	fi

	if ! _carcara_cmd_ok yad || ! _carcara_cmd_ok zenity; then
		carcara_err "yad/zenity ainda indisponíveis após apt. Abortando."
		return 1
	fi
	if ! _carcara_cmd_ok curl; then
		carcara_err "curl ainda indisponível após apt. Abortando."
		return 1
	fi

	# Network check only after Yad exists (interactive path uses Yad dialogs).
	# shellcheck source=testConnection.sh
	. app/config/testConnection.sh
	if ! testConnection; then
		carcara_err "teste de conexão falhou"
		return 1
	fi

	# --- optional: snapd (Wave 2 Snap fallbacks) ---
	if ! _carcara_cmd_ok snap; then
		carcara_log "instalando snapd (opcional)…"
		if ((need_update == 0)); then
			_carcara_apt_update || carcara_log "apt-get update falhou (snapd); tentando install mesmo assim"
			need_update=1
		fi
		if apt_install snapd; then
			hash -r 2>/dev/null || true
			_carcara_snapd_ready || true
		else
			_carcara_notify "Dependências" \
				"Não foi possível instalar snapd. Snap fica indisponível até corrigir."
		fi
	else
		_carcara_snapd_ready || true
		carcara_log "snap OK"
	fi

	# --- optional: flatpak + Flathub (Wave 2 GUI path) ---
	if ! _carcara_cmd_ok flatpak; then
		carcara_log "instalando flatpak (opcional)…"
		if ((need_update == 0)); then
			_carcara_apt_update || carcara_log "apt-get update falhou (flatpak); tentando install mesmo assim"
			need_update=1
		fi
	fi
	if ! ensure_flatpak_flathub; then
		_carcara_notify "Dependências" \
			"flatpak/Flathub indisponível. Apps Flatpak ficarão indisponíveis."
	else
		carcara_log "flatpak + Flathub OK"
	fi

	_carcara_notify "Dependências" "Dependências do Carcará verificadas."
	carcara_log "dependences: done"
	return 0
}

# Run only when executed directly (startApp sources this file and calls dependences).
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	# Direct exec still needs config/backends (cwd = carcara/).
	# shellcheck source=config.sh
	. app/config/config.sh
	dependences
fi
# Fim
