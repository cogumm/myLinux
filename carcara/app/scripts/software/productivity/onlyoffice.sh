#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# Script: OnlyOffice
# Descrição: Instala o OnlyOffice Desktop (Flatpak → Snap).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command onlyoffice-desktopeditors \
	|| pkg_present flatpak org.onlyoffice.desktopeditors \
	|| pkg_present snap onlyoffice-desktopeditors; then
	carcara_log "OnlyOffice already installed — skip"
	exit 0
fi

if run_with_progress "OnlyOffice (Flatpak)" flatpak_install org.onlyoffice.desktopeditors; then
	exit 0
fi

carcara_log "Flatpak failed — trying Snap"
if run_with_progress "OnlyOffice (Snap)" snap_install onlyoffice-desktopeditors; then
	exit 0
fi

carcara_err "OnlyOffice install failed"
exit 1
# Fim
