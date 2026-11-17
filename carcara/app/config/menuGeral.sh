#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 05 de Setembro de 2017
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: menu
# Descrição: Menu principal 1.x — só ações reais (sem stubs “em desenvolvimento”).
# Variáveis: $menu $configYad $configYadB $dirSys $menuSof
#----------------------------------------------------------------------------------------------------#

while true; do
	menu=$(zenity --width=330 --height=460 --list --column "Escolha uma das opções" --title="Carcará" \
			"Atualizar sistema" \
			"Instalar programas" \
			"Correção do sistema" \
			"Limpeza do sistema" \
			"Dotfiles" \
			"Sair" )
	case "$menu" in
		"Atualizar sistema" )
			bash "$dirSys/updateDistro.sh"
			;;
		"Instalar programas" )
			bash "$menuSof"
			;;
		"Limpeza do sistema" )
			bash "$dirSys/cleanDistro.sh"
			;;
		"Correção do sistema" )
			bash "$dirSys/fixSystem.sh"
			;;
		"Dotfiles" )
			bash "$dirSys/applyDotfiles.sh"
			;;
		* )
			# shellcheck disable=SC2086
			yad --text "Saindo do programa ..." $configYad
			break
			;;
	esac
done
# Fim
