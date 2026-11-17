#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# Script: LibreOffice
# Descrição: Instala o LibreOffice (apt → Flatpak).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command libreoffice || pkg_present dpkg libreoffice-core \
	|| pkg_present flatpak org.libreoffice.LibreOffice; then
	carcara_log "LibreOffice already installed — skip"
	exit 0
fi

if run_with_progress "LibreOffice (apt)" apt_install libreoffice; then
	exit 0
fi

carcara_log "apt failed — trying Flatpak"
if run_with_progress "LibreOffice (Flatpak)" flatpak_install org.libreoffice.LibreOffice; then
	exit 0
fi

carcara_err "LibreOffice install failed"
exit 1
# Fim
