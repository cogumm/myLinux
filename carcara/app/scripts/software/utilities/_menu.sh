#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 15 de Fevereiro de 2020
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: utilities/_menu
# Descrição: Menu de instalação dos aplicativos de utilidades.
#----------------------------------------------------------------------------------------------------#

while true; do
	menu=$(zenity --width=330 --height=500 --list --column "Escolha uma das opções" --title="cGm" \
		"Instalar o VLC" \
		"Voltar")
	case "$menu" in
		"Instalar o VLC")
			bash app/scripts/software/utilities/vlc.sh
			;;
		"Voltar"|*)
			break
			;;
	esac
done
# Fim
