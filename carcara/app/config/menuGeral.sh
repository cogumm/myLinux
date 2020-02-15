#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data: 05 de Setembro de 2017
# Última alteração: 15 de Fevereiro de 2020
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: menu
# Descrição: Menu da aplicação, aqui é carregado o menu com os seus respectivos scripts da aplicação
# Variáveis: $menu		 : Carrega as opções do menu.
#			 $configYad	 : Carrega as configurações do Yad (sem botões).
#			 $configYadB : Carrega as configurações do Yad (com botões).
#			 $dirSys	 : Carega o diretório padrão dos scripts para o sistema.
#			 $menuSof	 : Carega o diretório padrão dos scripts dos software.
#----------------------------------------------------------------------------------------------------#

while [ true ]; do
	menu=$(zenity --width=330 --height=500 --list --column "Escolha uma das opções" --title="cGm" \
			"Atualizar sistema" \
			"Instalar programas de desenvolvimento" \
			"Instalar programas diversos" \
			"Correção do sistema"  \
			"Limpeza do sistema" \
			"Limpeza de memória" \
	    	"Sair" )
	case "$menu" in
		"Atualizar sistema" )
			# bash $dirSys/testConnection.sh
			bash $dirSys/updateDistro.sh
		;;
		"Instalar programas de desenvolvimento" )
			# yad --text "Ainda em desenvolvimento!!!" $configYadB
			bash $menuSof
		;;
		"Instalar programas diversos" )
			yad --text "Ainda em desenvolvimento!!!" $configYadB
		;;
		"Limpeza do sistema" )
			bash $dirSys/cleanDistro.sh
		;;
		"Correção do sistema" )
			bash $dirSys/fixSystem.sh
		;;
		"Limpeza de memória" )
			yad --text "Ainda em desenvolvimento!!!" $configYadB
		;;
		* )
			yad --text "Saindo do programa ..." $configYad
			break
		;;
	esac
done
# Fim
