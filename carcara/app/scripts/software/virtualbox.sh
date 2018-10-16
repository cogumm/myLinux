#!/bin/bash
clear
. ~/dev/myLinux/carcara/app/config.sh
#----------------------------------------------------------------------------------------------------#
# Data: 10 de Fevereiro de 2018
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: virtualbox
# Descrição: Script para instalar o VirtualBox
# Variáveis: $configYad	 : Carrega as configurações do Yad (sem botões).
#----------------------------------------------------------------------------------------------------#

installVB() {

    if [ which -a virtualbox ]
    then
        yad --title "Instalando o VirtualBox" \
    		--text "VirtualBox já está instalado.
Saindo.." $configYad --timeout 3
    else
        yad --title "Instalando o VirtualBox" \
    		--text "Bem vindo ao script de instalação do VirtualBox" $configYad --timeout 5

        # sudo rm -rf /etc/apt/sources.list.d/virtualbox*
        #wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
        #echo deb http://download.virtualbox.org/virtualbox/debian artful contrib | sudo tee /etc/apt/sources.list.d/virtualbox.list
        yad --progress \
         	--title "Preparando o hambiente." \
    	    --pulsate $configYad

        sudo apt-get update
        yad --progress \
         	--title "Atualizando o sistema." \
    	    --pulsate $configYad

        #sudo apt-get install -y virtualbox-5.2
        yad --progress \
         	--title "Instalando o VirtualBox." \
    	    --pulsate $configYad
    fi
    return
}

installVB
# Fim
