#!/bin/bash
[[ -n "${CARCARA_NONINTERACTIVE:-}" ]] || clear
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: applyDotfiles
# Descrição: Menu 1.x → dotfiles/apply.sh como $SUDO_USER (nunca como root).
# Variáveis: $SUDO_USER $configYad ; CARCARA_NONINTERACTIVE (helper 2.0)
#----------------------------------------------------------------------------------------------------#
# shellcheck disable=SC2154

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../../../.." && pwd)"
APPLY_SH="${REPO_ROOT}/dotfiles/apply.sh"

_dotfiles_notify() {
	local title="$1"
	local text="$2"
	if [[ -z "${CARCARA_NONINTERACTIVE:-}" ]] && command -v yad >/dev/null 2>&1; then
		# shellcheck disable=SC2086
		yad --title "$title" --text "$text" $configYad
	else
		echo "[$title] $text"
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
			--column "Dotfiles (backup *.bak)" \
			--title="Carcará — Dotfiles" \
			"Preview (dry-run)" \
			"Aliases" \
			"Tudo (exceto bashrc)" \
			"Git" \
			"Hyper" \
			"Tema zsh" \
			"Bashrc" \
			"Voltar") || choice="Voltar"

		case "$choice" in
			"Preview (dry-run)")
				_run_apply_as_user --dry-run --all
				_dotfiles_notify "Dotfiles" "Preview concluído (nada foi escrito)."
				;;
			"Aliases")
				_run_apply_as_user --aliases
				_dotfiles_notify "Dotfiles" "Aliases aplicados (veja *.bak se havia arquivos)."
				;;
			"Tudo (exceto bashrc)")
				_run_apply_as_user --all
				_dotfiles_notify "Dotfiles" "Pacote --all aplicado."
				;;
			"Git")
				_run_apply_as_user --git
				_dotfiles_notify "Dotfiles" "Git config aplicado (tokens vazios no template)."
				;;
			"Hyper")
				_run_apply_as_user --hyper
				_dotfiles_notify "Dotfiles" "Hyper aplicado."
				;;
			"Tema zsh")
				_run_apply_as_user --theme
				_dotfiles_notify "Dotfiles" "Tema cgm (se oh-my-zsh existir)."
				;;
			"Bashrc")
				_run_apply_as_user --bashrc
				_dotfiles_notify "Dotfiles" "bashrc aplicado (backup *.bak)."
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
