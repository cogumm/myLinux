# Carcará

## Flow

`startApp.sh` → `config.sh` (loads backends) → `dependences` → Zenity license → `menuGeral.sh` loop.  
Main menu (trimmed 17 Nov 2026): Atualizar · Instalar → `menuSof` · Correção · Limpeza · **Dotfiles** · Sair.  
(Removed stubs: “programas diversos”, “Limpeza de memória”.)

Software menu (Wave C): Desenvolvimento · Jogos · Navegadores · Social · Produtividade · Música · Segurança · Utilidades · Presets.

## Installers present (Wave 2 + Wave A — thin / backends)

Policy: apt (distro or keyring) → Flatpak/Flathub → Snap. Vendor `.deb` via `install_deb_url`. Idempotent via `pkg_present`.

| Area | Script | Preferred path |
|------|--------|----------------|
| utilities | `vlc` / `obs` / `proton-vpn` / `nordvpn` | apt/Flatpak/Snap |
| browsers | `firefox` / `brave` / `vivaldi` / `opera` / `zen` | apt/keyring/Snap/AppImage |
| games | `steam` / `heroic` / `lutris` | Flatpak → Snap/apt |
| music | `audacity` / `navidrome` | apt/Flatpak/Snap |
| social | `discord` / `spotify` / `telegram` / `whatsapp` / `proton-mail` | Flatpak/Snap |
| security | `bitwarden` / `onepassword` | Flatpak / vendor deb |
| development | Wave A + `nodejs.sh` (NodeSource + pnpm/yarn + Bun zip) | mixed |
| productivity | Wave A + `libreoffice` / `onlyoffice` | apt/Flatpak |
| presets | `dev-box` / `social-box` / `gaming-light` | chains thin installers |
| system | update / fix / clean / `applyDotfiles.sh` / `sync_time.sh` | Wave 1 + Dotfiles |

## Bootstrap (Wave 1 Step 1 — done)

- `dependences.sh` (hardened): apt-family via `/etc/os-release`; required `yad`/`zenity`/`curl`/`iputils-ping` (apt update only if missing); then `testConnection`; optional `snapd` (+ systemd socket best-effort) and `ensure_flatpak_flathub`; Yad notify uses `$configYad` (not blocking); NI → log only.
- `startApp.sh`: Zenity license gate; abort if `dependences` fails.
- All installers source `. app/config/config.sh` (cwd must be `carcara/`).
- `testConnection.sh` is sourced for the function only; auto-run only when executed as a script.

## Install backends (Wave 1 Step 2 — done)

Library: `carcara/app/config/install_backends.sh` (sourced from `config.sh`).

| Function | Purpose |
|----------|---------|
| `pkg_present <command\|dpkg\|flatpak\|snap> <name>` | Idempotent presence check |
| `apt_install <pkgs…>` | Non-interactive `apt-get install -y` |
| `ensure_apt_keyring_repo <name> <key_url> <deb_line>` | Modern `/etc/apt/keyrings` + `sources.list.d` (no `apt-key`) |
| `ensure_flatpak_flathub` | Install flatpak + add Flathub |
| `flatpak_install <app-id>` | Idempotent Flathub install |
| `snap_install <name> [--classic …]` | Idempotent snap install (installs snapd if needed) |
| `install_deb_url <dpkg-name> <url>` | curl `.deb` → dpkg -i → `apt-get -f` (Cursor; reusable) |
| `install_appimage_url <name> <url> [dir]` | curl AppImage → `/opt/<name>/` + `/usr/local/bin/<name>` (Zen) |
| `run_with_progress <title> <cmd…>` | Optional Yad pulsate; preserves `PIPESTATUS[0]` |

Logs go to stderr as `[carcara] …` / `[carcara:error] …` for CLI and future Electron.

Example (Wave 2 installer shape):

```bash
. app/config/config.sh   # also loads install_backends.sh
pkg_present command code && exit 0
snap_install code --classic
```

## System scripts (Wave 1 Step 3 — done)

- `updateDistro.sh` — `carcara_confirm` + `apt-get update|upgrade|full-upgrade` via `run_with_progress`.
- `fixSystem.sh` — `apt-get -f install` + `dpkg --configure -a`.
- `cleanDistro.sh` — trash/`/var/tmp`/clean/autoclean/autoremove; locks & apt lists via `carcara_confirm`.
- `applyDotfiles.sh` — Zenity submenu → `dotfiles/apply.sh` as `$SUDO_USER` (never root `$HOME`).
- `carcara_confirm` (in `install_backends.sh`): **root** or `CARCARA_NONINTERACTIVE=1` → auto-yes (no terminal `[y/N]`).

## Menus (Wave 1 Step 4 — done)

- Desenvolvimento → … + Node toolchain
- Jogos / Navegadores / Música — Wave B
- Produção → … + LibreOffice / OnlyOffice
- Social → … + Proton Mail
- Segurança → Bitwarden / 1Password
- Utilidades → VLC / OBS / Proton VPN / NordVPN
- Presets → Dev box / Social box / Gaming light
- Voltar breaks back to parent (no nested `bash $menuSof`)

## QA (Wave 1 Step 5 — done)

- Project `.shellcheckrc` (`shell=bash`, `SC1091` disabled for runtime sources).
- Wave 1 scripts: `bash -n` + ShellCheck clean (`shellcheck` binary optional under `.tools/`, gitignored).
- Shared paths/`configYad*` are `export`ed from `config.sh`; `isRoot` uses `$(id -u)`.

## Menus — Voltar

All software category menus (`development`, `productivity`, `social`, `utilities`) and `menuSof` use `break` (no nested `bash $menuSof`).

## Carcará 2.0 (Electron)

Full reference: **`references/carcara-2.0.md`**.  
Plan: `.agents/idea/carcara-2.0-electron.md`.  
1.x remains CLI/fallback (`startApp.sh`). Chooser: `./start.sh`.  
Alpha UI: modular views/components, Flat Design, helper allowlist + `CARCARA_NONINTERACTIVE=1`.

## Fix priorities (remaining)

1. Live install / pkexec via `carcara-electron` `bun run smoke:software -- --pkexec` / `--live` (owner-requested; Waves A–C + Wave 2).
2. Optional Electron AppImage packaging.
