#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 15 de Fevereiro de 2020
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: Insomnia
# Descrição: Instala o Insomnia (Flatpak → Snap).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command insomnia || pkg_present flatpak rest.insomnia.Insomnia \
	|| pkg_present snap insomnia; then
	carcara_log "Insomnia already installed — skip"
	exit 0
fi

if run_with_progress "Insomnia (Flatpak)" flatpak_install rest.insomnia.Insomnia; then
	exit 0
fi

carcara_log "Flatpak failed — trying Snap"
if run_with_progress "Insomnia (Snap)" snap_install insomnia; then
	exit 0
fi

carcara_err "Insomnia install failed"
exit 1
# Fim
