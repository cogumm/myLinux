#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: Thunderbird
# Descrição: Instala o Thunderbird (apt → Flatpak → Snap).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command thunderbird || pkg_present dpkg thunderbird \
	|| pkg_present flatpak org.mozilla.Thunderbird || pkg_present snap thunderbird; then
	carcara_log "Thunderbird already installed — skip"
	exit 0
fi

if run_with_progress "Thunderbird (apt)" apt_install thunderbird; then
	exit 0
fi

carcara_log "apt failed — trying Flatpak"
if run_with_progress "Thunderbird (Flatpak)" flatpak_install org.mozilla.Thunderbird; then
	exit 0
fi

carcara_log "Flatpak failed — trying Snap"
if run_with_progress "Thunderbird (Snap)" snap_install thunderbird; then
	exit 0
fi

carcara_err "Thunderbird install failed"
exit 1
# Fim
