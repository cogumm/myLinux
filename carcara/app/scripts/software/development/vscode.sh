#!/bin/bash
clear
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 15 de Fevereiro de 2020
# Última alteração: 16 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: VSCode
# Descrição: Script para instalar o VSCode
# Variáveis: $configYad	 : Carrega as configurações do Yad (sem botões).
#----------------------------------------------------------------------------------------------------#

installVSCode() {
    yad --title "Instalando o Visual Code" \
        --text "Bem vindo ao script de instalação do Visual Code" $configYad --timeout 5

    sudo snap install code --classic
    sudo snap refresh code

    return
}

installVSCode
# Fim
