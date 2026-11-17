#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: music/_menu
# Descrição: Menu música e áudio — Audacity, Navidrome (Spotify permanece em Social).
#----------------------------------------------------------------------------------------------------#

while true; do
	menu=$(zenity --width=330 --height=420 --list \
		--title="$(t app.name)" \
		--column="id" --column="$(t menu.choose)" \
		--hide-column=1 --print-column=1 \
		audacity "$(t install.audacity)" \
		navidrome "$(t install.navidrome)" \
		back "$(t menu.back)") || menu="back"

	case "$menu" in
		audacity) bash app/scripts/software/music/audacity.sh ;;
		navidrome) bash app/scripts/software/music/navidrome.sh ;;
		back|*) break ;;
	esac
done
# Fim
