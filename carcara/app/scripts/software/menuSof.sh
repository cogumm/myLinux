#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 15 de Fevereiro de 2020
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: menuSof
# Descrição: Menu de instalação dos aplicativos de software.
# Variáveis: $menu $configYad $configYadB $dirSof $menuSof $menuApp
#----------------------------------------------------------------------------------------------------#

while true; do
	menu=$(zenity --width=330 --height=500 --list --column "Escolha uma das opções" --title="cGm" \
		"Desenvolvimento" \
		"Produção" \
		"Social" \
		"Utilidades" \
		"Voltar")
	case "$menu" in
		"Desenvolvimento")
			bash app/scripts/software/development/_menu.sh
			;;
		"Produção")
			bash app/scripts/software/productivity/_menu.sh
			;;
		"Social")
			bash app/scripts/software/social/_menu.sh
			;;
		"Utilidades")
			bash app/scripts/software/utilities/_menu.sh
			;;
		"Voltar"|*)
			# Return to parent menuGeral loop (this script was started with bash).
			break
			;;
	esac
done
# Fim

