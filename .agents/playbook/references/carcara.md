# Carcará

## Flow

`startApp.sh` → (license historically via Zenity; currently falls through) → `menuGeral.sh` loop.

Main options (UI labels as shipped): “Atualizar sistema” · “Instalar programas de desenvolvimento” · “Instalar programas diversos” · “Correção do sistema” · “Limpeza do sistema” · “Limpeza de memória” (stub) · “Sair”.

Software menu: “Desenvolvimento” / “Produção” / “Social” / “Utilidades” — Social and Utilities are wired; Development and Productivity are still menu stubs even though scripts exist under `development/` and `productivity/`.

## Installers present

- development: `firacode.sh`, `git.sh`, `insomnia.sh`, `vscode.sh` (snap)
- social: discord, spotify, telegram + `_menu.sh`
- utilities: vlc + `_menu.sh`
- productivity: `dropbox.sh`
- system: `updateDistro.sh`, `cleanDistro.sh`, `fixSystem.sh`, `sync_time.sh`

## Bootstrap (Wave 1 Step 1 — done)

- `dependences.sh`: detects `yad` / `zenity` / `curl` via `command -v`; installs with `apt-get`; ensures `snapd` and optional `flatpak`.
- `startApp.sh`: Zenity license gate restored (`--checkbox=Continuar`) then `bash "$menuApp"`.
- All installers source `. app/config/config.sh` (cwd must be `carcara/`).
- `testConnection.sh` is **sourced** from `dependences.sh` so `$configYad` is inherited.

## Fix priorities (remaining)

1. Wave 1 Step 2 — `install_backends.sh`.
2. Wire the development / productivity menus.
3. Replace interactive `read` inside Yad flows with consistent TUI confirms where possible.
4. Wave 2 — rewrite app installers onto Flatpak/apt keyrings.
