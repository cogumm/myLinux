#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: Termius
# Descrição: Instala o Termius SSH client (Snap → Flatpak).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command termius-app || pkg_present command termius \
	|| pkg_present snap termius-app \
	|| pkg_present flatpak com.termius.Termius; then
	carcara_log "Termius already installed — skip"
	exit 0
fi

if run_with_progress "Termius (Snap)" snap_install termius-app; then
	exit 0
fi

carcara_log "Snap failed — trying Flatpak"
if run_with_progress "Termius (Flatpak)" flatpak_install com.termius.Termius; then
	exit 0
fi

carcara_err "Termius install failed"
exit 1
# Fim
