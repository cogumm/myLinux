#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: Opera
# Descrição: Instala o Opera (Snap → Flatpak). Tile 2.0: Opera GX (Linux via Opera snap/flatpak).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command opera || pkg_present snap opera \
	|| pkg_present flatpak com.opera.Opera; then
	carcara_log "Opera already installed — skip"
	exit 0
fi

if run_with_progress "Opera (Snap)" snap_install opera; then
	exit 0
fi

carcara_log "Snap failed — trying Flatpak"
if run_with_progress "Opera (Flatpak)" flatpak_install com.opera.Opera; then
	exit 0
fi

carcara_err "Opera install failed"
exit 1
# Fim
