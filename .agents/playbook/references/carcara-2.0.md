# Carcará 2.0 (Electron + Bun)

Canonical plan: `.agents/idea/carcara-2.0-electron.md`  
Design: `design-system/carcara-2-0/` (`MASTER.md`, `pages/app-shell.md`, `tokens.css`)  
Skill: `.agents/skills/ui-ux-pro-max`  
Memory dump: `memory-bank/activeContext.md` (session 17 Nov 2026)

## Entry

| Command | What |
|---------|------|
| `./start.sh` | Chooser Electron vs terminal |
| `./start.sh --electron` | Carcará 2.0 — **desktop user** (no sudo; drops root → `SUDO_USER` if needed) |
| `sudo ./start.sh --terminal` | Carcará 1.x |
| `cd carcara-electron && bun run build` | `tsc` + Bun IIFE renderer |
| `bun run pack:deb` | electron-builder → `release/carcara_<ver>_amd64.deb` |
| `bun run pack:appimage` | → `release/carcara_<ver>_amd64.AppImage` |
| `bun run pack:linux` | `.deb` + AppImage (CI) |
| `bun run helper -- ping` | Dev Bun bridge → `testConnection.sh` |
| `bun run helper -- dotfiles-dry-run` | Preview `dotfiles/apply.sh --dry-run --all` as user |
| Install `.deb` + `carcara` | Packaged path (pkexec wrapper; **no Bun**) — owner-requested only |

**Privilege policy:** GUI runs as the session user. Apt/install/fix/clean go through `helper` + `pkexec`. `CARCARA_REQUIRE_ROOT=1` is legacy opt-in only (default `0`). If `sudo ./start.sh --electron`, `start.sh` re-execs as `SUDO_USER` with display/session env.  
**Bun PATH:** `ensure_bun_on_path` recovers `~/.bun/bin` when missing from `PATH`.

## Boot sequence

1. Optional `requireRoot()` only if `CARCARA_REQUIRE_ROOT=1` (default off)
2. **License gate** — same text as 1.x `carcara/app/config/license`; checkbox Continuar → Aceitar; Sair → `app:quit`
3. Shell mounts (rail + stage + Atividade)

## Architecture

```
Renderer (license-gate → views + components)
  → preload IPC
  → Electron main (run-helper-node | license:get | app:quit | openExternal)
  → helper/carcara-helper.sh (allowlist; pkexec when needed)
  → carcara/ 1.x scripts (CARCARA_NONINTERACTIVE=1)
     or dotfiles/apply.sh as $SUDO_USER
```

- Dev-only Bun bridge: `bun run helper` → `scripts/run-helper.ts` (`Bun.$`).
- Packaged `.deb` uses Node `run-helper-node.ts` — **no Bun at runtime**.
- **Never** reimplement apt/flatpak/snap in the renderer.
- Unknown helper actions → exit 2.

## Renderer layout (modular)

```
src/renderer/
  main.ts              # lang + license gate → mountApp
  app.ts               # shell, routing, runAction, lang remount
  views/               # sistema | software | dotfiles | sobre
  components/          # rail, tile, paged-tiles, pager, lang-switch, license-gate, …
  lib/                 # types, api, i18n, flatten-locale, version, log-highlight
  styles.css           # Flat tokens + terminal + license-gate + pager
  index.html           # CSP + #app
src/env.ts             # Zod + dotenv
src/paths.ts           # repo root / packaged resources/mylinux
src/run-helper-node.ts # runtime helper (no Bun)
src/native-i18n.ts     # main-process nested locale flatten + `{version}`
```

- `tsconfig.json` — main + preload + open-external + app-menu + **env** (+ imports pull paths/helper)
- `tsconfig.renderer.json` — typecheck renderer (`moduleResolution: bundler`, `resolveJsonModule`)
- Build: Bun IIFE → `dist/renderer/renderer.js`; copies CSS/HTML/`license.txt`/assets; embeds `package.json` version

## UI patterns (ui-ux-pro-max)

| Piece | Rule |
|-------|------|
| Style | Flat Design, **light** shell; primary `#0F766E`, accent `#C2410C`; warm rail; Activity console stays Dracula dark |
| Brand | `assets/img/logo_moderno_final.png`; wordmark + **version pill** = `package.json` `"version"`; `window.title` / `ready.log` use `{version}` |
| Rail | Sistema / Software / **Dotfiles** / Sobre; footer PT\|EN + `MIT · 2010–YYYY · cogumm.net` |
| Lang | Env `CARCARA_LANG` default; rail switch → `localStorage` `carcara.lang` + remount |
| Tiles | Resting = neutral border; **hover** = teal left inset + primary border (no permanent orange outline) |
| Software | Snap Store **19 categories** → **paged** tiles (6/page); empty = `cat.empty` |
| Confirms | `<dialog>` before mutating helper actions |
| Terminal | Dracula-like; JetBrains Mono 13px (local woff2); line numbers; stdout+stderr merged chronologically |
| Sobre | Nested locale facts (`sobre.fact.*.label/.value`); allowlisted external links |
| License | Full-screen gate before shell (`license-gate.ts`) |

When changing visuals: run skill `--design-system`; read `pages/app-shell.md` first.

## Privilege / WSL

- App runs as **root**. When already root, helper skips `pkexec`.
- **Unprivileged helper actions** (no pkexec): `ping`, `dotfiles-*` (always target real user `$HOME` via `$SUDO_USER`).
- **External URLs (Sobre):** allowlist in `main.ts`; WSL → PowerShell `Start-Process`, then `cmd start`, then `shell.openExternal`; else copy URL.
- Electron as root: `--no-sandbox`. WSL: also `--disable-gpu` / `--disable-dev-shm-usage` + `LIBGL_ALWAYS_SOFTWARE=1` (start.sh) to cut DRI3/MESA noise.
- Native menubar: **Arquivo → Sair**, **Sobre → Sobre o projeto** (IPC → view Sobre).

## Helper allowlist

`ping` · `apt-dry-run` · `update-distro` · `fix-system` · `clean-distro` · `sync-time` ·  
`dotfiles-{dry-run,aliases,all,git,hyper,theme,bashrc}` ·  
`install-*` (full catalog Waves A–C) · `preset-{dev,social,gaming}` — see `helper/carcara-helper.sh` usage().  
Software UX: category search + tile `backend` badges; Sobre `host:info` (distro/arch/flatpak/snap).

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

## Packaging (`.deb`)

**Do not put `electron-builder.yml` under `.github/workflows/`.**  
Workflows orchestrate CI; builder config stays next to the Electron app (relative paths to `../carcara`, `build/deb/`, etc.).

| Piece | Path / command |
|-------|----------------|
| Builder config | `carcara-electron/electron-builder.yml` |
| Postinst wrapper | `carcara-electron/build/deb/after-install.sh` → `/usr/bin/carcara` + pkexec + `--no-sandbox` |
| Local build | `cd carcara-electron && bun run pack:deb` → `release/carcara_<ver>_amd64.deb` |
| CI | `.github/workflows/release-deb.yml` on **release: published** (+ `workflow_dispatch`) |
| Runtime layout | `resources/mylinux/{carcara,locales,dotfiles,assets,carcara-electron/helper}` |
| Paths | `src/paths.ts` (`getRepoRoot` / helper / locales / license / renderer) |
| Helper runtime | `src/run-helper-node.ts` — **Bun not required** on installed systems |
| Version / Package | `package.json` version; `extraMetadata.name: carcara` for Debian `Package:` |

### Release flow

1. Set `carcara-electron/package.json` `"version"` (or let CI sync from tag).
2. Publish GitHub Release with tag `vX.Y.Z`.
3. Workflow builds amd64 `.deb` + AppImage (`pack:linux`) and attaches both to that Release.

### afterInstall / FPM gotchas

- electron-builder FPM replaces `${LetterOnly}` in maintainer scripts as **macros**.
- Avoid `${REAL}`, `${Name}`, etc. Use `$VAR`, names with underscores, or `'heredoc'` + `sed` placeholder (`__CARCARA_BIN__`).
- Wrapper must elevate like 1.x when uid ≠ 0 (`pkexec` + display session env).

AppImage: `bun run pack:appimage` (portable; no afterInstall — use root/pkexec to launch). CI attaches AppImage with the `.deb`.

## Smoke

```bash
cd carcara-electron
bun run smoke:software              # wiring + bash -n + ping + pkexec probe
# Passwordless live (WSL-friendly — one-time sudoers, then no password):
# sudo bun run smoke:nopasswd-install
bun run smoke:elevated -- --live-safe
bun run smoke:elevated -- --live-extended
```

Harness: `smoke-software.sh` + optional `smoke-elevated.sh` (NOPASSWD scoped sudoers). Flags: `--live-core` / `--live-extended` / `--live-safe` / `--live …` — no `smoke:waveN`. Prefer `smoke:elevated` over pkexec on WSL (polkit often hangs without agent/TTY).

## Status

**v2.0.1 closed.** Next work lands in `memory-bank/TODO.md` under **v2.0.2**.  
Smoke: `smoke:elevated` after one-time `smoke:nopasswd-install` (prefer over pkexec on WSL).
