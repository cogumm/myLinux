# Active context — myLinux

Last updated: 2026-11-17

## Current focus

**Carcará 2.0 usable alpha** (`carcara-electron/`, package `2.0.1`).  
**1.x** (`carcara/`) = install/maintenance **engine** + CLI/fallback.  
**Packaging:** `.deb` via `bun run pack:deb` + GHA `.github/workflows/release-deb.yml` (Release → asset).  
**Next product slice:** owner smoke (Software / pkexec) + **v2.0.1** catalog waves A→C — `memory-bank/TODO.md`.

Canonical agent how-to:

| Doc | Role |
|------|------|
| `.agents/playbook/references/carcara-2.0.md` | 2.0 operator + agent how-to |
| `.agents/playbook/references/carcara.md` | 1.x menus, backends, `carcara_confirm` |
| `.agents/playbook/references/dotfiles.md` | `apply.sh` + menus |
| `.agents/playbook/references/i18n.md` | Nested `locales` + flatten + rail PT\|EN |
| `.agents/playbook/references/legacy.md` | `old/` — port ideas only |
| `design-system/carcara-2-0/pages/app-shell.md` | Rail / tiles / pager / lang switch |
| `memory-bank/TODO.md` | Inbox + **v2.0.1 waves** |

## Session consolidation (17 Nov 2026) — full dump

### i18n (1.x + 2.0) — done

- Shared **nested** JSON: `locales/{pt,en}.json` (groups `menu`, `install`, `tile`, `view`, `sobre`, …).
- Runtime **flattens** to dotted keys (`menu.choose`, `tile.update.title`) so call sites stay stable.
  - Bash: `carcara/app/config/i18n.sh` (python3 flatten) + Zenity **stable IDs**.
  - Renderer: `lib/flatten-locale.ts` + `lib/i18n.ts`.
  - Main: `native-i18n.ts` (app menu + root messages).
- Default: Zod / env **`CARCARA_LANG=pt|en`**.
- Rail **PT | EN** switch: `components/lang-switch.ts` → `localStorage` key `carcara.lang` → remount UI; env remains default if storage empty.
- Native Electron menu follows env until process restart.
- Product names / technical hints / `cogumm.net` not translated.
- Sobre facts: `sobre.fact.*.label` / `.value`.

### Brand version — done

- Rail pill reads **`package.json` `"version"`** via `src/renderer/lib/version.ts` (bundled at build).
- Current: `2.0.1` — change package.json + rebuild to update UI / `.deb` version.

### Sistema: sync clock — done

- Hardened `carcara/app/scripts/system/sync_time.sh`: `timedatectl set-ntp` → fallback `ntpdate`; NI + `carcara_confirm`; no nested `sudo` under helper.
- 2.0 tile **NTP** → helper action `sync-time` (privileged allowlist).

### Software UX — done

- **Pagination:** `createPagedTiles` + `createPager`; **6 tiles/page**; pager hidden if ≤1 page.
- `bindTiles` uses **event delegation** (pages stay clickable after swap).
- i18n: `pager.prev` / `next` / `status` / `aria`.

### Catalog planning — v2.0.1 (open)

- Tracker: `TODO.md` § **v2.0.1** (waves A / B / C).
- `.agents/idea/listSoftwares.md` = Snap Store research pointer only (no duplicate bullet list).
- Already shipped vs wishlist: Git, VS Code, Docker **Engine**, Insomnia, Discord, Telegram, Spotify.
- Wave A first: Firefox, WhatsApp, Cursor, Termius, Anki, Steam, Notion, Brave, Postman, Thunderbird, OBS, …
- Wave B: categories **Browsers** / **Games** (Epic·GOG via Heroic; Battle.net via Wine/Lutris) / **Media**.
- Wave C: Libre/OnlyOffice, password managers, Proton, NordVPN, Node toolchain, optional Docker Desktop, presets, search/badges.
- Policy unchanged: **apt → Flatpak → Snap**.

### `old/` reuse guidance (settled)

- **Ported:** Docker install path only.
- **Idea-only** (rewrite thin installers): Anki, Wine/Lutris, Chrome/Firefox, GIMP/archives, TeamViewer-class remote — if on v2.0.1 list.
- **Do not port:** LAMP/PHP5, dead PPAs, curl\|bash Docker, tutum, Popcorn, Skype i386, etc. (see `references/legacy.md`).

### Still in force from earlier same day

- Zod env + `z.prettifyError` (not `.flatten()`).
- Tile hover-only teal; orange only confirm CTA.
- License gate 2.0 = 1.x `license` file.
- `carcara_confirm` auto-yes when root / `CARCARA_NONINTERACTIVE`.
- Dotfiles always as `$SUDO_USER`; `apply.sh` never root.
- `dependences.sh` hardened (os-release, Flathub, NI notify).
- Docker CE apt → `docker.io` (+ docker group).
- Root required for 2.0 UI; Bun PATH under sudo; WSL openExternal + GPU flags.
- Atividade: merged stdout/stderr; Dracula + JetBrains Mono.
- Images only under `assets/img/`.

## Validated

- Sistema as root: update / fix / clean → exit 0.
- `bun run helper -- dotfiles-dry-run` OK.
- `bun run typecheck` + `bun run build` OK after i18n nest / pager / sync-time / version pill.
- `bun run pack:deb` → `release/carcara_2.0.1_amd64.deb` (~75 MB) with `resources/mylinux/` + postinst wrapper.

## Still open

1. Smoke-test Software + **pkexec** on real desktop (owner-requested).
2. Execute **v2.0.1** Wave A→C installers (see `TODO.md`).
3. Optional AppImage.

## Blockers / notes

- Already-root → helper skips `pkexec` (expected). Elevation tests need unelevated desktop session.
- WSL GPU / `--no-sandbox` noise is environmental.
- Bash i18n flatten needs **python3** on the host.
