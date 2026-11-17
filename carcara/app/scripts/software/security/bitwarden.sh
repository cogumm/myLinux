#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# Script: Bitwarden
# Descrição: Instala o Bitwarden Desktop (Flatpak → Snap).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command bitwarden || pkg_present flatpak com.bitwarden.desktop \
	|| pkg_present snap bitwarden; then
	carcara_log "Bitwarden already installed — skip"
	exit 0
fi

if run_with_progress "Bitwarden (Flatpak)" flatpak_install com.bitwarden.desktop; then
	exit 0
fi

carcara_log "Flatpak failed — trying Snap"
if run_with_progress "Bitwarden (Snap)" snap_install bitwarden; then
	exit 0
fi

carcara_err "Bitwarden install failed"
exit 1
# Fim
