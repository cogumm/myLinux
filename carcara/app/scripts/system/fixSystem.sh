#!/bin/bash
clear
. app/config/config.sh
#-------------------------------------------------------------------------------#
# Data: 20 de Setembro de 2017
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: fixSystem
# Descrição: Script para correção do sistema.
# Variáveis: $configYad	 : Carrega as configurações do Yad (sem botões).
#-------------------------------------------------------------------------------#

fixSystem()
{
	yad --title "Corrigindo o sistema" \
		--text "Bem vindo ao script para corrigir e reparar problemas de dependências e pacotes do sistema Linux." $configYad --timeout 5

	# Forçando a instalação de pacotes quebrados.
	sudo apt-get -f install -y | \
	yad --progress \
     	--title "Corrigindo o sistema" \
	    --progress-text="Corrigindo problemas de dependências." \
	    --pulsate $configYad

	# Reparando o dpkg
	sudo dpkg --configure -a | \
	yad --progress \
     	--title "Corrigindo o sistema" \
	    --progress-text="Reparando pacotes com problemas." \
	    --pulsate $configYad

    # echo "Pré-linkando as blibliotecas dos programas"
    # if which -a prelink; then
    #     sudo /etc/cron.daily/prelink
    # else
    #     echo "Você precisa instalar o Prelink\nPara ativar essa função\n 'sudo apt-get install prelink -y'"
    # fi
    yad --title "Corrigindo o sistema" --text "Correção realizada com sucesso!" $configYad
}

fixSystem
# Fim
