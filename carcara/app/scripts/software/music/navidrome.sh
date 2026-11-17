#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: Navidrome
# Descrição: Instala o Navidrome (servidor de música) — Snap → Flatpak se existir.
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command navidrome || pkg_present snap navidrome \
	|| pkg_present flatpak org.navidrome.Navidrome; then
	carcara_log "Navidrome already installed — skip"
	exit 0
fi

if run_with_progress "Navidrome (Snap)" snap_install navidrome; then
	exit 0
fi

carcara_log "Snap failed — trying Flatpak"
if run_with_progress "Navidrome (Flatpak)" flatpak_install org.navidrome.Navidrome; then
	exit 0
fi

carcara_err "Navidrome install failed (server package; Snap/Flatpak unavailable?)"
exit 1
# Fim
