#!/bin/bash
clear

echo "---------------------------------------------------------------"
echo "Desenvolvido por Gabriel F. Vilar"
echo "E-mail: cogumm@gmail.com"
echo "Website: http://cogumm.net"
echo "NÃO ME RESPONSABILIZO POR MAUS DANOS À SUA MÁQUINA COM ESTE SCRIPT,\nFAVOR UTILIZÁ-LO SE APENAS TIVER CERTEZA DO QUE ESTEJA FAZENDO."
echo "---------------------------------------------------------------"

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
    cd scripts
    sh testConnection.sh
}

cleanDebian()
{
    cd scripts
    sh cleanDebian.sh
}



exitScript()
{
    clear
    exit 0
}



echo "Bem vindo ao script instalação."
echo
echo "t) Testar conexão "
echo
echo "c) Fazer uma limpeza no sistema? "
echo
echo "s) Sair "

read -p "Para continuar escolha uma das opções  " escolha
	case $escolha in
		t|T) echo
	        testConnection
	        sleep 2
	        ;;
		c|C) echo
	        cleanDebian
	        sleep 2
	        ;;
		s|S) echo
		    echo "Saindo"
	        exitScript
	        ;;
		*) echo
		    echo Alternativa incorreta!! Saindo..
			sleep 1
			exit
			;;
	esac
