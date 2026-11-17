#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# Script: 1Password
# Descrição: Instala o 1Password (vendor .deb → Flatpak se existir).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command 1password || pkg_present dpkg 1password \
	|| pkg_present flatpak com.onepassword.OnePassword; then
	carcara_log "1Password already installed — skip"
	exit 0
fi

arch=$(dpkg --print-architecture)
if [[ "$arch" == "amd64" ]]; then
	op_deb="https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb"
	if run_with_progress "1Password (deb)" install_deb_url 1password "$op_deb"; then
		if pkg_present command 1password || pkg_present dpkg 1password; then
			exit 0
		fi
	fi
	carcara_log "deb failed — trying Flatpak"
fi

if run_with_progress "1Password (Flatpak)" flatpak_install com.onepassword.OnePassword; then
	exit 0
fi

carcara_err "1Password install failed"
exit 1
# Fim
