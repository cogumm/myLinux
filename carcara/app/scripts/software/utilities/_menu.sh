#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: utilities/_menu
# Descrição: Menu utilidades — VLC + OBS (navegadores/jogos saíram na Wave B).
#----------------------------------------------------------------------------------------------------#

while true; do
	menu=$(zenity --width=330 --height=420 --list \
		--title="$(t app.name)" \
		--column="id" --column="$(t menu.choose)" \
		--hide-column=1 --print-column=1 \
		vlc "$(t install.vlc)" \
		obs "$(t install.obs)" \
		back "$(t menu.back)") || menu="back"

	case "$menu" in
		vlc) bash app/scripts/software/utilities/vlc.sh ;;
		obs) bash app/scripts/software/utilities/obs.sh ;;
		back|*) break ;;
	esac
done
# Fim
