#!/bin/bash
. app/config/config.sh
#----------------------------------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: Zen Browser
# Descrição: Instala o Zen Browser via GitHub Releases (AppImage).
# Fonte: https://github.com/zen-browser/desktop/releases
#----------------------------------------------------------------------------------------------------#

isRoot

ZEN_OPT="/opt/zen-browser"
ZEN_BIN="/usr/local/bin/zen"

if pkg_present command zen || [[ -x "${ZEN_OPT}/zen.AppImage" ]]; then
	carcara_log "Zen Browser already installed — skip"
	exit 0
fi

arch=$(dpkg --print-architecture)
case "$arch" in
	amd64) asset="zen-x86_64.AppImage" ;;
	arm64) asset="zen-aarch64.AppImage" ;;
	*)
		carcara_err "Zen Browser AppImage supports amd64/arm64 only (got ${arch})"
		exit 1
		;;
esac

# Resolve latest release asset URL (GitHub API) — no curl|bash installer script.
if ! command -v python3 >/dev/null 2>&1; then
	carcara_err "python3 is required to resolve Zen GitHub release URL"
	exit 1
fi

zen_url="$(
	curl -fsSL -H 'Accept: application/vnd.github+json' \
		'https://api.github.com/repos/zen-browser/desktop/releases/latest' \
		| ASSET="$asset" python3 -c '
import json, os, sys
asset = os.environ["ASSET"]
data = json.load(sys.stdin)
for a in data.get("assets") or []:
    if a.get("name") == asset:
        print(a["browser_download_url"])
        sys.exit(0)
sys.exit(1)
'
)" || true

if [[ -z "${zen_url:-}" ]]; then
	carcara_err "Could not find ${asset} on https://github.com/zen-browser/desktop/releases/latest"
	exit 1
fi

carcara_log "Zen release asset: $zen_url"
if run_with_progress "Zen Browser (AppImage)" install_appimage_url zen "$zen_url" "$ZEN_OPT"; then
	if [[ -x "${ZEN_OPT}/zen.AppImage" ]] || [[ -x "$ZEN_BIN" ]] || pkg_present command zen; then
		exit 0
	fi
fi

carcara_err "Zen Browser install failed"
exit 1
# Fim
