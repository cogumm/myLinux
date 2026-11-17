# Idea — curated software catalog

Status: living list (Carcará 1.x + 2.0 Software view)  
Updated: 17 de Novembro de 2026

Install policy: **apt (distro or official keyring) → Flatpak/Flathub → Snap**. Idempotent via `pkg_present`.  
Vendor `.deb` downloads use `install_deb_url` (no `curl | bash`).

**Backlog / waves:** `memory-bank/TODO.md` § v2.0.1 (source of planning).  
**Research pointer:** `.agents/idea/listSoftwares.md` → [Snap Store](https://snapcraft.io/store).

## Shipped (Wave 2 + Docker + Wave A)

| App | Script | Path |
|-----|--------|------|
| Git | `development/git.sh` | apt |
| VS Code | `development/vscode.sh` | Microsoft apt → Snap classic |
| **Cursor** | `development/cursor.sh` | vendor amd64 `.deb` (`install_deb_url`) |
| Insomnia | `development/insomnia.sh` | Flatpak → Snap |
| **Postman** | `development/postman.sh` | Flatpak → Snap |
| **Termius** | `development/termius.sh` | Snap → Flatpak |
| Fira Code | `development/firacode.sh` | apt |
| **Docker Engine** | `development/docker.sh` | Docker CE apt → `docker.io` |
| Dropbox | `productivity/dropbox.sh` | Flatpak → Snap |
| **Anki** | `productivity/anki.sh` | Flatpak → Snap |
| **Notion** | `productivity/notion.sh` | Snap → Flatpak |
| **Thunderbird** | `productivity/thunderbird.sh` | apt → Flatpak → Snap |
| Discord / Spotify / Telegram | `social/*.sh` | Flatpak / apt → Snap |
| **WhatsApp** | `social/whatsapp.sh` | Flatpak → Snap |
| VLC | `utilities/vlc.sh` | apt → Flatpak → Snap |
| **Firefox** | `utilities/firefox.sh` | apt → Flatpak → Snap |
| **Brave** | `utilities/brave.sh` | Brave apt keyring → Snap |
| **Steam** | `utilities/steam.sh` | Flatpak → apt `steam-installer` |
| **OBS Studio** | `utilities/obs.sh` | apt → Flatpak → Snap |

## Intentionally not ported from `old/scripts/docker.sh`

- `curl \| bash` get.docker.com
- Destructive “clean all containers/images” (+ btrfs subvolume delete)
- Hardcoded `tutum/apache-php` run/exec helpers

## Note

Wishlist **Docker Desktop** ≠ Engine — only add a Desktop tile if Engine is insufficient (see TODO Wave C).  
Wave B: Heroic / Wine-Lutris / 1.x folder taxonomy rewire.
