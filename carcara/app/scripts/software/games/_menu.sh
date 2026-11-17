#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: games/_menu
# Descrição: Menu jogos — Steam, Heroic (Epic/GOG), Lutris (Wine/Battle.net).
#----------------------------------------------------------------------------------------------------#

while true; do
	menu=$(zenity --width=330 --height=480 --list \
		--title="$(t app.name)" \
		--column="id" --column="$(t menu.choose)" \
		--hide-column=1 --print-column=1 \
		steam "$(t install.steam)" \
		heroic "$(t install.heroic)" \
		lutris "$(t install.lutris)" \
		back "$(t menu.back)") || menu="back"

	case "$menu" in
		steam) bash app/scripts/software/games/steam.sh ;;
		heroic) bash app/scripts/software/games/heroic.sh ;;
		lutris) bash app/scripts/software/games/lutris.sh ;;
		back|*) break ;;
	esac
done
# Fim
