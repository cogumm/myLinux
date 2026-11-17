#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 15 de Fevereiro de 2020
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: Dropbox
# Descrição: Instala o Dropbox (Flatpak → Snap).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command dropbox || pkg_present flatpak com.dropbox.Client \
	|| pkg_present snap dropbox; then
	carcara_log "Dropbox already installed — skip"
	exit 0
fi

if run_with_progress "Dropbox (Flatpak)" flatpak_install com.dropbox.Client; then
	exit 0
fi

carcara_log "Flatpak failed — trying Snap"
if run_with_progress "Dropbox (Snap)" snap_install dropbox; then
	exit 0
fi

carcara_err "Dropbox install failed"
exit 1
# Fim
