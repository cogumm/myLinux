#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: Audacity
# Descrição: Instala o Audacity (apt → Flatpak → Snap).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command audacity || pkg_present dpkg audacity \
	|| pkg_present flatpak org.audacityteam.Audacity || pkg_present snap audacity; then
	carcara_log "Audacity already installed — skip"
	exit 0
fi

if run_with_progress "Audacity (apt)" apt_install audacity; then
	exit 0
fi

carcara_log "apt failed — trying Flatpak"
if run_with_progress "Audacity (Flatpak)" flatpak_install org.audacityteam.Audacity; then
	exit 0
fi

carcara_log "Flatpak failed — trying Snap"
if run_with_progress "Audacity (Snap)" snap_install audacity; then
	exit 0
fi

carcara_err "Audacity install failed"
exit 1
# Fim
