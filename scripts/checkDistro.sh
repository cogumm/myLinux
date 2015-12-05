#!/bin/bash

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
