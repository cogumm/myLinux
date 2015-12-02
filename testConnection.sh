#!/bin/bash

# Verificando e validando se é root
if [ `id -u` -ne 0 ]; then
	echo
		echo "Você precisa ter poderes administrativos (root)"
		echo "O script está sendo finalizado.."
		sleep 4
		exit
fi

testConnection()
{
echo "Testando sua conexão com a internet."
echo

if ! ping -c 3 www.google.com.br 1>/dev/null 2>/dev/stdout; then
    echo "Alguns programas necessitam de internet para serem instalados."
    sleep 2
    read -p "Refazer o teste de coneção? s/n: " escolha
    case $escolha in
        s|S) echo
            clear
            testConnection
            ;;
        n|N) echo
            echo Voltando
            sleep 2
            exit
            ;;
        *) echo
            echo Alternativas incorretas. Saindo!
            exit
            ;;
    esac
else
    echo "Conexão ok"
    echo
    sleep 1
fi
}

testConnection
