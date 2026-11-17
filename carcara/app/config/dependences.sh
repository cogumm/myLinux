#!/bin/bash
#---------------------------------------------------------------------------#
# Data criação: 15 de Fevereiro de 2020
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: dependences
# Descrição: Garante dependências do Carcará (yad, zenity, curl; snapd/flatpak).
# Variáveis: $configYadB : Janela Yad com botões / timeout
#---------------------------------------------------------------------------#

# Requires config.sh already sourced (configYad*, root). Prefer sourcing this file,
# not executing it in a bare subshell, so Yad settings remain available.
# Install UI tools BEFORE any yad/zenity call (including testConnection).
# shellcheck disable=SC2154 # configYadB exported by config.sh when sourced from startApp


_carcara_cmd_ok() {
	command -v "$1" >/dev/null 2>&1
}

_carcara_apt_install() {
	# Running as root via config.sh isRoot; apt-get is the stable CLI for scripts.
	DEBIAN_FRONTEND=noninteractive apt-get install -y "$@"
}

# Notify via Yad when available; otherwise terminal only (bootstrap-safe).
_carcara_notify() {
	local title="$1"
	local text="$2"
	if _carcara_cmd_ok yad; then
		# shellcheck disable=SC2086
		yad --title "$title" --text "$text" $configYadB
	else
		echo "[$title] $text"
	fi
}

dependences() {
	local missing=()

	_carcara_cmd_ok yad || missing+=(yad)
	_carcara_cmd_ok zenity || missing+=(zenity)
	_carcara_cmd_ok curl || missing+=(curl)

	if ((${#missing[@]} > 0)); then
		echo "Instalando dependências obrigatórias: ${missing[*]}"
		if ! _carcara_apt_install "${missing[@]}"; then
			echo "Falha ao instalar: ${missing[*]}. Verifique a saída do apt no terminal."
			return 1
		fi
		hash -r 2>/dev/null || true
	fi

	if ! _carcara_cmd_ok yad || ! _carcara_cmd_ok zenity; then
		echo "yad/zenity ainda indisponíveis após apt-get. Abortando."
		return 1
	fi

	# Network check only after Yad exists (testConnection uses Yad dialogs).
	# shellcheck source=testConnection.sh
	. app/config/testConnection.sh
	testConnection || return 1

	# snap → package snapd; command is "snap"
	if ! _carcara_cmd_ok snap; then
		echo "Instalando snapd (comando snap)…"
		if ! _carcara_apt_install snapd; then
			_carcara_notify "Dependências" \
				"Não foi possível instalar snapd. Snap fica indisponível até corrigir."
		else
			hash -r 2>/dev/null || true
		fi
	fi

	# Flatpak optional for Wave 2 GUI installs.
	if ! _carcara_cmd_ok flatpak; then
		echo "Instalando flatpak (opcional, apps GUI)…"
		if ! _carcara_apt_install flatpak; then
			_carcara_notify "Dependências" \
				"flatpak não instalado. Apps Flatpak ficarão indisponíveis."
		else
			hash -r 2>/dev/null || true
		fi
	fi

	_carcara_notify "Dependências" "Dependências do Carcará verificadas."
	return 0
}

# Run only when executed directly (startApp sources this file and calls dependences).
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	dependences
fi
# Fim
