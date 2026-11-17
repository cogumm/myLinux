#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: Lutris
# Descrição: Instala o Lutris (Wine runners; Battle.net etc.) — Flatpak → apt.
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command lutris || pkg_present dpkg lutris \
	|| pkg_present flatpak net.lutris.Lutris; then
	carcara_log "Lutris already installed — skip"
	exit 0
fi

if run_with_progress "Lutris (Flatpak)" flatpak_install net.lutris.Lutris; then
	exit 0
fi

carcara_log "Flatpak failed — trying apt"
if run_with_progress "Lutris (apt)" apt_install lutris; then
	exit 0
fi

carcara_err "Lutris install failed"
exit 1
# Fim
