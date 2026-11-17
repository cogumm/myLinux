#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# Script: presets/_menu
# Descrição: Presets Wave C — Dev / Social / Gaming light.
#----------------------------------------------------------------------------------------------------#

while true; do
	menu=$(zenity --width=330 --height=420 --list \
		--title="$(t app.name)" \
		--column="id" --column="$(t menu.choose)" \
		--hide-column=1 --print-column=1 \
		devbox "$(t install.presetDev)" \
		socialbox "$(t install.presetSocial)" \
		gaming "$(t install.presetGaming)" \
		back "$(t menu.back)") || menu="back"

	case "$menu" in
		devbox) bash app/scripts/software/presets/dev-box.sh ;;
		socialbox) bash app/scripts/software/presets/social-box.sh ;;
		gaming) bash app/scripts/software/presets/gaming-light.sh ;;
		back|*) break ;;
	esac
done
# Fim
