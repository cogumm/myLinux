# Idea — curated software catalog

Status: living list (Carcará 1.x + 2.0 Software view)  
Updated: 17 de Novembro de 2026

Install policy: **apt (distro or official keyring) → Flatpak/Flathub → Snap**.  
Vendor `.deb` / AppImage / zip via `install_deb_url` / `install_appimage_url` / GitHub (no `curl | bash`).

**Status:** Waves 2 + A–C shipped (v2.0.1). New apps → **v2.0.2** in `memory-bank/TODO.md`.  
**Research pointer:** `.agents/idea/listSoftwares.md` → [Snap Store](https://snapcraft.io/store).

## 1.x menu folders

`development` · `games` · `browsers` · `social` · `productivity` · `music` · `security` · `utilities` · `presets`

## Shipped (Waves 2 + A + B + C)

| Area | Apps |
|------|------|
| development | Git, VS Code, Cursor, Insomnia, Postman, Termius, Fira Code, **Node toolchain**, Docker Engine, **Dev box** preset |
| games | Steam, Heroic, Lutris, **Gaming light** preset |
| browsers | Firefox, Brave, Vivaldi, Opera, Zen (GitHub AppImage) |
| social | Discord, Spotify, Telegram, WhatsApp, **Proton Mail**, **Social box** preset |
| productivity | Dropbox, Anki, Notion, Thunderbird, **LibreOffice**, **OnlyOffice** |
| music | Audacity, Navidrome |
| security | **Bitwarden**, **1Password** |
| utilities | VLC, OBS, **Proton VPN**, **NordVPN** |

**Docker Desktop** intentionally not shipped — Engine is enough.  
**Zen** → [GitHub Releases](https://github.com/zen-browser/desktop/releases) AppImage.  
**Bun** (in Node toolchain) → GitHub `bun-linux-x64.zip` → `/opt/bun` + `/usr/local/bin/bun`.

## Intentionally not ported from `old/`

- `curl \| bash` get.docker.com, tutum helpers, LAMP/PHP5, dead PPAs
