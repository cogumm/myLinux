#!/bin/bash
clear
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 15 de Fevereiro de 2020
# Última alteração: 16 de Novembro de 2026
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
