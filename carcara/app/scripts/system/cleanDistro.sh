#!/bin/bash
clear
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 05 de Dezembro de 2015
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: cleanDistro
# Descrição: Limpeza segura (lixeira, tmp, apt clean/autoclean/autoremove); lock só com confirmação.
# Variáveis: $SUDO_USER $configYad ; usa run_with_progress / carcara_log de install_backends
#----------------------------------------------------------------------------------------------------#

_clean_confirm() {
	local prompt="$1"
	local answer
	read -r -p "$prompt [y/N]: " answer
	[[ "$answer" == [Yy]* ]]
}

_clean_notify() {
	local title="$1"
	local text="$2"
	if command -v yad >/dev/null 2>&1; then
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

	if [[ -n "$trash_user" ]]; then
		trash_dir="/home/${trash_user}/.local/share/Trash/files"
		if [[ -d "$trash_dir" ]]; then
			if ! run_with_progress "Lixeira" \
				bash -c 'rm -rf -- "$1"/*' _ "$trash_dir"; then
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
		if ! run_with_progress "var/tmp" \
			bash -c 'rm -rf -- /var/tmp/*'; then
			carcara_err "Failed clearing /var/tmp"
			failed=1
		fi
	fi

	# Last-resort lock removal — never automatic
	if _clean_confirm "Remover locks do apt/dpkg (último recurso; só se apt estiver travado)"; then
		carcara_log "Removing apt/dpkg lock files"
		rm -f /var/lib/dpkg/lock /var/lib/dpkg/lock-frontend \
			/var/cache/apt/archives/lock /var/lib/apt/lists/lock || failed=1
	else
		carcara_log "Skipping dpkg/apt lock removal"
	fi

	# Clear apt lists
	if _clean_confirm "Limpar listas apt (/var/lib/apt/lists) — depois rode update"; then
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
