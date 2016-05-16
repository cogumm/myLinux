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


installDocker()
{
    if [ which -a docker ]
    then
        echo "Docker já instalado"
    else
        echo "Instalando e configurando o Docker, aguarde.."
        curl -sSl https://get.docker.com | sh
        sudo usermod -aG docker ${USER}  
        sudo service docker restart
    fi
    
    return
}

checkDocker()
{
    docker images && docker ps -a
}

cleanDocker()
{
    if [ $(docker info 2>/dev/null | sed '/btrfs/!d' | grep -c "btrfs") = 1 ];
    then
        docker rm -f $(docker ps -qa) && docker rmi $(docker images -q)
        for i in "/var/lib/docker/btrfs/subvolumes/*"; do btrfs subvolume delete $i; done;
    else
        docker rm -f $(docker ps -qa) && docker rmi $(docker images -f "dangling=true" -q)
    fi
    return

}

runmyDocker()
{
    #echo "Rodando apache-php"
    #docker run -v /home/cogumm/dev/www:/app -d -p 80:80 tutum/apache-php
    echo
    echo "Entrando no container"
    id = docker ps -a | grep -v "CONTAINER ID"
    docker exec -it $id bash
}

echo "Bem vindo ao script de gerenciamento do Docker."
echo
echo "1) Instalar Docker "
echo
echo "2) Ver todas as imagens e containers no host "
echo
echo "3) Limpar Docker "
echo
echo "4) Rodar container "
echo
echo "s) Sair "

read -p "Para continuar escolha uma das opções  " escolha
	case $escolha in
		1) echo
	        #installDocker
	        sleep 2
	        ;;
		2) echo
	        #checkDocker
	        sleep 2
	        ;;
		3) echo
	        cleanDocker
	        sleep 2
	        ;;
		4) echo
	        #runmyDocker
	        sleep 2
	        ;;
		s|S) echo
		    echo "Saindo.."
	        exitScript
	        ;;
		*) echo
		    echo Alternativa incorreta!! Saindo..
			sleep 1
			exit
			;;
	esac
