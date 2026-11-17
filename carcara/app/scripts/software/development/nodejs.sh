#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# Script: Node.js toolchain
# Descrição: Node + npm (NodeSource apt) + pnpm/yarn (npm -g) + Bun (GitHub zip).
# Sem curl|bash de setup scripts.
#----------------------------------------------------------------------------------------------------#

isRoot

arch=$(dpkg --print-architecture)
node_ok=0
pkg_present command node && pkg_present command npm && node_ok=1

if [[ "$node_ok" -eq 0 ]]; then
	key_url="https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key"
	deb_line="deb [arch=${arch} signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main"
	if ensure_apt_keyring_repo nodesource "$key_url" "$deb_line" \
		&& run_with_progress "Node.js 22 (apt)" apt_install nodejs; then
		node_ok=1
	else
		carcara_log "NodeSource failed — trying distro nodejs/npm"
		if run_with_progress "Node.js (distro apt)" apt_install nodejs npm; then
			node_ok=1
		fi
	fi
else
	carcara_log "Node.js already present — refresh global tools"
fi

if [[ "$node_ok" -ne 1 ]] || ! command -v npm >/dev/null 2>&1; then
	carcara_err "Node.js / npm install failed"
	exit 1
fi

carcara_log "Installing pnpm + yarn via npm -g"
if ! run_with_progress "pnpm+yarn (npm -g)" npm install -g pnpm yarn; then
	carcara_err "npm install -g pnpm yarn failed"
	exit 1
fi

if pkg_present command bun; then
	carcara_log "Bun already installed — skip"
	exit 0
fi

if [[ "$arch" != "amd64" ]]; then
	carcara_log "Bun zip installer is amd64-focused — Node/pnpm/yarn OK; skip Bun on ${arch}"
	exit 0
fi

if ! command -v python3 >/dev/null 2>&1 || ! command -v unzip >/dev/null 2>&1; then
	carcara_log "Installing unzip for Bun archive"
	apt_install unzip || true
fi

if ! command -v unzip >/dev/null 2>&1 || ! command -v python3 >/dev/null 2>&1; then
	carcara_err "python3 + unzip required for Bun GitHub zip"
	exit 1
fi

bun_url="$(
	curl -fsSL -H 'Accept: application/vnd.github+json' \
		'https://api.github.com/repos/oven-sh/bun/releases/latest' \
		| python3 -c '
import json, sys
data = json.load(sys.stdin)
for a in data.get("assets") or []:
    if a.get("name") == "bun-linux-x64.zip":
        print(a["browser_download_url"])
        sys.exit(0)
sys.exit(1)
'
)" || true

if [[ -z "${bun_url:-}" ]]; then
	carcara_err "Could not resolve bun-linux-x64.zip from GitHub releases"
	exit 1
fi

tmp="$(mktemp --suffix=.zip)"
trap 'rm -f "$tmp"' EXIT
carcara_log "Bun ← $bun_url"
if ! curl -fsSL --location --output "$tmp" "$bun_url"; then
	carcara_err "Bun download failed"
	exit 1
fi

install -d -m 0755 /opt/bun
rm -rf /opt/bun/bun-linux-x64
if ! unzip -qo "$tmp" -d /opt/bun; then
	carcara_err "Bun unzip failed"
	exit 1
fi
# Archive layout: bun-linux-x64/bun
if [[ -x /opt/bun/bun-linux-x64/bun ]]; then
	ln -sfn /opt/bun/bun-linux-x64/bun /usr/local/bin/bun
elif [[ -x /opt/bun/bun ]]; then
	ln -sfn /opt/bun/bun /usr/local/bin/bun
else
	carcara_err "Bun binary not found after unzip"
	exit 1
fi

carcara_log "Node toolchain OK (node $(node -v); pnpm/yarn/bun on PATH when linked)"
exit 0
# Fim
