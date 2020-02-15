#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data: 15 de Fevereiro de 2020
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: menu
# Descrição: Menu de instalação dos aplicativos social.
# Variáveis: $menuSof   : Volta pro menu de software.
#----------------------------------------------------------------------------------------------------#

while [ true ]; do
	menu=$(zenity --width=330 --height=500 --list --column "Escolha uma das opções" --title="cGm" \
			"Instalar o Discord" \
			"Instalar o Spotify" \
			"Instalar o Telegram" \
	    	"Voltar" )
	case "$menu" in
		"Instalar o Discord" )
			bash app/scripts/software/social/discord.sh
		;;
		"Instalar o Spotify" )
			bash app/scripts/software/social/spotify.sh
		;;
		"Instalar o Telegram" )
			bash app/scripts/software/social/telegram.sh
		;;
        "Voltar" )
			bash $menuSof
		;;
	esac
done
# Fim
