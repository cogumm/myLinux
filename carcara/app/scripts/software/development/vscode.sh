#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 15 de Fevereiro de 2020
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: VSCode
# Descrição: Instala o VS Code (Microsoft apt → Snap classic).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command code || pkg_present dpkg code || pkg_present snap code; then
	carcara_log "VS Code already installed — skip"
	exit 0
fi

arch=$(dpkg --print-architecture)
key_url="https://packages.microsoft.com/keys/microsoft.asc"
deb_line="deb [arch=${arch} signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main"

if ensure_apt_keyring_repo packages.microsoft "$key_url" "$deb_line" \
	&& run_with_progress "VS Code (apt)" apt_install code; then
	exit 0
fi

carcara_log "apt failed — trying Snap"
if run_with_progress "VS Code (Snap)" snap_install code --classic; then
	exit 0
fi

carcara_err "VS Code install failed"
exit 1
# Fim
