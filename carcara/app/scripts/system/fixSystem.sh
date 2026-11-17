#!/bin/bash
clear
. app/config/config.sh
#-------------------------------------------------------------------------------#
# Data criação: 20 de Setembro de 2017
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: fixSystem
# Descrição: Corrige dependências e reconfigura pacotes (apt -f / dpkg --configure -a).
# Variáveis: $configYad : flags Yad; usa run_with_progress / carcara_log de install_backends
#-------------------------------------------------------------------------------#

_fix_notify() {
	local title="$1"
	local text="$2"
	if command -v yad >/dev/null 2>&1; then
		# shellcheck disable=SC2086
		yad --title "$title" --text "$text" $configYad
	else
		echo "[$title] $text"
	fi
}

fixSystem() {
	local failed=0

	carcara_log "fixSystem: starting"
	_fix_notify "Corrigindo o sistema" \
		"Reparando dependências e pacotes interrompidos."

	if ! run_with_progress "apt-get -f install" \
		env DEBIAN_FRONTEND=noninteractive apt-get -f install -y; then
		carcara_err "apt-get -f install failed"
		failed=1
	fi

	if ! run_with_progress "dpkg --configure -a" \
		dpkg --configure -a; then
		carcara_err "dpkg --configure -a failed"
		failed=1
	fi

	if ((failed)); then
		_fix_notify "Corrigindo o sistema" \
			"Correção terminou com erros. Veja o terminal ([carcara:error])."
		return 1
	fi

	_fix_notify "Corrigindo o sistema" "Correção realizada com sucesso."
	return 0
}

fixSystem
# Fim
