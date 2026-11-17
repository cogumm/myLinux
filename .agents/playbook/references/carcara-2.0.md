# Carcará 2.0 (Electron + Bun)

Canonical plan: `.agents/idea/carcara-2.0-electron.md`  
Design: `design-system/carcara-2-0/` (`MASTER.md`, `pages/app-shell.md`, `tokens.css`)  
Skill: `.agents/skills/ui-ux-pro-max`

## Entry

| Command | What |
|---------|------|
| `./start.sh` | Chooser Electron vs terminal |
| `sudo ./start.sh --electron` | Carcará 2.0 — **requires root** (re-exec via sudo like 1.x) |
| `sudo ./start.sh --terminal` | Carcará 1.x |
| `cd carcara-electron && bun run build` | `tsc` + Bun IIFE renderer (build OK as user) |
| `bun run helper -- ping` | Runs `carcara/app/config/testConnection.sh` (Google DNS IP `8.8.8.8`; override `CARCARA_TEST_HOST` / `CARCARA_TEST_COUNT`) |

**Root policy:** Electron main calls `requireRoot()` (uid must be 0), mirroring 1.x `isRoot`. `start.sh --electron` elevates with `sudo` and preserves `DISPLAY`/`WAYLAND_DISPLAY`/`XAUTHORITY`.

## Architecture

```
Renderer (views + components)
  → preload IPC
  → Electron main (spawn bun)
  → scripts/run-helper.ts (Bun.$)
  → helper/carcara-helper.sh (allowlist)
  → carcara/ 1.x scripts (CARCARA_NONINTERACTIVE=1)
```

- **Never** reimplement apt/flatpak/snap in the renderer.
- Unknown helper actions → exit 2.

## Renderer layout (modular)

```
src/renderer/
  main.ts          # mount #app
  app.ts           # shell, routing, runAction
  views/           # one file per menu: sistema | software | sobre
  components/      # createRail, createTile, createNavList, createActivityConsole, …
  lib/             # types, api, log-highlight
  styles.css       # Flat Design tokens + terminal theme
  index.html       # CSP + #app
```

- `tsconfig.json` — main + preload + `open-external.ts` only  
- `tsconfig.renderer.json` — typecheck renderer (`moduleResolution: bundler`)  
- Build bundles renderer to `dist/renderer/renderer.js` (IIFE)

## UI patterns (ui-ux-pro-max)

| Piece | Rule |
|-------|------|
| Style | Flat Design, dark; primary `#0D9488`, accent `#EA580C`, card `#111827` |
| Brand | `assets/img/logo_moderno_final.png`; wordmark + `2.0` pill **beside** name |
| Rail | Sistema / Software / Sobre; footer `MIT · 2010–YYYY · @CoGUMm` (one line) |
| Software | Secondary `nav-list` (same `.rail__link`) for categories → tiles |
| Confirms | `<dialog>` before mutating actions |
| Terminal | Dracula-like; JetBrains Mono 13px (local woff2); line numbers; token colors |
| Sobre | Facts from root README (no logo gallery); link buttons |

When changing visuals: run skill `--design-system`; read `pages/app-shell.md` first.

## Privilege / WSL

- **App must run as root** (same as 1.x). Gate: `start.sh` sudo re-exec + `main.ts` `requireRoot()`.
- When already root, helper skips `pkexec` (direct allowlist script).
- **Unprivileged helper action:** `ping` (ICMP) — no pkexec warning if somehow run as non-root via `bun run helper`.
- **External URLs (Sobre):** allowlist in `main.ts`; on WSL open via Windows PowerShell `Start-Process` (`src/open-external.ts`), fallback `cmd start`, then `shell.openExternal`. If all fail, UI copies URL.
- GPU/`--no-sandbox` noise on WSL is expected; Electron as root typically needs `--no-sandbox` (already in `package.json`).

## Helper allowlist

`ping` · `apt-dry-run` · `update-distro` · `fix-system` · `clean-distro` ·  
`install-{vlc,discord,spotify,telegram,git,vscode,insomnia,firacode,dropbox}`

## Assets

- Images: repo `assets/img/*` → build copies to `dist/renderer/assets/`
- Font: `carcara-electron/assets/fonts/JetBrainsMono-Regular.woff2`
- CSP: `default-src 'self'`; `font-src 'self'` (no Google Fonts CDN)

## Still open

1. Package `.deb` (AppImage optional)
2. Live smoke-test system + software with pkexec on real desktop / WSLg (owner-approved)
