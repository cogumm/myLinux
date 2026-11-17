#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 15 de Fevereiro de 2020
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: Discord
# Descrição: Instala o Discord (Flatpak → Snap).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command discord || pkg_present flatpak com.discordapp.Discord \
	|| pkg_present snap discord; then
	carcara_log "Discord already installed — skip"
	exit 0
fi

if run_with_progress "Discord (Flatpak)" flatpak_install com.discordapp.Discord; then
	exit 0
fi

carcara_log "Flatpak failed — trying Snap"
if run_with_progress "Discord (Snap)" snap_install discord; then
	exit 0
fi

carcara_err "Discord install failed"
exit 1
# Fim
