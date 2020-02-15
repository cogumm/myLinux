#!/bin/bash
clear
. app/config.sh
#----------------------------------------------------------------------------------------------------#
# Data: 15 de Fevereiro de 2020
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: Discord
# Descrição: Script para instalar o Discord
# Variáveis: $configYad	 : Carrega as configurações do Yad (sem botões).
#----------------------------------------------------------------------------------------------------#

installDiscord() {
    if [ which -a discord ]
    then
        yad --title "Instalando o Discord" \
            --text "Discord já está instalado.
                Voltando.." $configYad --timeout 3
    else

    yad --title "Instalando o Discord" \
        --text "Bem vindo ao script de instalação do Discord" $configYad --timeout 5

    sudo snap install discord

    fi
    return
}

installDiscord
# Fim
