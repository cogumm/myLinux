# Carcará

Interactive Bash installer for apt-based systems.

## Run

```bash
cd carcara
sudo bash startApp.sh
```

Requires network for installs; UI depends on `yad`, `zenity`, `curl`, and optionally `snap`.

## Structure

See `carcara/README.md` tree. Config hub: `app/config/config.sh`. Menus: `menuGeral.sh`, `software/menuSof.sh`.

## Categories

| Menu | Status |
|------|--------|
| Atualizar sistema | `system/updateDistro.sh` |
| Instalar programas de desenvolvimento | Menu stub; scripts in `software/development/` |
| Instalar programas diversos | Stub |
| Correção do sistema | `system/fixSystem.sh` |
| Limpeza do sistema | `system/cleanDistro.sh` |
| Limpeza de memória | Stub |
| Social / Utilidades (via software menu) | Wired |

## Install backends (1.x engine)

Shared helpers in `app/config/install_backends.sh` (loaded via `config.sh`): `apt_install`, `ensure_apt_keyring_repo`, `flatpak_install`, `snap_install`, `pkg_present`, `run_with_progress`.

## Safety

Runs as root. Review scripts before use. Author disclaimer applies (`head` in `config.sh`).
