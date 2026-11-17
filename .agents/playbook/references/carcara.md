# Carcará

## Flow

`startApp.sh` → `config.sh` (loads backends) → `dependences` → Zenity license → `menuGeral.sh` loop.

Main options (UI labels as shipped): “Atualizar sistema” · “Instalar programas de desenvolvimento” · “Instalar programas diversos” · “Correção do sistema” · “Limpeza do sistema” · “Limpeza de memória” (stub) · “Sair”.

Software menu: “Desenvolvimento” / “Produção” / “Social” / “Utilidades” — Social and Utilities are wired; Development and Productivity are still menu stubs even though scripts exist under `development/` and `productivity/`.

## Installers present

- development: `firacode.sh`, `git.sh`, `insomnia.sh`, `vscode.sh` (snap)
- social: discord, spotify, telegram + `_menu.sh`
- utilities: vlc + `_menu.sh`
- productivity: `dropbox.sh`
- system: `updateDistro.sh`, `cleanDistro.sh`, `fixSystem.sh`, `sync_time.sh`

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

## Fix priorities (remaining)

1. Wave 1 Step 3 — modernize `updateDistro` / `fixSystem` / `cleanDistro`.
2. Wave 1 Step 4 — minimal menu wiring (Desenvolvimento / Produção).
3. Wave 1 Step 5 — ShellCheck on touched tree.
4. Wave 2 — thin installers onto backends (no Yad polish).
