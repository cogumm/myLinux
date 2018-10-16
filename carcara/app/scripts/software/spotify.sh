#!/bin/bash
clear
. app/config.sh
#----------------------------------------------------------------------------------------------------#
# Data: 10 de Fevereiro de 2018
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: spotify
# Descrição: Script para instalar o Spotify
# Variáveis: $configYad	 : Carrega as configurações do Yad (sem botões).
#----------------------------------------------------------------------------------------------------#

installSpotify() {
    yad --title Instalando o Spotify" \
		--text "Bem vindo ao script de instalação do Spotify" $configYad --timeout 5

    sudo rm -r /etc/apt/sources.list.d/spotify*
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410
    echo deb http://r...content-available-to-author-only...y.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt update
    sudo apt install -y --reinstall spotify-client
    echo '
    # Spotify
    0.0.0.0 pubads.g.doubleclick.net
    0.0.0.0 securepubads.g.doubleclick.net
    0.0.0.0 gads.pubmatic.com
    0.0.0.0 ads.pubmatic.com
    0.0.0.0 spclient.wg.spotify.com' | sudo tee -a /etc/hosts





}

installSpotify
# Fim
