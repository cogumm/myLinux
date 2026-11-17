#!/bin/bash
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026 (Electron como usuário da sessão; 1.x permanece root)
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
REPO_BRANCH="${MYLINUX_REPO_BRANCH:-main}"

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
  -e, --electron  Carcará 2.0 (Electron + Bun; usuário da sessão — sem sudo)
  -t, --terminal  Carcará 1.x (Bash + Zenity/Yad; precisa de root/sudo)
  -h, --help      Esta ajuda

Aliases: electron | 2.0 | gui   →  Carcará 2.0
         terminal | cli | tui | 1.x  →  terminal

Bootstrap (sem clone local):
  curl -L https://raw.githubusercontent.com/cogumm/myLinux/main/start.sh | bash
  # clona em ~/myLinux (ou $MYLINUX_DIR) e abre o menu
EOF
}

# Electron must own the GUI session (X11/Wayland). If started via sudo, drop to SUDO_USER.
drop_root_for_electron() {
	if [[ "$(id -u)" -ne 0 ]]; then
		return 0
	fi

	if [[ -z "${SUDO_USER:-}" || "${SUDO_USER}" == "root" ]]; then
		echo "[carcara:error] A UI Electron não deve rodar como root (quebra X11/Wayland)." >&2
		echo "[carcara:error] Use: ./start.sh --electron  (sem sudo)." >&2
		echo "[carcara:error] Ações privilegiadas ficam no helper/pkexec." >&2
		exit 1
	fi

	if ! have_cmd sudo; then
		echo "[carcara:error] sudo não disponível para reexecutar como ${SUDO_USER}." >&2
		exit 1
	fi

	local user_home user_uid xauth dbus_addr runtime_dir bun_dir
	user_home="$(getent passwd "${SUDO_USER}" | cut -d: -f6 || true)"
	user_uid="$(id -u "${SUDO_USER}" 2>/dev/null || true)"
	if [[ -z "${user_home}" || -z "${user_uid}" ]]; then
		echo "[carcara:error] Não foi possível resolver home/uid de ${SUDO_USER}." >&2
		exit 1
	fi

	xauth="${XAUTHORITY:-}"
	if [[ -z "${xauth}" && -f "${user_home}/.Xauthority" ]]; then
		xauth="${user_home}/.Xauthority"
	fi
	runtime_dir="${XDG_RUNTIME_DIR:-/run/user/${user_uid}}"
	dbus_addr="${DBUS_SESSION_BUS_ADDRESS:-}"
	if [[ -z "${dbus_addr}" && -S "${runtime_dir}/bus" ]]; then
		dbus_addr="unix:path=${runtime_dir}/bus"
	fi
	bun_dir=""
	if [[ -x "${user_home}/.bun/bin/bun" ]]; then
		bun_dir="${user_home}/.bun/bin"
	fi

	echo "[carcara] Sessão root detectada — reexecutando Electron como ${SUDO_USER}…"
	exec sudo -u "${SUDO_USER}" -H \
		env \
		"HOME=${user_home}" \
		"USER=${SUDO_USER}" \
		"LOGNAME=${SUDO_USER}" \
		"DISPLAY=${DISPLAY:-}" \
		"WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-}" \
		"XAUTHORITY=${xauth}" \
		"XDG_RUNTIME_DIR=${runtime_dir}" \
		"DBUS_SESSION_BUS_ADDRESS=${dbus_addr}" \
		"PATH=${bun_dir:+${bun_dir}:}/usr/local/bin:/usr/bin:/bin" \
		bash "${MYLINUX_ROOT}/start.sh" --electron
}

run_electron() {
	echo
	echo "[carcara] Modo: Carcará 2.0"
	echo "[carcara] Diretório: ${CARCARA_2X}"
	echo "[carcara] UI como usuário da sessão; privilégio só via helper/pkexec."
	echo

	if [[ ! -d "${CARCARA_2X}" ]]; then
		echo "[carcara:error] Pasta carcara-electron/ não encontrada." >&2
		exit 1
	fi

	drop_root_for_electron

	if ! ensure_bun_on_path; then
		echo "[carcara:error] Bun não está no PATH (nem em ~/.bun/bin)." >&2
		echo "[carcara:error] Instale: https://bun.sh  — depois: ./start.sh --electron" >&2
		exit 1
	fi

	cd "${CARCARA_2X}"
	if [[ ! -d node_modules ]]; then
		echo "[carcara] Dependências ausentes — executando bun install…"
		bun install
	fi

	# WSLg: DRI3/MESA shm warnings are common — prefer software GL.
	if [[ -r /proc/version ]] && grep -qi microsoft /proc/version; then
		export LIBGL_ALWAYS_SOFTWARE="${LIBGL_ALWAYS_SOFTWARE:-1}"
		echo "[carcara] WSL detectado — Electron com GPU desligada (evita erros DRI3/MESA)."
	fi

	echo "[carcara] Iniciando UI (bun run dev) como $(id -un)…"
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
				"Carcará 2.0 (interface gráfica)" \
				"Terminal 1.x (scripts Zenity/Yad + root)" \
				"Sair" \
				|| true
		)"
		case "$choice" in
			"Carcará 2.0 (interface gráfica)") run_electron ;;
			"Terminal 1.x (scripts Zenity/Yad + root)") run_terminal ;;
			*) echo "Saindo."; exit 0 ;;
		esac
		return
	fi

	echo "========================================"
	echo "  Carcará — escolha o modo de execução"
	echo "========================================"
	echo "  1) Carcará 2.0  (interface gráfica)"
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
