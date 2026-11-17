#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# Script: Proton VPN
# Descrição: Instala o Proton VPN (Flatpak → Snap).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command protonvpn-app || pkg_present command protonvpn \
	|| pkg_present flatpak com.protonvpn.www \
	|| pkg_present snap proton-vpn; then
	carcara_log "Proton VPN already installed — skip"
	exit 0
fi

if run_with_progress "Proton VPN (Flatpak)" flatpak_install com.protonvpn.www; then
	exit 0
fi

carcara_log "Flatpak failed — trying Snap"
if run_with_progress "Proton VPN (Snap)" snap_install proton-vpn; then
	exit 0
fi

carcara_err "Proton VPN install failed"
exit 1
# Fim
