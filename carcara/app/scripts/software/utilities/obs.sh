#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: OBS Studio
# Descrição: Instala o OBS Studio (apt → Flatpak → Snap).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command obs || pkg_present dpkg obs-studio \
	|| pkg_present flatpak com.obsproject.Studio || pkg_present snap obs-studio; then
	carcara_log "OBS Studio already installed — skip"
	exit 0
fi

if run_with_progress "OBS Studio (apt)" apt_install obs-studio; then
	exit 0
fi

carcara_log "apt failed — trying Flatpak"
if run_with_progress "OBS Studio (Flatpak)" flatpak_install com.obsproject.Studio; then
	exit 0
fi

carcara_log "Flatpak failed — trying Snap"
if run_with_progress "OBS Studio (Snap)" snap_install obs-studio; then
	exit 0
fi

carcara_err "OBS Studio install failed"
exit 1
# Fim
