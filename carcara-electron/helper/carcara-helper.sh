#!/bin/bash
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026 (ping ICMP)
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: carcara-helper
# Descrição: Allowlist privilege helper for Carcará 2.0 (pkexec). No arbitrary shell.
# Variáveis: $1 = action name ; CARCARA_ROOT resolved from this file’s path
#----------------------------------------------------------------------------------------------------#
set -euo pipefail

action="${1:-}"

HELPER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${HELPER_DIR}/../.." && pwd)"
CARCARA_ROOT="${REPO_ROOT}/carcara"

usage() {
	echo "usage: carcara-helper.sh <action>" >&2
	echo "system:  ping | apt-dry-run | update-distro | fix-system | clean-distro" >&2
	echo "install: install-vlc | install-discord | install-spotify | install-telegram |" >&2
	echo "         install-git | install-vscode | install-insomnia | install-firacode |" >&2
	echo "         install-dropbox" >&2
}

_run_carcara_script() {
	local rel="$1"
	local script="${CARCARA_ROOT}/${rel}"
	if [[ ! -f "$script" ]]; then
		echo "[carcara-helper:error] missing script: $script" >&2
		return 1
	fi
	echo "[carcara-helper] running ${rel} (CARCARA_NONINTERACTIVE=1)"
	cd "${CARCARA_ROOT}"
	export CARCARA_NONINTERACTIVE=1
	export DEBIAN_FRONTEND=noninteractive
	# Preserve invoking user for trash cleanup when elevated via pkexec/sudo.
	if [[ -z "${SUDO_USER:-}" && -n "${PKEXEC_UID:-}" ]]; then
		SUDO_USER="$(getent passwd "${PKEXEC_UID}" | cut -d: -f1 || true)"
		export SUDO_USER
	fi
	bash "$script"
}

case "$action" in
	ping)
		# Reuses 1.x testConnection.sh (Google Public DNS IP; NI = full ping output).
		_run_carcara_script "app/config/testConnection.sh"
		exit $?
		;;
	apt-dry-run)
		export DEBIAN_FRONTEND=noninteractive
		echo "[carcara-helper] apt-get update (quiet)"
		apt-get update -qq
		echo "[carcara-helper] apt-get -s upgrade (dry-run)"
		apt-get -s upgrade
		exit 0
		;;
	update-distro)
		_run_carcara_script "app/scripts/system/updateDistro.sh"
		exit $?
		;;
	fix-system)
		_run_carcara_script "app/scripts/system/fixSystem.sh"
		exit $?
		;;
	clean-distro)
		_run_carcara_script "app/scripts/system/cleanDistro.sh"
		exit $?
		;;
	# --- software (Wave 2 thin installers) ---
	install-vlc)
		_run_carcara_script "app/scripts/software/utilities/vlc.sh"
		exit $?
		;;
	install-discord)
		_run_carcara_script "app/scripts/software/social/discord.sh"
		exit $?
		;;
	install-spotify)
		_run_carcara_script "app/scripts/software/social/spotify.sh"
		exit $?
		;;
	install-telegram)
		_run_carcara_script "app/scripts/software/social/telegram.sh"
		exit $?
		;;
	install-git)
		_run_carcara_script "app/scripts/software/development/git.sh"
		exit $?
		;;
	install-vscode)
		_run_carcara_script "app/scripts/software/development/vscode.sh"
		exit $?
		;;
	install-insomnia)
		_run_carcara_script "app/scripts/software/development/insomnia.sh"
		exit $?
		;;
	install-firacode)
		_run_carcara_script "app/scripts/software/development/firacode.sh"
		exit $?
		;;
	install-dropbox)
		_run_carcara_script "app/scripts/software/productivity/dropbox.sh"
		exit $?
		;;
	""|-h|--help)
		usage
		exit 2
		;;
	*)
		echo "[carcara-helper:error] unknown action: $action" >&2
		usage
		exit 2
		;;
esac
