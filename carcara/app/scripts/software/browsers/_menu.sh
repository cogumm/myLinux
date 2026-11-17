#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: browsers/_menu
# Descrição: Menu navegadores — Firefox, Brave, Vivaldi, Opera, Zen.
#----------------------------------------------------------------------------------------------------#

while true; do
	menu=$(zenity --width=330 --height=520 --list \
		--title="$(t app.name)" \
		--column="id" --column="$(t menu.choose)" \
		--hide-column=1 --print-column=1 \
		firefox "$(t install.firefox)" \
		brave "$(t install.brave)" \
		vivaldi "$(t install.vivaldi)" \
		opera "$(t install.opera)" \
		zen "$(t install.zen)" \
		back "$(t menu.back)") || menu="back"

	case "$menu" in
		firefox) bash app/scripts/software/browsers/firefox.sh ;;
		brave) bash app/scripts/software/browsers/brave.sh ;;
		vivaldi) bash app/scripts/software/browsers/vivaldi.sh ;;
		opera) bash app/scripts/software/browsers/opera.sh ;;
		zen) bash app/scripts/software/browsers/zen.sh ;;
		back|*) break ;;
	esac
done
# Fim
