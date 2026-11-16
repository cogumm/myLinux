#!/bin/bash
. app/config/config.sh
. app/config/dependences.sh
#-----------------------------------------------------------#
# Data criação: 05 de Setembro de 2017
# Última alteração: 16 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: startApp
# Descrição: Script de inicialização da aplicação.
# Variáveis: $license   : Arquivo de licença de uso
#            $configYad : Configurações Yad (sem botões)
#            $menuApp   : Menu principal (menuGeral.sh)
#-----------------------------------------------------------#

# Licença de uso — checkbox "Continuar" obrigatório para abrir o menu.
if zenity --width=600 --height=500 \
	--text-info \
	--title="Licença de uso" \
	--filename="$license" \
	--checkbox="Continuar"; then
	bash "$menuApp"
else
	yad --text "Saindo do programa" $configYad
fi
# Fim
