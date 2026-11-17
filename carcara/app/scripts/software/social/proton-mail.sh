#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# Script: Proton Mail
# Descrição: Instala o Proton Mail (Flatpak → Snap).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command proton-mail || pkg_present flatpak me.proton.Mail \
	|| pkg_present snap proton-mail; then
	carcara_log "Proton Mail already installed — skip"
	exit 0
fi

if run_with_progress "Proton Mail (Flatpak)" flatpak_install me.proton.Mail; then
	exit 0
fi

carcara_log "Flatpak failed — trying Snap"
if run_with_progress "Proton Mail (Snap)" snap_install proton-mail; then
	exit 0
fi

carcara_err "Proton Mail install failed"
exit 1
# Fim
