#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 15 de Fevereiro de 2020
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: GIT
# Descrição: Instala Git e ferramentas GUI via apt.
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command git && pkg_present dpkg git; then
	carcara_log "Git already installed — refreshing related packages"
fi

if run_with_progress "Git (apt)" apt_install git git-gui git-doc gitg; then
	exit 0
fi

carcara_err "Git install failed"
exit 1
# Fim
