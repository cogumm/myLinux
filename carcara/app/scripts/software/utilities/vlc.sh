#!/bin/bash
clear
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 15 de Fevereiro de 2020
# Última alteração: 16 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: VLC
# Descrição: Script para instalar o VLC
# Variáveis: $configYad	 : Carrega as configurações do Yad (sem botões).
#----------------------------------------------------------------------------------------------------#

installVLC() {
    if [ which -a vlc ]
    then
        yad --title "Instalando o VLC" \
            --text "VLC já está instalado.
                Voltando.." $configYad --timeout 3
    else
        yad --title "Instalando o VLC" \
            --text "Bem vindo ao script de instalação do VLC" $configYad --timeout 5

    sudo snap install vlc

    fi
    return
}

installVLC
# Fim
