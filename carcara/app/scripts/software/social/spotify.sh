#!/bin/bash
clear
. app/config.sh
#----------------------------------------------------------------------------------------------------#
# Data: 10 de Fevereiro de 2018
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: Spotify
# Descrição: Script para instalar o Spotify
# Variáveis: $configYad	 : Carrega as configurações do Yad (sem botões).
#----------------------------------------------------------------------------------------------------#

installSpotify() {
    if [ which -a spotify ]
    then
        yad --title "Instalando o Spotify" \
            --text "Spotify já está instalado.
                Voltando.." $configYad --timeout 3
    else

    yad --title "Instalando o Spotify" \
        --text "Bem vindo ao script de instalação do Spotify" $configYad --timeout 5

    curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

    sudo apt-get update
    sudo apt-get install spotify-client

    fi
    return
}

installSpotify
# Fim
