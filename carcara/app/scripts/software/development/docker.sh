#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: docker
# Descrição: Instala Docker Engine (repo oficial apt → docker.io). Substitui old/scripts/docker.sh.
#            Não usa curl|bash; não limpa containers; não sobe imagens tutum legadas.
#----------------------------------------------------------------------------------------------------#

isRoot

_docker_add_user() {
	local user="${SUDO_USER:-}"
	if [[ -z "$user" || "$user" == "root" ]]; then
		carcara_log "SUDO_USER ausente — pulei usermod -aG docker (adicione seu usuário manualmente)"
		return 0
	fi
	if id -nG "$user" 2>/dev/null | tr ' ' '\n' | grep -qx docker; then
		carcara_log "usuário '$user' já está no grupo docker"
		return 0
	fi
	carcara_log "usermod -aG docker $user (relogin necessário)"
	usermod -aG docker "$user"
}

_docker_enable_service() {
	if [[ -d /run/systemd/system ]] && command -v systemctl >/dev/null 2>&1; then
		systemctl enable --now docker >/dev/null 2>&1 || true
	elif command -v service >/dev/null 2>&1; then
		service docker start >/dev/null 2>&1 || true
	fi
}

_docker_official_repo() {
	local id="" id_like="" codename="" distro_path="" arch
	arch="$(dpkg --print-architecture)"

	if [[ -r /etc/os-release ]]; then
		# shellcheck disable=SC1091
		. /etc/os-release
		id="${ID:-}"
		id_like="${ID_LIKE:-}"
		codename="${UBUNTU_CODENAME:-${VERSION_CODENAME:-}}"
	fi

	case " ${id} ${id_like} " in
		*" debian "*)
			# Pure Debian (not Ubuntu derivatives)
			if [[ "$id" == "debian" ]]; then
				distro_path="debian"
			else
				distro_path="ubuntu"
			fi
			;;
		*" ubuntu "*)
			distro_path="ubuntu"
			;;
		*)
			distro_path="ubuntu"
			;;
	esac

	if [[ -z "$codename" ]]; then
		carcara_err "não foi possível detectar VERSION_CODENAME para o repo Docker"
		return 1
	fi

	local key_url="https://download.docker.com/linux/${distro_path}/gpg"
	local deb_line="deb [arch=${arch} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/${distro_path} ${codename} stable"

	carcara_log "Docker official repo: ${distro_path}/${codename} (${arch})"
	ensure_apt_keyring_repo docker "$key_url" "$deb_line" || return 1
	apt_install \
		docker-ce \
		docker-ce-cli \
		containerd.io \
		docker-buildx-plugin \
		docker-compose-plugin
}

if pkg_present command docker; then
	carcara_log "Docker already installed — ensuring group + service"
	_docker_add_user
	_docker_enable_service
	docker --version 2>/dev/null || true
	exit 0
fi

carcara_log "Docker Engine — trying official apt repo (no curl|bash)"
if run_with_progress "Docker (official apt)" _docker_official_repo; then
	_docker_add_user
	_docker_enable_service
	carcara_log "Docker Engine instalado (CE + compose plugin)"
	docker --version 2>/dev/null || true
	exit 0
fi

carcara_log "official repo failed — falling back to distro docker.io"
if run_with_progress "Docker (docker.io)" apt_install docker.io docker-compose-v2 \
	|| run_with_progress "Docker (docker.io)" apt_install docker.io; then
	_docker_add_user
	_docker_enable_service
	carcara_log "Docker instalado via docker.io"
	docker --version 2>/dev/null || true
	exit 0
fi

carcara_err "Docker install failed"
exit 1
# Fim
