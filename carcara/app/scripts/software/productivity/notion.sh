#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: Notion
# Descrição: Instala o Notion (Snap → Flatpak fallback).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command notion-snap || pkg_present command notion \
	|| pkg_present snap notion-snap \
	|| pkg_present flatpak io.github.notion_enhancer.notion_repackaged; then
	carcara_log "Notion already installed — skip"
	exit 0
fi

if run_with_progress "Notion (Snap)" snap_install notion-snap; then
	exit 0
fi

carcara_log "Snap failed — trying Flatpak"
if run_with_progress "Notion (Flatpak)" flatpak_install io.github.notion_enhancer.notion_repackaged; then
	exit 0
fi

carcara_err "Notion install failed"
exit 1
# Fim
