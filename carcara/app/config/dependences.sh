#!/bin/bash
#---------------------------------------------------------------------------#
# Data criação: 15 de Fevereiro de 2020
# Última alteração: 16 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: dependences
# Descrição: Garante dependências do Carcará (yad, zenity, curl; snapd/flatpak).
# Variáveis: $configYadB : Janela Yad com botões / timeout
#---------------------------------------------------------------------------#

# Requires config.sh already sourced (configYad*, root). Prefer sourcing this file,
# not executing it in a bare subshell, so Yad settings remain available.

_carcara_cmd_ok() {
	command -v "$1" >/dev/null 2>&1
}

_carcara_apt_install() {
	# Running as root via config.sh isRoot; apt-get is the stable CLI for scripts.
	DEBIAN_FRONTEND=noninteractive apt-get install -y "$@"
}

dependences() {
	# Inherit $configYad from the parent shell (startApp sources config.sh first).
	# shellcheck source=testConnection.sh
	. app/config/testConnection.sh

	local missing=()
	local pkg

	_carcara_cmd_ok yad || missing+=(yad)
	_carcara_cmd_ok zenity || missing+=(zenity)
	_carcara_cmd_ok curl || missing+=(curl)

	if ((${#missing[@]} > 0)); then
		echo "Instalando dependências obrigatórias: ${missing[*]}"
		if ! _carcara_apt_install "${missing[@]}"; then
			yad --title "Dependências" \
				--text "Falha ao instalar: ${missing[*]}. Verifique a saída no terminal." \
				$configYadB
			return 1
		fi
	fi

	# snap → package snapd; command is "snap"
	if ! _carcara_cmd_ok snap; then
		echo "Instalando snapd (comando snap)…"
		if ! _carcara_apt_install snapd; then
			yad --title "Dependências" \
				--text "Não foi possível instalar snapd. Snap fica indisponível até corrigir." \
				$configYadB
		fi
	fi

	# Flatpak optional for Wave 2 GUI installs; warn if missing, install when possible.
	if ! _carcara_cmd_ok flatpak; then
		echo "Instalando flatpak (opcional, apps GUI)…"
		if ! _carcara_apt_install flatpak; then
			yad --title "Dependências" \
				--text "flatpak não instalado. Apps Flatpak ficarão indisponíveis." \
				$configYadB
		fi
	fi

	yad --title "Dependências" \
		--text "Dependências do Carcará verificadas." \
		$configYadB
	return 0
}

dependences
# Fim
