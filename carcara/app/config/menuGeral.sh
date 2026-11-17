#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 05 de Setembro de 2017
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: menu
# Descrição: Menu principal 1.x — i18n via t(); IDs estáveis no Zenity.
# Variáveis: $menu $configYad $dirSys $menuSof ; CARCARA_LANG
#----------------------------------------------------------------------------------------------------#

while true; do
	menu=$(zenity --width=330 --height=460 --list \
		--title="$(t app.name)" \
		--column="id" --column="$(t menu.choose)" \
		--hide-column=1 --print-column=1 \
		update "$(t menu.update)" \
		install "$(t menu.install)" \
		fix "$(t menu.fix)" \
		clean "$(t menu.clean)" \
		dotfiles "$(t menu.dotfiles)" \
		exit "$(t menu.exit)") || menu="exit"

	case "$menu" in
		update)
			bash "$dirSys/updateDistro.sh"
			;;
		install)
			bash "$menuSof"
			;;
		clean)
			bash "$dirSys/cleanDistro.sh"
			;;
		fix)
			bash "$dirSys/fixSystem.sh"
			;;
		dotfiles)
			bash "$dirSys/applyDotfiles.sh"
			;;
		*)
			# shellcheck disable=SC2086
			yad --text "$(t menu.exiting)" $configYad
			break
			;;
	esac
done
# Fim
