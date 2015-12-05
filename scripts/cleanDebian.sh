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

cleanDebian()
{
    echo "Limpando a lixeira"
    sudo rm -rf /home/$SUDO_USER/.local/share/Trash/files/*
    echo "---------------------------------------------------------------"
    echo "Limpando a pasta tmp"
    sudo rm -rf /var/tmp/*
    echo "---------------------------------------------------------------"
    echo "Removendo arquivos inúteis do cache, onde são registradas as" 
    echo "cópias das atualizações que são instaladas pelo gerenciador"
    echo "de pacotes"
    sudo apt-get clean -y
    echo "---------------------------------------------------------------"
    echo "Removendo pacotes instalados automaticamente e que não tem mais" 
    echo "nenhuma utilidade para o sistema" 
    sudo apt-get autoremove -y
    echo "---------------------------------------------------------------"
    echo "Removendo pacotes antigos ou duplicados"
    sudo apt-get autoclean -y
    echo "---------------------------------------------------------------"
    echo "Reparando pacotes com problemas"
    sudo dpkg --configure -a
    echo "---------------------------------------------------------------"
    echo "Pré-linkando as blibliotecas dos programas"
    if which -a prelink; then
        sudo /etc/cron.daily/prelink
    else
        echo "Você precisa instalar o Prelink\nPara ativar essa função\n 'sudo apt-get install prelink -y'"
    fi
    echo "---------------------------------------------------------------"
    echo 
    echo "Concluído com sucesso!" 
    sleep 3
}

echo "Bem vindo ao script para limpar as sugeiras que ficam no sistema Linux."
read -p "Para continuar escolha s(sim) ou n(não)  " escolha
	case $escolha in
		s|S|sim) echo
			cleanDebian
			;;
		n|N|não|nao) echo
			echo Finalizando o script..
			sleep 1
			exit
			;;
		*) echo
			echo Alternativa incorreta!! Saindo..
			sleep 1
			exit
			;;
	esac
