#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 15 de Fevereiro de 2020
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: VLC
# Descrição: Instala o VLC (apt → Flatpak → Snap).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command vlc || pkg_present dpkg vlc \
	|| pkg_present flatpak org.videolan.VLC || pkg_present snap vlc; then
	carcara_log "VLC already installed — skip"
	exit 0
fi

if run_with_progress "VLC (apt)" apt_install vlc; then
	exit 0
fi

carcara_log "apt failed — trying Flatpak"
if run_with_progress "VLC (Flatpak)" flatpak_install org.videolan.VLC; then
	exit 0
fi

carcara_log "Flatpak failed — trying Snap"
if run_with_progress "VLC (Snap)" snap_install vlc; then
	exit 0
fi

carcara_err "VLC install failed"
exit 1
# Fim
