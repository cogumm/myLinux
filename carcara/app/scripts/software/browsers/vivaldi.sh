#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: Vivaldi
# Descrição: Instala o Vivaldi (apt keyring → Snap).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command vivaldi-stable || pkg_present command vivaldi \
	|| pkg_present dpkg vivaldi-stable || pkg_present snap vivaldi; then
	carcara_log "Vivaldi already installed — skip"
	exit 0
fi

arch=$(dpkg --print-architecture)
key_url="https://repo.vivaldi.com/archive/linux_signing_key.pub"
deb_line="deb [arch=${arch} signed-by=/etc/apt/keyrings/vivaldi.gpg] https://repo.vivaldi.com/archive/deb/ stable main"

if ensure_apt_keyring_repo vivaldi "$key_url" "$deb_line" \
	&& run_with_progress "Vivaldi (apt)" apt_install vivaldi-stable; then
	exit 0
fi

carcara_log "apt failed — trying Snap"
if run_with_progress "Vivaldi (Snap)" snap_install vivaldi; then
	exit 0
fi

carcara_err "Vivaldi install failed"
exit 1
# Fim
