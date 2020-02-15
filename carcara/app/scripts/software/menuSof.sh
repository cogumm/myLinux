#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data: 15 de Fevereiro de 2020
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: menu
# Descrição: Menu de instalação dos aplicativos de software.
# Variáveis: $menu		 : Carrega as opções do menu.
#			 $configYad	 : Carrega as configurações do Yad (sem botões).
#			 $configYadB : Carrega as configurações do Yad (com botões).
#			 $dirSof	 : Carega o diretório padrão dos scripts dos software.
#----------------------------------------------------------------------------------------------------#

while [ true ]; do
	menu=$(zenity --width=330 --height=500 --list --column "Escolha uma das opções" --title="cGm" \
			"Desenvolvimento" \
			"Produção" \
			"Social" \
			"Utilidades"  \
	    	"Voltar" )
	case "$menu" in
		"Desenvolvimento" )
			yad --text "Ainda em desenvolvimento!!!" $configYadB
			# bash app/scripts/software/development/menu.sh
		;;
		"Produção" )
			yad --text "Ainda em desenvolvimento!!!" $configYadB
            # bash app/scripts/software/productivity/menu.sh
		;;
		"Social" )
            bash app/scripts/software/social/_menu.sh
		;;
		"Utilidades" )
			# yad --text "Ainda em desenvolvimento!!!" $configYadB
            bash app/scripts/software/utilities/_menu.sh
		;;
        "Voltar" )
			bash $menuApp
		;;
	esac
done
# Fim
