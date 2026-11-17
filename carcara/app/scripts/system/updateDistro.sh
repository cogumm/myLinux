#!/bin/bash
[[ -n "${CARCARA_NONINTERACTIVE:-}" ]] || clear
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 01 de Dezembro de 2015
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: updateDistro
# Descrição: Atualização do sistema (update, upgrade, full-upgrade).
# Variáveis: $configYad ; root / CARCARA_NONINTERACTIVE → carcara_confirm auto-yes
#----------------------------------------------------------------------------------------------------#
# shellcheck disable=SC2154 # configYad exported by config.sh when sourced

_update_notify() {
	local title="$1"
	local text="$2"
	if [[ -z "${CARCARA_NONINTERACTIVE:-}" ]] && command -v yad >/dev/null 2>&1; then
		# shellcheck disable=SC2086
		yad --title "$title" --text "$text" $configYad
	else
		echo "[$title] $text"
	fi
}

updateDistro() {
	local failed=0

	carcara_log "updateDistro: starting"

	if carcara_confirm "Rodar apt-get update"; then
		if ! run_with_progress "apt-get update" \
			env DEBIAN_FRONTEND=noninteractive apt-get update; then
			carcara_err "apt-get update failed"
			failed=1
		fi
	fi

	if carcara_confirm "Rodar apt-get upgrade"; then
		if ! run_with_progress "apt-get upgrade" \
			env DEBIAN_FRONTEND=noninteractive apt-get upgrade -y; then
			carcara_err "apt-get upgrade failed"
			failed=1
		fi
	fi

	# full-upgrade is the modern name for dist-upgrade
	if carcara_confirm "Rodar apt-get full-upgrade (dist-upgrade)"; then
		if ! run_with_progress "apt-get full-upgrade" \
			env DEBIAN_FRONTEND=noninteractive apt-get full-upgrade -y; then
			carcara_err "apt-get full-upgrade failed"
			failed=1
		fi
	fi

	if ((failed)); then
		_update_notify "Atualização" "Concluído com erros. Veja o terminal ([carcara:error])."
		return 1
	fi

	_update_notify "Atualização" "Sistema atualizado com sucesso."
	return 0
}

updateDistro
# Fim
