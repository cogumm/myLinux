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

## Fix priorities

1. Wire the development menu to existing scripts.
2. Repair `dependences.sh` detection.
3. Unify the `config.sh` sourcing path.
4. Replace interactive `read` inside Yad flows with consistent TUI confirms where possible.
