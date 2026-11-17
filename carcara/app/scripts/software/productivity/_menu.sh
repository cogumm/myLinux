#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: productivity/_menu
# Descrição: Menu produção — i18n (+ Wave A).
#----------------------------------------------------------------------------------------------------#

while true; do
	menu=$(zenity --width=330 --height=520 --list \
		--title="$(t app.name)" \
		--column="id" --column="$(t menu.choose)" \
		--hide-column=1 --print-column=1 \
		dropbox "$(t install.dropbox)" \
		anki "$(t install.anki)" \
		notion "$(t install.notion)" \
		thunderbird "$(t install.thunderbird)" \
		back "$(t menu.back)") || menu="back"

	case "$menu" in
		dropbox) bash app/scripts/software/productivity/dropbox.sh ;;
		anki) bash app/scripts/software/productivity/anki.sh ;;
		notion) bash app/scripts/software/productivity/notion.sh ;;
		thunderbird) bash app/scripts/software/productivity/thunderbird.sh ;;
		back|*) break ;;
	esac
done
# Fim
