#!/bin/bash
clear
#-------------------------------------------------------------------------------#
# Data: 05 de Dezembro de 2015
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: cleanDistro
# Descrição: Limpando o sistema.
# Variáveis: $configYad	 : Carrega as configurações do Yad (sem botões).
#-------------------------------------------------------------------------------#

testConnection(){
    yad --title "Testando conexão" --text "Testando a sua conexão com a internet antes de continuar." $configYad

    if ! ping -c 3 www.google.com 1>/dev/null 2>/dev/stdout; then
        yad --title "Testando conexão" --text "Favor, verifique a conexão de rede do seu computador." $configYad
        sleep 2
        read -p "Refazer o teste de coneção? (y/n):" escolha
        case $escolha in
            y|Y) echo
                testConnection
                ;;
            n|N) echo
                yad --title "Testando conexão" --text "Saindo do teste de conexão." $configYad
                sleep 2
                exit
                ;;
        esac
    else
        yad --title "Testando conexão" --text "Tudo ok com a sua conexão. \nContinuando com o programa." $configYad
        sleep 1
    fi
}

testConnection
