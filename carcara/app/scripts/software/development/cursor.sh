#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: Cursor
# Descrição: Instala o Cursor IDE (vendor amd64 .deb via install_deb_url).
#----------------------------------------------------------------------------------------------------#

isRoot

if pkg_present command cursor || pkg_present dpkg cursor; then
	carcara_log "Cursor already installed — skip"
	exit 0
fi

arch=$(dpkg --print-architecture)
if [[ "$arch" != "amd64" ]]; then
	carcara_err "Cursor .deb installer supports amd64 only (got ${arch})"
	exit 1
fi

# Official Linux deb redirect (x64). Update URL here if Cursor changes the channel.
cursor_deb_url="https://downloader.cursor.sh/linux/deb/x64"

if run_with_progress "Cursor (deb)" install_deb_url cursor "$cursor_deb_url"; then
	if pkg_present command cursor || pkg_present dpkg cursor; then
		exit 0
	fi
	# dpkg package name may differ; binary is usually `cursor`.
	if command -v cursor >/dev/null 2>&1; then
		exit 0
	fi
fi

carcara_err "Cursor install failed"
exit 1
# Fim
