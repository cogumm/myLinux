#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: Heroic
# Descrição: Instala o Heroic Games Launcher (Epic + GOG) — Flatpak → Snap.
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command heroic \
	|| pkg_present flatpak com.heroicgameslauncher.hgl \
	|| pkg_present snap heroic; then
	carcara_log "Heroic already installed — skip"
	exit 0
fi

if run_with_progress "Heroic (Flatpak)" flatpak_install com.heroicgameslauncher.hgl; then
	exit 0
fi

carcara_log "Flatpak failed — trying Snap"
if run_with_progress "Heroic (Snap)" snap_install heroic; then
	exit 0
fi

carcara_err "Heroic install failed"
exit 1
# Fim
