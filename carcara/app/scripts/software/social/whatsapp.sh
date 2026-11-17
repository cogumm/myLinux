#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: WhatsApp
# Descrição: Instala o WhatsApp Desktop (Flatpak → Snap).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command whatsapp-linux-app \
	|| pkg_present flatpak com.whatsapp.WhatsApp \
	|| pkg_present snap whatsapp-linux-app; then
	carcara_log "WhatsApp already installed — skip"
	exit 0
fi

if run_with_progress "WhatsApp (Flatpak)" flatpak_install com.whatsapp.WhatsApp; then
	exit 0
fi

carcara_log "Flatpak failed — trying Snap"
if run_with_progress "WhatsApp (Snap)" snap_install whatsapp-linux-app; then
	exit 0
fi

carcara_err "WhatsApp install failed"
exit 1
# Fim
