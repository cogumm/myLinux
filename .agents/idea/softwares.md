# Idea — curated software catalog

Status: living list (Carcará 1.x + 2.0 Software view)  
Updated: 17 de Novembro de 2026

Install policy: **apt (distro or official keyring) → Flatpak/Flathub → Snap**. Idempotent via `pkg_present`.  
Vendor `.deb` downloads use `install_deb_url` (no `curl | bash`).

**Backlog / waves:** `memory-bank/TODO.md` § v2.0.1.  
**Research pointer:** `.agents/idea/listSoftwares.md` → [Snap Store](https://snapcraft.io/store).

## 1.x menu folders (Wave B taxonomy)

`development` · `games` · `browsers` · `social` · `productivity` · `music` · `utilities`  
(Not all 19 Snap categories — enough to match shipped installers.)

## Shipped (Wave 2 + A + B)

| App | Script | Path |
|-----|--------|------|
| Git / VS Code / Cursor / Insomnia / Postman / Termius / Fira Code / Docker | `development/*` | see Wave A |
| **Steam** / **Heroic** / **Lutris** | `games/*` | Flatpak → Snap/apt |
| **Firefox** / **Brave** / **Vivaldi** / **Opera** / **Zen** | `browsers/*` | apt/keyring/Flatpak/Snap |
| Discord / Spotify / Telegram / WhatsApp | `social/*` | Flatpak / Snap |
| Dropbox / Anki / Notion / Thunderbird | `productivity/*` | Flatpak / Snap / apt |
| **Audacity** / **Navidrome** | `music/*` | apt/Flatpak/Snap |
| VLC / OBS | `utilities/*` | apt → Flatpak → Snap |

Wishlist **Zem** → **Zen Browser** (`browsers/zen.sh`) via [GitHub Releases](https://github.com/zen-browser/desktop/releases) AppImage (`install_appimage_url`).  
**Opera GX** tile installs Linux **Opera** (Snap/Flatpak); dedicated GX package is not consistently available.

## Intentionally not ported from `old/`

- `curl \| bash` get.docker.com, tutum helpers, LAMP/PHP5, dead PPAs

## Note

Docker Desktop ≠ Engine — Wave C only if needed.
