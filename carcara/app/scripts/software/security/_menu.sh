#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# Script: security/_menu
# Descrição: Menu segurança — Bitwarden + 1Password.
#----------------------------------------------------------------------------------------------------#

while true; do
	menu=$(zenity --width=330 --height=420 --list \
		--title="$(t app.name)" \
		--column="id" --column="$(t menu.choose)" \
		--hide-column=1 --print-column=1 \
		bitwarden "$(t install.bitwarden)" \
		onepassword "$(t install.onepassword)" \
		back "$(t menu.back)") || menu="back"

	case "$menu" in
		bitwarden) bash app/scripts/software/security/bitwarden.sh ;;
		onepassword) bash app/scripts/software/security/onepassword.sh ;;
		back|*) break ;;
	esac
done
# Fim
