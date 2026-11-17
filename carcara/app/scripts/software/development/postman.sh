#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: Postman
# Descrição: Instala o Postman (Flatpak → Snap). Insomnia permanece no catálogo.
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command postman || pkg_present flatpak com.getpostman.Postman \
	|| pkg_present snap postman; then
	carcara_log "Postman already installed — skip"
	exit 0
fi

if run_with_progress "Postman (Flatpak)" flatpak_install com.getpostman.Postman; then
	exit 0
fi

carcara_log "Flatpak failed — trying Snap"
if run_with_progress "Postman (Snap)" snap_install postman; then
	exit 0
fi

carcara_err "Postman install failed"
exit 1
# Fim
