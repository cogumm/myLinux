#!/bin/bash
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: start
# Descrição: Escolhe entre Carcará 2.0 (Electron) e Carcará 1.x (terminal / Zenity).
# Variáveis: MYLINUX_ROOT : diretório deste repositório
#----------------------------------------------------------------------------------------------------#
set -euo pipefail

MYLINUX_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CARCARA_1X="${MYLINUX_ROOT}/carcara"
CARCARA_2X="${MYLINUX_ROOT}/carcara-electron"

usage() {
	cat <<'EOF'
Uso: ./start.sh [opção]

  (sem opção)     Menu interativo — Electron 2.0 ou terminal 1.x
  -e, --electron  Carcará 2.0 (Electron + Bun)
  -t, --terminal  Carcará 1.x (Bash + Zenity/Yad; precisa de root/sudo)
  -h, --help      Esta ajuda

Aliases: electron | 2.0 | gui   →  Electron
         terminal | cli | tui | 1.x  →  terminal
EOF
}

have_cmd() {
	command -v "$1" >/dev/null 2>&1
}

run_electron() {
	echo
	echo "[carcara] Modo: Electron 2.0"
	echo "[carcara] Diretório: ${CARCARA_2X}"
	echo

	if [[ ! -d "${CARCARA_2X}" ]]; then
		echo "[carcara:error] Pasta carcara-electron/ não encontrada." >&2
		exit 1
	fi
	if ! have_cmd bun; then
		echo "[carcara:error] Bun não está no PATH. Instale: https://bun.sh" >&2
		exit 1
	fi

	cd "${CARCARA_2X}"
	if [[ ! -d node_modules ]]; then
		echo "[carcara] Dependências ausentes — executando bun install…"
		bun install
	fi
	echo "[carcara] Iniciando UI (bun run dev)…"
	exec bun run dev
}

run_terminal() {
	echo
	echo "[carcara] Modo: terminal 1.x (Zenity/Yad)"
	echo "[carcara] Diretório: ${CARCARA_1X}"
	echo "[carcara] Esta sessão precisa de privilégios administrativos (sudo/root)."
	echo

	if [[ ! -f "${CARCARA_1X}/startApp.sh" ]]; then
		echo "[carcara:error] carcara/startApp.sh não encontrado." >&2
		exit 1
	fi

	cd "${CARCARA_1X}"
	if [[ "$(id -u)" -eq 0 ]]; then
		exec bash startApp.sh
	fi
	if ! have_cmd sudo; then
		echo "[carcara:error] sudo não disponível e você não é root." >&2
		exit 1
	fi
	exec sudo bash startApp.sh
}

pick_interactive() {
	local choice=""

	if [[ -n "${DISPLAY:-}${WAYLAND_DISPLAY:-}" ]] && have_cmd zenity; then
		choice="$(
			zenity --list \
				--title="Carcará — myLinux" \
				--text="Como deseja iniciar o Carcará?" \
				--column="Opção" \
				--width=420 --height=280 \
				"Electron 2.0 (interface gráfica)" \
				"Terminal 1.x (scripts Zenity/Yad)" \
				"Sair" \
				|| true
		)"
		case "$choice" in
			"Electron 2.0 (interface gráfica)") run_electron ;;
			"Terminal 1.x (scripts Zenity/Yad)") run_terminal ;;
			*) echo "Saindo."; exit 0 ;;
		esac
		return
	fi

	echo "========================================"
	echo "  Carcará — escolha o modo de execução"
	echo "========================================"
	echo "  1) Electron 2.0  (interface gráfica)"
	echo "  2) Terminal 1.x  (scripts Zenity/Yad + root)"
	echo "  3) Sair"
	echo "========================================"
	read -r -p "Opção [1-3]: " choice
	case "$choice" in
		1) run_electron ;;
		2) run_terminal ;;
		*) echo "Saindo."; exit 0 ;;
	esac
}

main() {
	local arg="${1:-}"
	case "$arg" in
		"" )
			pick_interactive
			;;
		-h|--help|help)
			usage
			;;
		-e|--electron|electron|2.0|gui)
			run_electron
			;;
		-t|--terminal|--cli|--tui|terminal|cli|tui|1.x)
			run_terminal
			;;
		*)
			echo "[carcara:error] Opção desconhecida: $arg" >&2
			usage >&2
			exit 2
			;;
	esac
}

main "$@"
# Fim
