#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 15 de Fevereiro de 2020
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: menuSof
# Descrição: Menu de software — i18n (t) + IDs Zenity.
#----------------------------------------------------------------------------------------------------#

while true; do
	menu=$(zenity --width=330 --height=500 --list \
		--title="$(t app.name)" \
		--column="id" --column="$(t menu.choose)" \
		--hide-column=1 --print-column=1 \
		development "$(t sof.development)" \
		productivity "$(t sof.productivity)" \
		social "$(t sof.social)" \
		utilities "$(t sof.utilities)" \
		back "$(t menu.back)") || menu="back"

	case "$menu" in
		development)
			bash app/scripts/software/development/_menu.sh
			;;
		productivity)
			bash app/scripts/software/productivity/_menu.sh
			;;
		social)
			bash app/scripts/software/social/_menu.sh
			;;
		utilities)
			bash app/scripts/software/utilities/_menu.sh
			;;
		back|*)
			break
			;;
	esac
done
# Fim
