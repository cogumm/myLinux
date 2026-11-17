#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 10 de Fevereiro de 2018
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: Spotify
# Descrição: Instala o Spotify (apt keyring → Flatpak → Snap).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command spotify || pkg_present dpkg spotify-client \
	|| pkg_present flatpak com.spotify.Client || pkg_present snap spotify; then
	carcara_log "Spotify already installed — skip"
	exit 0
fi

key_url="https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg"
deb_line="deb [signed-by=/etc/apt/keyrings/spotify.gpg] http://repository.spotify.com stable non-free"

if ensure_apt_keyring_repo spotify "$key_url" "$deb_line" \
	&& run_with_progress "Spotify (apt)" apt_install spotify-client; then
	exit 0
fi

carcara_log "apt failed — trying Flatpak"
if run_with_progress "Spotify (Flatpak)" flatpak_install com.spotify.Client; then
	exit 0
fi

carcara_log "Flatpak failed — trying Snap"
if run_with_progress "Spotify (Snap)" snap_install spotify; then
	exit 0
fi

carcara_err "Spotify install failed"
exit 1
# Fim
