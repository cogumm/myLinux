#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: development/_menu
# Descrição: Menu desenvolvimento — i18n.
#----------------------------------------------------------------------------------------------------#

while true; do
	menu=$(zenity --width=330 --height=520 --list \
		--title="$(t app.name)" \
		--column="id" --column="$(t menu.choose)" \
		--hide-column=1 --print-column=1 \
		git "$(t install.git)" \
		vscode "$(t install.vscode)" \
		insomnia "$(t install.insomnia)" \
		firacode "$(t install.firacode)" \
		docker "$(t install.docker)" \
		back "$(t menu.back)") || menu="back"

	case "$menu" in
		git) bash app/scripts/software/development/git.sh ;;
		vscode) bash app/scripts/software/development/vscode.sh ;;
		insomnia) bash app/scripts/software/development/insomnia.sh ;;
		firacode) bash app/scripts/software/development/firacode.sh ;;
		docker) bash app/scripts/software/development/docker.sh ;;
		back|*) break ;;
	esac
done
# Fim
