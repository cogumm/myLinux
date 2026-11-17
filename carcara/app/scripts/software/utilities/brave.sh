#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: Brave
# Descrição: Instala o Brave Browser (apt keyring → Snap).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command brave-browser || pkg_present dpkg brave-browser \
	|| pkg_present snap brave; then
	carcara_log "Brave already installed — skip"
	exit 0
fi

arch=$(dpkg --print-architecture)
key_url="https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg"
deb_line="deb [arch=${arch} signed-by=/etc/apt/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"

# ensure_apt_keyring_repo writes /etc/apt/keyrings/<name>.gpg — use matching name.
if ensure_apt_keyring_repo brave-browser-archive-keyring "$key_url" "$deb_line" \
	&& run_with_progress "Brave (apt)" apt_install brave-browser; then
	exit 0
fi

carcara_log "apt failed — trying Snap"
if run_with_progress "Brave (Snap)" snap_install brave; then
	exit 0
fi

carcara_err "Brave install failed"
exit 1
# Fim
