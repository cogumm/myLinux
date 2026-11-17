#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 15 de Fevereiro de 2020
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: Telegram
# Descrição: Instala o Telegram Desktop (Flatpak → Snap).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command telegram-desktop || pkg_present flatpak org.telegram.desktop \
	|| pkg_present snap telegram-desktop; then
	carcara_log "Telegram already installed — skip"
	exit 0
fi

if run_with_progress "Telegram (Flatpak)" flatpak_install org.telegram.desktop; then
	exit 0
fi

carcara_log "Flatpak failed — trying Snap"
if run_with_progress "Telegram (Snap)" snap_install telegram-desktop; then
	exit 0
fi

carcara_err "Telegram install failed"
exit 1
# Fim
