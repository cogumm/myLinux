#!/bin/bash
clear
. app/config.sh
#----------------------------------------------------------------------------------------------------#
# Data: 15 de Fevereiro de 2020
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: Dropbox
# Descrição: Script para instalar o Dropbox
# Variáveis: $configYad	 : Carrega as configurações do Yad (sem botões).
#----------------------------------------------------------------------------------------------------#

installDropbox() {
    yad --title "Instalando o Driobox" \
		--text "Bem vindo ao script de instalação do Driobox" $configYad --timeout 5

    cd ~
    if [ -e temp ]
    then
        echo "Diretório já existe."
        cd ~/temp/
    else
        mkdir temp
        cd ~/temp/
    fi

    cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
    ~/.dropbox-dist/dropboxd

    cd ~
    sudo rm -rf ~/temp/

    return
}

installDropbox
# Fim
