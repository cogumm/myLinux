#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# Script: productivity/_menu
# Descrição: Menu produção — Wave A + LibreOffice / OnlyOffice.
#----------------------------------------------------------------------------------------------------#

while true; do
	menu=$(zenity --width=330 --height=560 --list \
		--title="$(t app.name)" \
		--column="id" --column="$(t menu.choose)" \
		--hide-column=1 --print-column=1 \
		dropbox "$(t install.dropbox)" \
		anki "$(t install.anki)" \
		notion "$(t install.notion)" \
		thunderbird "$(t install.thunderbird)" \
		libreoffice "$(t install.libreoffice)" \
		onlyoffice "$(t install.onlyoffice)" \
		back "$(t menu.back)") || menu="back"

	case "$menu" in
		dropbox) bash app/scripts/software/productivity/dropbox.sh ;;
		anki) bash app/scripts/software/productivity/anki.sh ;;
		notion) bash app/scripts/software/productivity/notion.sh ;;
		thunderbird) bash app/scripts/software/productivity/thunderbird.sh ;;
		libreoffice) bash app/scripts/software/productivity/libreoffice.sh ;;
		onlyoffice) bash app/scripts/software/productivity/onlyoffice.sh ;;
		back|*) break ;;
	esac
done
# Fim
