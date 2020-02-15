#!/bin/bash
. app/config/config.sh
. app/config/dependences.sh
#-----------------------------------------------------------#
# Data: 05 de Setembro de 2017
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: startApp
# Descrição: Script de inicialização da aplicação.
# Variáveis: $license	 : Carrega a licensa da aplicação.
#            $configYad	 : Carrega as configurações do Yad (sem botões).
#            $menuApp       : Carrega o menu da aplicação.
#-----------------------------------------------------------#

# Carrega a primeira tela que é a licença de uso da aplicação.
#  zenity --width=600 --height=500 \
#         --text-info \
#         --title="Licença de uso" \
#         --filename=$license \
#         --checkbox="Continuar"

case $? in
    0)
        # O script só realiza esta chamada do menu se o checkbox do "Continuar" estiver selecionado.
        bash $menuApp
	;;
	* )
        yad --text "Saindo do programa" $configYad
	;;
esac
# Fim
