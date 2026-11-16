#!/bin/bash
clear
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 15 de Fevereiro de 2020
# Última alteração: 16 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: GIT
# Descrição: Script para instalar o GIT
# Variáveis: $configYad	 : Carrega as configurações do Yad (sem botões).
#----------------------------------------------------------------------------------------------------#

installGIT() {
    yad --title "Instalando o GIT" \
        --text "Bem vindo ao script de instalação do GIT" $configYad --timeout 5

    sudo apt install -y git-core git-gui git-doc gitg

    return
}

installGIT
# Fim
