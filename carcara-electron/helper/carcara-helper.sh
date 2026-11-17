#!/bin/bash
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: carcara-helper
# Descrição: Allowlist privilege helper for Carcará 2.0 (pkexec). No arbitrary shell.
# Variáveis: $1 = action name
#----------------------------------------------------------------------------------------------------#
set -euo pipefail

action="${1:-}"

usage() {
	echo "usage: carcara-helper.sh <action>" >&2
	echo "actions: apt-dry-run | ping" >&2
}

case "$action" in
	ping)
		echo "[carcara-helper] ok"
		exit 0
		;;
	apt-dry-run)
		# Simulation only — no package changes.
		export DEBIAN_FRONTEND=noninteractive
		echo "[carcara-helper] apt-get update (quiet)"
		apt-get update -qq
		echo "[carcara-helper] apt-get -s upgrade (dry-run)"
		apt-get -s upgrade
		exit 0
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
