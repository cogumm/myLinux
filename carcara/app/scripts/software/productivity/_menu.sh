#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: productivity/_menu
# Descrição: Menu de instalação dos aplicativos de produtividade.
# Variáveis: $menuSof : volta ao menu de software
#----------------------------------------------------------------------------------------------------#

while true; do
	menu=$(zenity --width=330 --height=500 --list --column "Escolha uma das opções" --title="cGm" \
		"Instalar o Dropbox" \
		"Voltar")
	case "$menu" in
		"Instalar o Dropbox")
			bash app/scripts/software/productivity/dropbox.sh
			;;
		"Voltar"|*)
			# Return to parent menuSof loop (this script was started with bash).
			break
			;;
	esac
done
# Fim
