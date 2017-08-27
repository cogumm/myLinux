#!/bin/bash

echo "---------------------------------------------------------------"
echo "Desenvolvido por Gabriel F. Vilar"
echo "E-mail: cogumm@gmail.com"
echo "Website: http://cogumm.net"
echo "NÃO ME RESPONSABILIZO POR MAUS DANOS À MÁQUINA COM ESTE SCRIPT,\nFAVOR UTILIZÁ-LO SE APENAS TIVER CERTEZA DO QUE ESTEJA FAZENDO."
echo "---------------------------------------------------------------"

# Verificando e validando se é root
if [ `id -u` -ne 0 ]; then
	echo
		echo "Você precisa ter poderes administrativos (root)"
		echo "O script está sendo finalizado.."
		sleep 4
		exit
fi

checkDistro()
{
verificadistro=$(cat /etc/*-release | grep "DISTRIB_ID")

case $verificadistro in
	"DISTRIB_ID=Ubuntu") echo "Ubuntu" ;;
	"DISTRIB_ID=Debian") echo "Debian" ;;
	"DISTRIB_ID=LinuxMint") echo "Linux Mint" ;;
	"DISTRIB_ID=Opensuse") echo "Opensuse" ;;
	"DISTRIB_ID=Gentoo") echo "Gentoo" ;;
	"DISTRIB_ID=CentOS") echo "CentOS" ;;
	"DISTRIB_ID=Fedora") echo "Fedora" ;;
	*) echo "Script contém alguns comandos ou programas incompativeis com sua distro!" ;;
esac
}

checkArchitecture()
{
checkArchitecture=$(uname -m | grep "64")

case $checkArchitecture in
    "x86_64") echo "64 bits" ;;
    "") echo "32 bits" ;;
    *) echo "O script não encontrou a sua arquitetura de hardware" ;;
esac
}

echo "Analizando.."
checkDistro
checkArchitecture
sleep 2
