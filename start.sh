#!/bin/bash
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026 (Electron exige root como 1.x)
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: start
# Descrição: Escolhe entre Carcará 2.0 (Electron) e Carcará 1.x (terminal / Zenity).
#            Também faz bootstrap (git clone) quando executado via curl | bash.
# Variáveis: MYLINUX_ROOT MYLINUX_DIR SUDO_USER
#----------------------------------------------------------------------------------------------------#
set -euo pipefail

REPO_URL="${MYLINUX_REPO_URL:-https://github.com/cogumm/myLinux.git}"
REPO_BRANCH="${MYLINUX_REPO_BRANCH:-master}"

is_repo_root() {
	local dir="$1"
	[[ -f "${dir}/start.sh" && -d "${dir}/carcara" ]]
}

resolve_local_root() {
	local src="${BASH_SOURCE[0]:-}"
	local here=""
	# Piped scripts (curl | bash) often have no usable BASH_SOURCE file path.
	if [[ -z "$src" || "$src" == "bash" || "$src" == "-" || ! -f "$src" ]]; then
		return 1
	fi
	here="$(cd "$(dirname "$src")" && pwd)"
	if is_repo_root "$here"; then
		printf '%s\n' "$here"
		return 0
	fi
	return 1
}

real_user_home() {
	if [[ -n "${SUDO_USER:-}" && "${SUDO_USER}" != "root" ]]; then
		getent passwd "${SUDO_USER}" | cut -d: -f6
	else
		printf '%s\n' "${HOME}"
	fi
}

bootstrap_repo() {
	local dest="${MYLINUX_DIR:-$(real_user_home)/myLinux}"
	echo "[carcara] Bootstrap: repositório não encontrado neste contexto (curl|bash?)."
	echo "[carcara] Destino: ${dest}"

	if ! have_cmd git; then
		echo "[carcara:error] git é necessário para o bootstrap. Instale: sudo apt install git" >&2
		exit 1
	fi

	if [[ -d "${dest}/.git" ]] && is_repo_root "$dest"; then
		echo "[carcara] Atualizando clone existente…"
		git -C "$dest" fetch --depth 1 origin "${REPO_BRANCH}" || true
		git -C "$dest" checkout "${REPO_BRANCH}" || true
		git -C "$dest" pull --ff-only origin "${REPO_BRANCH}" || true
	else
		if [[ -e "$dest" && ! -d "${dest}/.git" ]]; then
			echo "[carcara:error] ${dest} existe e não é um clone git. Defina MYLINUX_DIR=…" >&2
			exit 1
		fi
		echo "[carcara] Clonando ${REPO_URL} (${REPO_BRANCH})…"
		git clone --branch "${REPO_BRANCH}" --depth 1 "${REPO_URL}" "$dest"
	fi

	# Prefer continuing as the invoking user when started with sudo curl | bash.
	if [[ "$(id -u)" -eq 0 && -n "${SUDO_USER:-}" && "${SUDO_USER}" != "root" ]]; then
		echo "[carcara] Reexecutando como ${SUDO_USER}…"
		exec sudo -u "${SUDO_USER}" -H bash "${dest}/start.sh" "$@"
	fi
	exec bash "${dest}/start.sh" "$@"
}

have_cmd() {
	command -v "$1" >/dev/null 2>&1
}

# sudo's secure_path drops ~/.bun/bin — recover Bun for root / `sudo ./start.sh`.
ensure_bun_on_path() {
	if have_cmd bun; then
		return 0
	fi

	local candidates=()
	local home=""

	if [[ -n "${SUDO_USER:-}" && "${SUDO_USER}" != "root" ]]; then
		home="$(getent passwd "${SUDO_USER}" | cut -d: -f6 || true)"
		[[ -n "$home" ]] && candidates+=("${home}/.bun/bin/bun")
	fi
	# Fallback when already root without SUDO_USER (rare) or login shell.
	[[ -n "${HOME:-}" && "${HOME}" != /root ]] && candidates+=("${HOME}/.bun/bin/bun")
	candidates+=("/usr/local/bin/bun" "/usr/bin/bun")

	local bun_bin=""
	local c
	for c in "${candidates[@]}"; do
		if [[ -x "$c" ]]; then
			bun_bin="$c"
			break
		fi
	done

	if [[ -z "$bun_bin" ]]; then
		return 1
	fi

	export PATH="$(dirname "$bun_bin"):${PATH}"
	echo "[carcara] Bun encontrado fora do PATH do sudo: ${bun_bin}"
	return 0
}

MYLINUX_ROOT="$(resolve_local_root || true)"
if [[ -z "${MYLINUX_ROOT}" ]]; then
	bootstrap_repo "$@"
fi

CARCARA_1X="${MYLINUX_ROOT}/carcara"
CARCARA_2X="${MYLINUX_ROOT}/carcara-electron"

usage() {
	cat <<'EOF'
Uso: ./start.sh [opção]

  (sem opção)     Menu interativo — Carcará 2.0 ou terminal 1.x
  -e, --electron  Carcará 2.0 (Electron + Bun; precisa de root/sudo)
  -t, --terminal  Carcará 1.x (Bash + Zenity/Yad; precisa de root/sudo)
  -h, --help      Esta ajuda

Aliases: electron | 2.0 | gui   →  Carcará 2.0
         terminal | cli | tui | 1.x  →  terminal

Bootstrap (sem clone local):
  sudo curl -L https://raw.githubusercontent.com/cogumm/myLinux/master/start.sh | bash
  # clona em ~/myLinux (ou $MYLINUX_DIR) e abre o menu
EOF
}

require_root_or_sudo() {
	local mode="$1"
	shift
	if [[ "$(id -u)" -eq 0 ]]; then
		return 0
	fi
	echo
	echo "[carcara] Você precisa ter poderes administrativos (root)."
	echo "[carcara] Modo ${mode}: elevando com sudo (mesmo requisito do Carcará 1.x)…"
	echo
	if ! have_cmd sudo; then
		echo "[carcara:error] sudo não disponível e você não é root." >&2
		exit 1
	fi
	local bun_dir=""
	if have_cmd bun; then
		bun_dir="$(cd "$(dirname "$(command -v bun)")" && pwd)"
	fi
	# Preserve GUI session env; keep Bun on PATH under sudo.
	exec sudo \
		--preserve-env=DISPLAY,WAYLAND_DISPLAY,XAUTHORITY,DBUS_SESSION_BUS_ADDRESS,XDG_RUNTIME_DIR \
		env "PATH=${bun_dir:+${bun_dir}:}/usr/local/bin:/usr/bin:${PATH}" \
		bash "${MYLINUX_ROOT}/start.sh" "$@"
}

run_electron() {
	echo
	echo "[carcara] Modo: Carcará 2.0"
	echo "[carcara] Diretório: ${CARCARA_2X}"
	echo "[carcara] Esta sessão precisa de privilégios administrativos (sudo/root)."
	echo

	if [[ ! -d "${CARCARA_2X}" ]]; then
		echo "[carcara:error] Pasta carcara-electron/ não encontrada." >&2
		exit 1
	fi

	# Re-exec via sudo before install/dev so deps and Electron share root (like 1.x).
	# Prefer elevating *before* PATH fix so sudo injects Bun; still fix PATH when
	# the user already ran `sudo ./start.sh` (secure_path hides ~/.bun/bin).
	if [[ "$(id -u)" -ne 0 ]]; then
		require_root_or_sudo "Carcará 2.0" --electron
	fi

	if ! ensure_bun_on_path; then
		echo "[carcara:error] Bun não está no PATH (nem em ~/.bun/bin do SUDO_USER)." >&2
		echo "[carcara:error] Instale: https://bun.sh  — depois: sudo ./start.sh --electron" >&2
		exit 1
	fi

	cd "${CARCARA_2X}"
	if [[ ! -d node_modules ]]; then
		echo "[carcara] Dependências ausentes — executando bun install…"
		bun install
	fi

	# WSLg + sudo: DRI3/MESA shm warnings are common — prefer software GL.
	if [[ -r /proc/version ]] && grep -qi microsoft /proc/version; then
		export LIBGL_ALWAYS_SOFTWARE="${LIBGL_ALWAYS_SOFTWARE:-1}"
		# Root often lacks the invoking user's X cookie unless sudo preserved it.
		if [[ -z "${XAUTHORITY:-}" && -n "${SUDO_USER:-}" ]]; then
			_home="$(getent passwd "${SUDO_USER}" | cut -d: -f6 || true)"
			if [[ -n "${_home}" && -f "${_home}/.Xauthority" ]]; then
				export XAUTHORITY="${_home}/.Xauthority"
			fi
		fi
		echo "[carcara] WSL detectado — Electron com GPU desligada (evita erros DRI3/MESA)."
	fi

	echo "[carcara] Iniciando UI (bun run dev) como root…"
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
				"Carcará 2.0 (interface gráfica + root)" \
				"Terminal 1.x (scripts Zenity/Yad + root)" \
				"Sair" \
				|| true
		)"
		case "$choice" in
			"Carcará 2.0 (interface gráfica + root)") run_electron ;;
			"Terminal 1.x (scripts Zenity/Yad + root)") run_terminal ;;
			*) echo "Saindo."; exit 0 ;;
		esac
		return
	fi

	echo "========================================"
	echo "  Carcará — escolha o modo de execução"
	echo "========================================"
	echo "  1) Carcará 2.0  (interface gráfica + root)"
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
