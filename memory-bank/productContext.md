# Product context — myLinux

Last updated: 2026-11-17

## Users

Primary: Gabriel (CoGUMm) on Ubuntu/Debian-family machines and WSL2.  
Secondary: anyone who clones the MIT repo and accepts root risk.

## Journeys

### A — Maintain system (Carcará 1.x)

1. `./start.sh --terminal` or `cd carcara && sudo bash startApp.sh`
2. Deps script ensures yad/curl/snap (and optional flatpak)
3. Main menu: update, install software, fix, clean
4. Yad shows progress; terminal shows apt detail

### B — Maintain / install via Carcará 2.0

1. `./start.sh --electron` (needs Bun)
2. Rail: **Sistema** (update/fix/clean/test connection) · **Software** (categories + tiles) · **Sobre**
3. Confirm dialog → helper → activity console (Dracula terminal)
4. Engine is still 1.x backends; UI never invents package policy

### C — Install curated apps (either UI)

Same catalog: Git, VS Code, Insomnia, Fira Code, Dropbox, Discord, Spotify, Telegram, VLC.  
Policy: apt → Flatpak → Snap where applicable.

### D — Apply dotfiles

1. `cd dotfiles && ./apply.sh --dry-run --all` then `./apply.sh --aliases` (or `--all`)
2. Backups as `*.bak`; never run as root — see `docs/dotfiles.md`

### E — WSL cleanup

1. `./cleanup-zone-identifiers.sh [dir] [--force]`
2. Removes Windows ADS leftover `*:Zone.Identifier` files

## UX principles

- Clear Portuguese menu labels / verbs (Atualizar, Instalar, Corrigir, Limpar)
- Root warning + disclaimer (1.x header; 2.0 Sobre + confirms)
- Prefer confirmations before destructive clean/repair
- Logs remain source of truth
- Brand-first rail (logo + Carcará + 2.0 pill)
- Flat Design tokens from `ui-ux-pro-max` — do not freestyle a new palette

## Non-goals

See `.agents/idea/mylinux.md` and product rules — not a SaaS, not a full distro installer.
