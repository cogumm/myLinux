#!/bin/bash
[[ -n "${CARCARA_NONINTERACTIVE:-}" ]] || clear
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 05 de Dezembro de 2015
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: cleanDistro
# Descrição: Limpeza (lixeira, tmp, apt clean/autoclean/autoremove; locks/lists via carcara_confirm).
# Variáveis: $SUDO_USER $configYad ; root / CARCARA_NONINTERACTIVE → auto-yes
#----------------------------------------------------------------------------------------------------#
# shellcheck disable=SC2154 # configYad exported by config.sh when sourced

_clean_notify() {
	local title="$1"
	local text="$2"
	if [[ -z "${CARCARA_NONINTERACTIVE:-}" ]] && command -v yad >/dev/null 2>&1; then
		# shellcheck disable=SC2086
		yad --title "$title" --text "$text" $configYad
	else
		echo "[$title] $text"
	fi
}

cleanDebian() {
	local failed=0
	local trash_user="${SUDO_USER:-}"
	local trash_dir=""

	carcara_log "cleanDistro: starting"
	_clean_notify "Limpeza" "Iniciando limpeza do sistema."

	_clear_dir_contents() {
		local d="$1"
		local f
		local oldnullglob
		oldnullglob=$(shopt -p nullglob || true)
		shopt -s nullglob
		for f in "$d"/*; do
			rm -rf -- "$f"
		done
		eval "$oldnullglob" 2>/dev/null || true
	}

	if [[ -n "$trash_user" ]]; then
		trash_dir="/home/${trash_user}/.local/share/Trash/files"
		if [[ -d "$trash_dir" ]]; then
			if ! run_with_progress "Lixeira" _clear_dir_contents "$trash_dir"; then
				carcara_err "Failed clearing trash at $trash_dir"
				failed=1
			fi
		else
			carcara_log "Trash dir not found: $trash_dir (skip)"
		fi
	else
		carcara_log "SUDO_USER empty — skipping user trash"
	fi

	if [[ -d /var/tmp ]]; then
		if ! run_with_progress "var/tmp" _clear_dir_contents /var/tmp; then
			carcara_err "Failed clearing /var/tmp"
			failed=1
		fi
	fi

	# Lock removal — carcara_confirm auto-yes when already root / noninteractive
	if carcara_confirm "Remover locks do apt/dpkg (último recurso; só se apt estiver travado)"; then
		carcara_log "Removing apt/dpkg lock files"
		rm -f /var/lib/dpkg/lock /var/lib/dpkg/lock-frontend \
			/var/cache/apt/archives/lock /var/lib/apt/lists/lock || failed=1
	else
		carcara_log "Skipping dpkg/apt lock removal"
	fi

	# Clear apt lists
	if carcara_confirm "Limpar listas apt (/var/lib/apt/lists) — depois rode update"; then
		if ! run_with_progress "apt lists" \
			bash -c 'rm -rf /var/lib/apt/lists/*'; then
			carcara_err "Failed clearing apt lists"
			failed=1
		fi
	fi

	# Clean apt cache
	if ! run_with_progress "apt-get clean" \
		env DEBIAN_FRONTEND=noninteractive apt-get clean; then
		carcara_err "apt-get clean failed"
		failed=1
	fi

	# Autoclean apt cache
	if ! run_with_progress "apt-get autoclean" \
		env DEBIAN_FRONTEND=noninteractive apt-get autoclean -y; then
		carcara_err "apt-get autoclean failed"
		failed=1
	fi

	# Autoremove unused packages
	if ! run_with_progress "apt-get autoremove" \
		env DEBIAN_FRONTEND=noninteractive apt-get autoremove -y; then
		carcara_err "apt-get autoremove failed"
		failed=1
	fi

	if ((failed)); then
		_clean_notify "Limpeza" "Concluída com erros. Veja o terminal ([carcara:error])."
		return 1
	fi

	_clean_notify "Limpeza" "Limpeza realizada com sucesso."
	return 0
}

cleanDebian
# Fim
