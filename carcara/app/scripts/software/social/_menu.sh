#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: social/_menu
# Descrição: Menu social — i18n.
#----------------------------------------------------------------------------------------------------#

while true; do
	menu=$(zenity --width=330 --height=500 --list \
		--title="$(t app.name)" \
		--column="id" --column="$(t menu.choose)" \
		--hide-column=1 --print-column=1 \
		discord "$(t install.discord)" \
		spotify "$(t install.spotify)" \
		telegram "$(t install.telegram)" \
		back "$(t menu.back)") || menu="back"

	case "$menu" in
		discord) bash app/scripts/software/social/discord.sh ;;
		spotify) bash app/scripts/software/social/spotify.sh ;;
		telegram) bash app/scripts/software/social/telegram.sh ;;
		back|*) break ;;
	esac
done
# Fim
