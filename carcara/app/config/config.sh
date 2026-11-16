#!/bin/bash
clear
#---------------------------------------------------------------------------#
# Data criação: 06 de Setembro de 2017
# Última alteração: 16 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: config
# Descrição: Configurações compartilhadas do Carcará (paths, Yad, head, isRoot).
# Variáveis: $dirSof $dirSys $license $menuApp $menuSof $configYad $configYadB
#---------------------------------------------------------------------------#

# Mapeando diretórios dos scripts
dirSof=app/scripts/software
dirSys=app/scripts/system

# Carregando o arquivo de licença de uso da aplicação
license=app/config/license

# Menu
menuApp=app/config/menuGeral.sh
menuSof=app/scripts/software/menuSof.sh

# Configurações da janela do Yad
# Janela sem botões
configYad="--width=500
		   --text-align=fill
		   --center
		   --no-buttons
		   --timeout 3"
# Janela com botões de CANCELAR e OK
configYadB="--width=500
		   --text-align=center
		   --center
		   --timeout 3"

# Cabeçalho de todos os scripts
head(){
   echo "------------------------------------------------------------------"
   echo "Idealizador e desenvolvedor: Gabriel F. Vilar (CoGUMm)"
   echo "E-mail: gabriel[at]cogumm[dot]net"
   echo "Telegram: http://t.me/CoGUMm"
   echo "Website: http://cogumm.net"
   echo "NÃO ME RESPONSABILIZO POR MAUS DANOS À SUA MÁQUINA COM ESTE SCRIPT,"
   echo "FAVOR UTILIZÁ-LO SE APENAS TIVER CERTEZA DO QUE ESTEJA FAZENDO."
   echo "------------------------------------------------------------------"
}

# Verificando e validando se é root
isRoot(){
   if [ `id -u` -ne 0 ]; then
   	echo
   		echo "Você precisa ter poderes administrativos (root)"
   		echo "O script está sendo finalizado.."
   		sleep 4
   		exit
   fi
}

# Métodos
head
isRoot

# Fim
