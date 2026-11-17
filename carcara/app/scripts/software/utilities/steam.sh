#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: Steam
# Descrição: Instala o Steam (Flatpak → apt steam-installer).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command steam || pkg_present dpkg steam-installer \
	|| pkg_present dpkg steam || pkg_present flatpak com.valvesoftware.Steam; then
	carcara_log "Steam already installed — skip"
	exit 0
fi

if run_with_progress "Steam (Flatpak)" flatpak_install com.valvesoftware.Steam; then
	exit 0
fi

carcara_log "Flatpak failed — trying apt steam-installer"
if run_with_progress "Steam (apt)" apt_install steam-installer; then
	exit 0
fi

carcara_err "Steam install failed"
exit 1
# Fim
