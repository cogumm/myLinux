#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: Anki
# Descrição: Instala o Anki (Flatpak → Snap). Não usa .deb antigo de old/.
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command anki || pkg_present flatpak net.ankiweb.Anki \
	|| pkg_present snap anki; then
	carcara_log "Anki already installed — skip"
	exit 0
fi

if run_with_progress "Anki (Flatpak)" flatpak_install net.ankiweb.Anki; then
	exit 0
fi

carcara_log "Flatpak failed — trying Snap"
if run_with_progress "Anki (Snap)" snap_install anki; then
	exit 0
fi

carcara_err "Anki install failed"
exit 1
# Fim
