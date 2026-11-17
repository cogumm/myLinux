#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# Script: NordVPN
# Descrição: Instala o NordVPN (Snap → apt nordvpn se o repo existir).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command nordvpn || pkg_present snap nordvpn || pkg_present dpkg nordvpn; then
	carcara_log "NordVPN already installed — skip"
	exit 0
fi

if run_with_progress "NordVPN (Snap)" snap_install nordvpn; then
	exit 0
fi

carcara_log "Snap failed — trying apt nordvpn (repo must already be configured)"
if run_with_progress "NordVPN (apt)" apt_install nordvpn; then
	exit 0
fi

carcara_err "NordVPN install failed"
exit 1
# Fim
