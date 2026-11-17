#!/bin/bash
[[ -n "${CARCARA_NONINTERACTIVE:-}" ]] || clear
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: applyDotfiles
# Descrição: Menu 1.x → dotfiles/apply.sh como $SUDO_USER (i18n).
# Variáveis: $SUDO_USER $configYad ; CARCARA_LANG ; CARCARA_NONINTERACTIVE
#----------------------------------------------------------------------------------------------------#
# shellcheck disable=SC2154

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../../../.." && pwd)"
APPLY_SH="${REPO_ROOT}/dotfiles/apply.sh"

_dotfiles_notify() {
	local text="$1"
	if [[ -z "${CARCARA_NONINTERACTIVE:-}" ]] && command -v yad >/dev/null 2>&1; then
		# shellcheck disable=SC2086
		yad --title "$(t menu.dotfiles)" --text "$text" $configYad
	else
		echo "[$(t menu.dotfiles)] $text"
	fi
}

_run_apply_as_user() {
	local -a args=("$@")

	if [[ ! -f "$APPLY_SH" ]]; then
		carcara_err "apply.sh não encontrado: $APPLY_SH"
		return 1
	fi

	if [[ "$(id -u)" -eq 0 ]]; then
		if [[ -z "${SUDO_USER:-}" || "${SUDO_USER}" == "root" ]]; then
			carcara_err "SUDO_USER ausente — rode via sudo (usuário real), não como root puro"
			return 1
		fi
		carcara_log "dotfiles: sudo -u ${SUDO_USER} apply.sh ${args[*]}"
		sudo -u "${SUDO_USER}" -H bash "$APPLY_SH" "${args[@]}"
		return $?
	fi

	carcara_log "dotfiles: apply.sh ${args[*]}"
	bash "$APPLY_SH" "${args[@]}"
}

applyDotfilesMenu() {
	while true; do
		local choice
		choice=$(zenity --width=360 --height=420 --list \
			--title="$(t dotfiles.title)" \
			--column="id" --column="$(t dotfiles.column)" \
			--hide-column=1 --print-column=1 \
			dryrun "$(t dotfiles.dryrun)" \
			aliases "$(t dotfiles.aliases)" \
			all "$(t dotfiles.all)" \
			git "$(t dotfiles.git)" \
			hyper "$(t dotfiles.hyper)" \
			theme "$(t dotfiles.theme)" \
			bashrc "$(t dotfiles.bashrc)" \
			back "$(t menu.back)") || choice="back"

		case "$choice" in
			dryrun)
				_run_apply_as_user --dry-run --all
				_dotfiles_notify "$(t dotfiles.notify.dryrun)"
				;;
			aliases)
				_run_apply_as_user --aliases
				_dotfiles_notify "$(t dotfiles.notify.aliases)"
				;;
			all)
				_run_apply_as_user --all
				_dotfiles_notify "$(t dotfiles.notify.all)"
				;;
			git)
				_run_apply_as_user --git
				_dotfiles_notify "$(t dotfiles.notify.git)"
				;;
			hyper)
				_run_apply_as_user --hyper
				_dotfiles_notify "$(t dotfiles.notify.hyper)"
				;;
			theme)
				_run_apply_as_user --theme
				_dotfiles_notify "$(t dotfiles.notify.theme)"
				;;
			bashrc)
				_run_apply_as_user --bashrc
				_dotfiles_notify "$(t dotfiles.notify.bashrc)"
				;;
			*)
				break
				;;
		esac
	done
	return 0
}

applyDotfilesMenu
# Fim
