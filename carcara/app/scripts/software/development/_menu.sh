#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: development/_menu
# Descrição: Menu de instalação dos aplicativos de desenvolvimento.
# Variáveis: $menuSof : volta ao menu de software
#----------------------------------------------------------------------------------------------------#

while true; do
	menu=$(zenity --width=330 --height=500 --list --column "Escolha uma das opções" --title="cGm" \
		"Instalar o Git" \
		"Instalar o VS Code" \
		"Instalar o Insomnia" \
		"Instalar a Fira Code" \
		"Voltar")
	case "$menu" in
		"Instalar o Git")
			bash app/scripts/software/development/git.sh
			;;
		"Instalar o VS Code")
			bash app/scripts/software/development/vscode.sh
			;;
		"Instalar o Insomnia")
			bash app/scripts/software/development/insomnia.sh
			;;
		"Instalar a Fira Code")
			bash app/scripts/software/development/firacode.sh
			;;
		"Voltar"|*)
			# Return to parent menuSof loop (this script was started with bash).
			break
			;;
	esac
done
# Fim
