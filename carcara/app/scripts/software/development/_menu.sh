#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# Script: development/_menu
# Descrição: Menu desenvolvimento — Wave A + Node toolchain.
#----------------------------------------------------------------------------------------------------#

while true; do
	menu=$(zenity --width=330 --height=600 --list \
		--title="$(t app.name)" \
		--column="id" --column="$(t menu.choose)" \
		--hide-column=1 --print-column=1 \
		git "$(t install.git)" \
		vscode "$(t install.vscode)" \
		cursor "$(t install.cursor)" \
		insomnia "$(t install.insomnia)" \
		postman "$(t install.postman)" \
		termius "$(t install.termius)" \
		firacode "$(t install.firacode)" \
		nodejs "$(t install.nodejs)" \
		docker "$(t install.docker)" \
		back "$(t menu.back)") || menu="back"

	case "$menu" in
		git) bash app/scripts/software/development/git.sh ;;
		vscode) bash app/scripts/software/development/vscode.sh ;;
		cursor) bash app/scripts/software/development/cursor.sh ;;
		insomnia) bash app/scripts/software/development/insomnia.sh ;;
		postman) bash app/scripts/software/development/postman.sh ;;
		termius) bash app/scripts/software/development/termius.sh ;;
		firacode) bash app/scripts/software/development/firacode.sh ;;
		nodejs) bash app/scripts/software/development/nodejs.sh ;;
		docker) bash app/scripts/software/development/docker.sh ;;
		back|*) break ;;
	esac
done
# Fim
