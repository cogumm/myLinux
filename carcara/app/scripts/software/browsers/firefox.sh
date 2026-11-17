#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: Firefox
# Descrição: Instala o Firefox (apt → Flatpak → Snap).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command firefox || pkg_present dpkg firefox \
	|| pkg_present flatpak org.mozilla.firefox || pkg_present snap firefox; then
	carcara_log "Firefox already installed — skip"
	exit 0
fi

if run_with_progress "Firefox (apt)" apt_install firefox; then
	exit 0
fi

carcara_log "apt failed — trying Flatpak"
if run_with_progress "Firefox (Flatpak)" flatpak_install org.mozilla.firefox; then
	exit 0
fi

carcara_log "Flatpak failed — trying Snap"
if run_with_progress "Firefox (Snap)" snap_install firefox; then
	exit 0
fi

carcara_err "Firefox install failed"
exit 1
# Fim
