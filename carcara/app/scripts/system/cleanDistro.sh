#!/bin/bash
clear
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data: 05 de Dezembro de 2015
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: cleanDistro
# Descrição: Script para limpar as sugeiras que ficam no sistema Linux.
# Variáveis: $SUDO_USER	 :
#			 $configYad	 : Carrega as configurações do Yad (sem botões).
#----------------------------------------------------------------------------------------------------#

cleanDebian()
{
	yad --title "Realizando a lipeza" \
		--text "Bem vindo ao script para limpar as sugeiras que ficam no sistema Linux." $configYad --timeout 5

	# Apagando os arquivos da lixeira.
	sudo rm -rf /home/$SUDO_USER/.local/share/Trash/files/* | \
	yad --progress \
     	--title "Realizando a lipeza" \
	    --progress-text="Limpando a lixeira" \
	    --pulsate $configYad

	# Apagando os arquivos do diretório tmp.
	sudo rm -rf /var/tmp/* | \
	yad --progress \
     	--title "Realizando a lipeza" \
	    --progress-text="Limpando a pasta tmp" \
	    --pulsate $configYad

	# Removendo pacotes travados
	sudo rm /var/lib/dpkg/lock | \
	yad --progress \
     	--title "Realizando a lipeza" \
	    --progress-text="Removendo o dpkg" \
	    --pulsate $configYad

	# Apagando listas "quebradas"
	sudo rm -rf /var/lib/apt/lists/*
	sudo rm -rf /var/lib/apt/lists/partial/* | \
	yad --progress \
		--title "Realizando a lipeza" \
		--progress-text="Limpando as lists" \
		--pulsate $configYad

	# apt-get clean
	sudo apt-get clean -y | \
	yad --progress \
     	--title "Realizando a lipeza" \
		--text "Removendo arquivos inúteis do cache, onde são registradas as cópias das atualizações que são instaladas pelo gerenciador de pacotes." \
	    --pulsate $configYad

	# apt-get autoclean
	sudo apt-get autoclean -y | \
	yad --progress \
     	--title "Realizando a lipeza" \
		--text "Removendo pacotes antigos ou duplicados." \
	    --pulsate $configYad

	# apt-get autoremove
	sudo apt-get autoremove -y | \
	yad --progress \
     	--title "Realizando a lipeza" \
		--text "Removendo pacotes instalados automaticamente e que não tem mais nenhuma utilidade para o sistema." \
	    --pulsate $configYad

    # echo "Pré-linkando as blibliotecas dos programas"
    # if which -a prelink; then
    #     sudo /etc/cron.daily/prelink
    # else
    #     echo "Você precisa instalar o Prelink\nPara ativar essa função\n 'sudo apt-get install prelink -y'"
    # fi
    yad --title "Realizando a limpeza" --text "Limpeza realizada com sucesso!" $configYad
}

cleanDebian
# Fim
