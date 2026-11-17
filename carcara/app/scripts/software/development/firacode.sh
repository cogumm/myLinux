#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 15 de Fevereiro de 2020
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: Font Fira Code
# Descrição: Instala a fonte Fira Code via apt (fonts-firacode).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present dpkg fonts-firacode; then
	carcara_log "fonts-firacode already installed — skip"
	exit 0
fi

if run_with_progress "Fira Code (apt)" apt_install fonts-firacode; then
	exit 0
fi

carcara_err "Fira Code install failed (fonts-firacode unavailable?)"
exit 1
# Fim
