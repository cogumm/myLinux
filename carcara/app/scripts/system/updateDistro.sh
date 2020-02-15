#!/bin/bash
clear
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data: 01 de Dezembro de 2015
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: updateDistro
# Descrição: Atualização do sistema (update, upgrade, dist-upgrade).
# Variáveis: $configYad	 : Carrega as configurações do Yad (sem botões).
#----------------------------------------------------------------------------------------------------#

updateDistro()
{
	# update
	echo -n "Atualizar o sistema [update] (y/n)? "
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
		sudo apt-get update -y | \
		yad --progress \
			--title "Atualizando o sistema" \
			--text "Re sincronizando os ficheiros de índices dos pacotes a partir das suas fontes." \
			--progress-text="Atualizando o sistema." \
			--pulsate $configYad
	fi

	# dist-upgrade
	echo -n "Atualizar o sistema [dist-upgrade] (y/n)? "
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
		sudo apt-get dist-upgrade -y | \
		yad --progress \
			--title "Atualizando o sistema" \
			--text "Lidando inteligentemente com as alterações de dependências com as novas versões de pacotes" \
			--progress-text="Atualizando o sistema." \
			--pulsate $configYad

		yad --text="Sistema atualizado." $configYad
	fi

	# upgrade
	echo -n "Atualizar o sistema [upgrade] (y/n)? "
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then

		sudo apt-get upgrade -y | \
		yad --progress \
			--title "Atualizando os pacotes" \
			--text "Instando as versões mais recentes de todos os pacotes presentemente instalados no sistema." \
			--progress-text="Atualizando o sistema." \
			--pulsate $configYad

		yad --text="Pacotes atualizado." $configYad
	fi

	# Finalizando a atualização
	yad --title "Atualizando o sistema"
		--text "Sistema atualizado com sucesso!" $configYad --timeout 5
}

updateDistro
# Fim
