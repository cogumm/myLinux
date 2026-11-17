# Carcará

## Flow

`startApp.sh` → `config.sh` (loads backends) → `dependences` → Zenity license → `menuGeral.sh` loop.  
Main menu: Atualizar · Instalar · Correção · Limpeza · **Dotfiles** · Sair.

Main options (trimmed 17 Nov 2026): “Atualizar sistema” · “Instalar programas” → `menuSof` · “Correção do sistema” · “Limpeza do sistema” · “Sair”.  
(Removed stubs: “programas diversos”, “Limpeza de memória”.)

Software menu: “Desenvolvimento” / “Produção” / “Social” / “Utilidades” — all four wired (`development/_menu.sh`, `productivity/_menu.sh`, `social/_menu.sh`, `utilities/_menu.sh`).

## Installers present (Wave 2 — thin / backends)

Policy: apt (distro or keyring) → Flatpak/Flathub → Snap. Idempotent via `pkg_present`.

| Area | Script | Preferred path |
|------|--------|----------------|
| utilities | `vlc.sh` | apt `vlc` → Flatpak → Snap |
| social | `discord.sh` | Flatpak → Snap |
| social | `spotify.sh` | Spotify apt keyring → Flatpak → Snap |
| social | `telegram.sh` | Flatpak → Snap (`telegram-desktop` only) |
| development | `git.sh` | apt `git` + gui/doc/gitg |
| development | `vscode.sh` | Microsoft apt → Snap `--classic` |
| development | `insomnia.sh` | Flatpak → Snap |
| development | `firacode.sh` | apt `fonts-firacode` |
| productivity | `dropbox.sh` | Flatpak → Snap |
| system | update / fix / clean / `sync_time.sh` | (Wave 1) |

## Bootstrap (Wave 1 Step 1 — done)

- `dependences.sh`: installs `yad` / `zenity` / `curl` **first** (echo-only until Yad exists), then runs `testConnection`; ensures `snapd` and optional `flatpak`.
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

- Desenvolvimento → git / VS Code / Insomnia / Fira Code
- Produção → Dropbox
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

1. Package Carcará 2.0 `.deb` (+ optional AppImage).
2. Live install / pkexec smoke-test on a disposable machine (owner-requested).
