# Carcará 2.0 (Electron + Bun)

Canonical plan: `.agents/idea/carcara-2.0-electron.md`  
Design: `design-system/carcara-2-0/` (`MASTER.md`, `pages/app-shell.md`, `tokens.css`)  
Skill: `.agents/skills/ui-ux-pro-max`  
Memory dump: `memory-bank/activeContext.md` (session 17 Nov 2026)

## Entry

| Command | What |
|---------|------|
| `./start.sh` | Chooser Electron vs terminal |
| `sudo ./start.sh --electron` | Carcará 2.0 — **requires root** (re-exec via sudo like 1.x) |
| `sudo ./start.sh --terminal` | Carcará 1.x |
| `cd carcara-electron && bun run build` | `tsc` + Bun IIFE renderer (build OK as user) |
| `bun run helper -- ping` | `testConnection.sh` (Google DNS IP `8.8.8.8`) |
| `bun run helper -- dotfiles-dry-run` | Preview `dotfiles/apply.sh --dry-run --all` as user |

**Root policy:** Electron main `requireRoot()` (uid 0), mirroring 1.x `isRoot`. `start.sh --electron` elevates with `sudo` and preserves `DISPLAY` / `WAYLAND_DISPLAY` / `XAUTHORITY`.  
**Bun under sudo:** `secure_path` drops `~/.bun/bin`. `ensure_bun_on_path` in `start.sh` recovers `$SUDO_USER/.bun/bin`.

## Boot sequence

1. `requireRoot()` (unless `CARCARA_REQUIRE_ROOT=0` in `.env`)
2. **License gate** — same text as 1.x `carcara/app/config/license`; checkbox Continuar → Aceitar; Sair → `app:quit`
3. Shell mounts (rail + stage + Atividade)

## Architecture

```
Renderer (license-gate → views + components)
  → preload IPC
  → Electron main (spawn bun | license:get | app:quit | openExternal)
  → scripts/run-helper.ts (Bun.$)
  → helper/carcara-helper.sh (allowlist)
  → carcara/ 1.x scripts (CARCARA_NONINTERACTIVE=1)
     or dotfiles/apply.sh as $SUDO_USER
```

- **Never** reimplement apt/flatpak/snap in the renderer.
- Unknown helper actions → exit 2.

## Renderer layout (modular)

```
src/renderer/
  main.ts              # license gate → mountApp
  app.ts               # shell, routing, runAction
  views/               # sistema | software | dotfiles | sobre
  components/          # rail, tile, license-gate, confirm-dialog, activity-console, …
  lib/                 # types, api, log-highlight
  styles.css           # Flat tokens + terminal + license-gate
  index.html           # CSP + #app
src/env.ts             # Zod + dotenv
```

- `tsconfig.json` — main + preload + open-external + app-menu + **env**
- `tsconfig.renderer.json` — typecheck renderer (`moduleResolution: bundler`)
- Build: Bun IIFE → `dist/renderer/renderer.js`; copies CSS/HTML/`license.txt`/assets

## UI patterns (ui-ux-pro-max)

| Piece | Rule |
|-------|------|
| Style | Flat Design, dark; primary `#0D9488`, accent `#EA580C` (CTA only), card `#111827` |
| Brand | `assets/img/logo_moderno_final.png`; wordmark + `2.0` pill beside name |
| Rail | Sistema / Software / **Dotfiles** / Sobre; footer `MIT · 2010–YYYY · cogumm.net` |
| Tiles | Resting = neutral border; **hover** = teal left inset + primary border (no permanent orange outline) |
| Software | Secondary `nav-list` (same `.rail__link`) for categories → tiles |
| Confirms | `<dialog>` before mutating helper actions |
| Terminal | Dracula-like; JetBrains Mono 13px (local woff2); line numbers; stdout+stderr merged chronologically |
| Sobre | Facts from root README; allowlisted external links |
| License | Full-screen gate before shell (`license-gate.ts`) |

When changing visuals: run skill `--design-system`; read `pages/app-shell.md` first.

## Privilege / WSL

- App runs as **root**. When already root, helper skips `pkexec`.
- **Unprivileged helper actions** (no pkexec): `ping`, `dotfiles-*` (always target real user `$HOME` via `$SUDO_USER`).
- **External URLs (Sobre):** allowlist in `main.ts`; WSL → PowerShell `Start-Process`, then `cmd start`, then `shell.openExternal`; else copy URL.
- Electron as root: `--no-sandbox`. WSL: also `--disable-gpu` / `--disable-dev-shm-usage` + `LIBGL_ALWAYS_SOFTWARE=1` (start.sh) to cut DRI3/MESA noise.
- Native menubar: **Arquivo → Sair**, **Sobre → Sobre o projeto** (IPC → view Sobre).

## Helper allowlist

`ping` · `apt-dry-run` · `update-distro` · `fix-system` · `clean-distro` ·  
`dotfiles-{dry-run,aliases,all,git,hyper,theme,bashrc}` ·  
`install-{vlc,discord,spotify,telegram,git,vscode,insomnia,firacode,docker,dropbox}`

## Environment (Zod)

- Example: `carcara-electron/.env.example` → `.env` (gitignored)
- Schema: `src/env.ts` — Zod 4 + `dotenv`; errors via **`z.prettifyError()`** (not deprecated `.flatten()`)
- Consumed by `main.ts` (window, root gate, lang) and `run-helper.ts` (lang + ping host/count)
- **`CARCARA_LANG`:** `pt` (default) | `en` — shared with 1.x; strings in repo `locales/*.json` (playbook `references/i18n.md`)

## Dotfiles (2.0)

- View tiles map 1:1 to helper actions → `dotfiles/apply.sh` as `$SUDO_USER`
- Engine docs: `references/dotfiles.md` + `docs/dotfiles.md`
- Never write into root’s home

## Assets

- Images: repo `assets/img/*` → `dist/renderer/assets/`
- Font: `carcara-electron/assets/fonts/JetBrainsMono-Regular.woff2`
- License copy: `dist/renderer/license.txt` (IPC prefers live `carcara/app/config/license`)
- CSP: `default-src 'self'`; `font-src 'self'` (no Google Fonts CDN)

## Still open

1. Package `.deb` (AppImage optional)
2. Live smoke-test Software + pkexec on real desktop / WSLg (owner-approved)
3. See `memory-bank/TODO.md` for 1.x leftovers (smoke-test installers, i18n, …)
