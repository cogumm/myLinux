# Idea — curated software catalog

Status: living list (Carcará 1.x + 2.0 Software view)  
Updated: 17 de Novembro de 2026

Install policy: **apt (distro or official keyring) → Flatpak/Flathub → Snap**. Idempotent via `pkg_present`.

**Backlog / waves:** `memory-bank/TODO.md` § v2.0.1 (source of planning).  
**Research pointer:** `.agents/idea/listSoftwares.md` → [Snap Store](https://snapcraft.io/store).

## Shipped (Wave 2 + Docker)

| App | Script | Path |
|-----|--------|------|
| Git | `development/git.sh` | apt |
| VS Code | `development/vscode.sh` | Microsoft apt → Snap classic |
| Insomnia | `development/insomnia.sh` | Flatpak → Snap |
| Fira Code | `development/firacode.sh` | apt |
| **Docker Engine** | `development/docker.sh` | Docker CE apt → `docker.io` |
| Dropbox | `productivity/dropbox.sh` | Flatpak → Snap |
| Discord / Spotify / Telegram | `social/*.sh` | Flatpak / apt → Snap |
| VLC | `utilities/vlc.sh` | apt → Flatpak → Snap |

## Intentionally not ported from `old/scripts/docker.sh`

- `curl \| bash` get.docker.com
- Destructive “clean all containers/images” (+ btrfs subvolume delete)
- Hardcoded `tutum/apache-php` run/exec helpers

## Note

Wishlist **Docker Desktop** ≠ Engine — only add a Desktop tile if Engine is insufficient (see TODO Wave C).
