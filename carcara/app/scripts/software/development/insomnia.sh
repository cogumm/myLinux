#!/bin/bash
clear
. app/config.sh
#----------------------------------------------------------------------------------------------------#
# Data: 15 de Fevereiro de 2020
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: Insomnia
# Descrição: Script para instalar o Insomnia
# Variáveis: $configYad	 : Carrega as configurações do Yad (sem botões).
#----------------------------------------------------------------------------------------------------#

installInsomnia() {
    yad --title "Instalando o Insomnia" \
        --text "Bem vindo ao script de instalação do Insomnia" $configYad --timeout 5

    sudo snap install insomnia

    return
}

installInsomnia
# Fim
