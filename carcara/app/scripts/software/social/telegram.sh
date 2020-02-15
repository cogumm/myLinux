#!/bin/bash
clear
. app/config.sh
#----------------------------------------------------------------------------------------------------#
# Data: 15 de Fevereiro de 2020
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: Telegram
# Descrição: Script para instalar o Telegram
# Variáveis: $configYad	 : Carrega as configurações do Yad (sem botões).
#----------------------------------------------------------------------------------------------------#

installTelegram() {
    if [ which -a telegram ]
    then
        yad --title "Instalando o Telegram" \
            --text "Telegram já está instalado.
                Voltando.." $configYad --timeout 3
    else

    yad --title "Instalando o Telegram" \
        --text "Bem vindo ao script de instalação do Telegram" $configYad --timeout 5

    sudo snap install telegram-desktop
    sudo snap install telegram-cli

    fi
    return
}

installTelegram
# Fim
