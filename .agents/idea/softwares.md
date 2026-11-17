# Idea — curated software catalog

Status: living list (Carcará 1.x + 2.0 Software view)  
Updated: 17 de Novembro de 2026

Install policy: **apt (distro or official keyring) → Flatpak/Flathub → Snap**. Idempotent via `pkg_present`.

## Development

| App | Script | Path |
|-----|--------|------|
| Git | `development/git.sh` | apt |
| VS Code | `development/vscode.sh` | Microsoft apt → Snap classic |
| Insomnia | `development/insomnia.sh` | Flatpak → Snap |
| Fira Code | `development/firacode.sh` | apt |
| **Docker** | `development/docker.sh` | Docker CE apt → `docker.io` (replaces `old/scripts/docker.sh`) |

## Productivity / Social / Utilities

Dropbox · Discord · Spotify · Telegram · VLC — see playbook `references/carcara.md`.

## Intentionally not ported from `old/scripts/docker.sh`

- `curl \| bash` get.docker.com
- Destructive “clean all containers/images” (+ btrfs subvolume delete)
- Hardcoded `tutum/apache-php` run/exec helpers
