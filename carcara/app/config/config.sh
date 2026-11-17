#!/bin/bash
clear
#---------------------------------------------------------------------------#
# Data criação: 06 de Setembro de 2017
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: config
# Descrição: Configurações compartilhadas do Carcará (paths, Yad, head, isRoot, backends).
# Variáveis: $dirSof $dirSys $license $menuApp $menuSof $configYad $configYadB
#---------------------------------------------------------------------------#

# Shared by every script that sources this file (menus / installers).
export dirSof=app/scripts/software
export dirSys=app/scripts/system
export license=app/config/license
export menuApp=app/config/menuGeral.sh
export menuSof=app/scripts/software/menuSof.sh

# Configurações da janela do Yad
# Janela sem botões
export configYad="--width=500
		   --text-align=fill
		   --center
		   --no-buttons
		   --timeout 3"
# Janela com botões de CANCELAR e OK
export configYadB="--width=500
		   --text-align=center
		   --center
		   --timeout 3"

# Shared install API (apt / Flatpak / Snap) — Carcará 1.x engine for 2.0
# shellcheck source=install_backends.sh
. app/config/install_backends.sh

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
   if [[ "$(id -u)" -ne 0 ]]; then
   	echo
   		echo "Você precisa ter poderes administrativos (root)"
   		echo "O script está sendo finalizado.."
   		sleep 4
   		exit 1
   fi
}

# Métodos
head
isRoot

# Fim
