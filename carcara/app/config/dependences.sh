#!/bin/bash
#---------------------------------------------------------------------------#
# Data: 15 de Fevereiro de 2020
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: config
# Descrição: Arquivo das dependencias do projeto.
#---------------------------------------------------------------------------#

dependences() {
    bash app/config/testConnection.sh
    dependencias=$(dpkg --get-selections | grep -c yad | grep -c curl | grep -c snap)
    if [ which -a dependencias ]
    then
        yad --title "Instalador de dependências." \
            "Programas de dependências do projeto já instalados." $configYadB --timeout 3
    else
        echo "Instalador de dependência do projeto."
        sudo apt install yad -y
        sudo apt install curl -y
        sudo apt install snap -y
    fi

    yad --text  "Programas de dependências do projeto já instalados." $configYadB
    return
}

dependences
# Fim