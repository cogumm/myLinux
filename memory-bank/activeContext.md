# Active context — myLinux

Last updated: 2026-11-17

## Current focus

**Carcará 2.0 usable alpha** (`carcara-electron/`, package **`2.0.1`**).  
**1.x** (`carcara/`) = install/maintenance **engine** + CLI/fallback.  
**Packaging shipped:** `.deb` via `electron-builder` + GHA Release workflow.  
**v2.0.1 Waves A–C shipped:** full curated catalog + presets + Software search/badges + Sobre host health.  
**Next:** live `--live` / pkexec on host with policykit or root; optional AppImage — `memory-bank/TODO.md`.  
**Smoke harness:** `cd carcara-electron && bun run smoke:software` (wiring PASS; pkexec SKIP on this WSL).  
**Skills installed:** `bash-scripting`, `debian-linux-triage` (+ existing shellcheck / ui-ux-pro-max) — see `.agents/skills/README.md`.

Canonical agent how-to:

| Doc | Role |
|------|------|
| `.agents/playbook/references/carcara-2.0.md` | 2.0 UI, helper, packaging, WSL |
| `.agents/playbook/references/carcara.md` | 1.x menus, backends, `carcara_confirm` |
| `.agents/playbook/references/dotfiles.md` | `apply.sh` + menus |
| `.agents/playbook/references/i18n.md` | Nested locales + `{version}` + rail PT\|EN |
| `.agents/playbook/references/legacy.md` | `old/` — port ideas only |
| `.agents/playbook/references/stack.md` | Entrypoints + toolchain |
| `design-system/carcara-2-0/pages/app-shell.md` | Rail / tiles / pager / lang |
| `memory-bank/TODO.md` | Inbox + **v2.0.1 waves** |

## Session consolidation (17 Nov 2026) — full dump

### Packaging `.deb` + CI — done

- **Config lives with the app**, not under `.github/workflows/`:
  - `carcara-electron/electron-builder.yml` — electron-builder (targets, `extraResources`, deb deps)
  - `.github/workflows/release-deb.yml` — GHA only (checkout → Bun → `pack:deb` → attach asset)
- **Local:** `cd carcara-electron && bun run pack:deb` → `release/carcara_<ver>_amd64.deb` (~75 MB validated for `2.0.1`).
- **CI trigger:** GitHub **Release published** (tag `vX.Y.Z`); also `workflow_dispatch` with optional version. Syncs `package.json` version from tag, uploads artifact + attaches to Release.
- **Runtime without Bun:** main uses `src/run-helper-node.ts` (spawn helper + pkexec). Dev still has `bun run helper` → `scripts/run-helper.ts`.
- **Paths:** `src/paths.ts` — packaged root = `process.resourcesPath/mylinux`; layout packs `carcara/`, `locales/`, `dotfiles/`, `assets/`, `carcara-electron/helper/`.
- **Helper:** `CARCARA_REPO_ROOT` set by main; honor in `helper/carcara-helper.sh`. pkexec path passes env via `pkexec env KEY=…`.
- **Postinst:** `build/deb/after-install.sh` renames `/opt/Carcara/carcara` → `carcara.bin`, writes `/usr/bin/carcara` wrapper with **pkexec** + `--no-sandbox` (1.x root parity).
- **FPM trap:** electron-builder expands `${LetterOnly}` in maintainer scripts as macros — never use `${REAL}`, `${Name}`, etc. Prefer `$VAR`, underscore names, or quoted heredocs + `sed` placeholders (`__CARCARA_BIN__`).
- **Package name:** `extraMetadata.name: carcara` (workspace npm name stays `carcara-electron`). Artifact: `carcara_${version}_${arch}.deb`.
- **AppImage:** optional later — not required for v2.0.1.
- Do **not** live-install the `.deb` / run pkexec smoke unless the owner asks.

### Version in UI strings — done

- Single source: `carcara-electron/package.json` `"version"` (currently `2.0.1`).
- Rail pill: `lib/version.ts` → `APP_VERSION` (bundled).
- Locales use placeholder **`{version}`**: `window.title`, `ready.log` (pt/en).
- Interpolate: `t(key, { version: APP_VERSION })` · `nativeT(key, { version: app.getVersion() })`.
- Never hardcode `2.0` / `2.0.1` in locale copy again.

### i18n (1.x + 2.0) — done

- Nested `locales/{pt,en}.json` → flatten → dotted keys.
- Bash `i18n.sh` (python3) · renderer `flatten-locale.ts` · main `native-i18n.ts`.
- `CARCARA_LANG` default; rail PT\|EN → `localStorage` `carcara.lang` + remount.
- Sobre: `sobre.fact.*.label` / `.value`. Product names / `cogumm.net` not translated.

### Software UX — done

- Snap Store **19 categories**; empty = `cat.empty`.
- Pagination **6/page** (`createPagedTiles` + `createPager`); click via event delegation.
- Realistic `desc.*` i18n.

### Sistema / Dotfiles / engine — done (earlier same day)

- License gate 2.0 = 1.x `license` file.
- Dotfiles rail + helper `dotfiles-*` as `$SUDO_USER`; `apply.sh` never root.
- `sync-time` → hardened `sync_time.sh` (timedatectl → ntpdate; NI).
- Zod env + `z.prettifyError`; tile hover-only teal; `carcara_confirm` auto-yes when root/NI.
- `dependences.sh` hardened; Docker CE → `docker.io`; root + Bun PATH under sudo; WSL openExternal + GPU flags.

### Waves A–C catalog — done

- Thin installers + helper + 2.0 tiles + locales (pt/en parity).
- Zen AppImage (GitHub); Cursor deb; Node toolchain (NodeSource + Bun zip).
- 1.x folders include `security/` + `presets/`.
- Wave C UX: Software category search; tile backend badges; Sobre `host:info`.
- Docker Desktop skipped (Engine enough).

### Catalog planning — v2.0.1 (open)

- Tracker: smoke + optional AppImage only (`TODO.md`).
- `listSoftwares.md` = Snap Store pointer.
- Policy: **apt → Flatpak → Snap** (+ deb/AppImage/zip helpers).

### `old/` reuse (settled)

- Ported: Docker only. Idea-only vs do-not-port: see `references/legacy.md`.

## Validated

- Sistema as root: update / fix / clean → exit 0.
- `bun run typecheck` + `bun run build` + `bun run pack:deb` OK.
- Deb contains `resources/mylinux/{carcara,locales,dotfiles,helper}` + postinst wrapper.

## Still open

1. Smoke-test Software installers / presets (owner-requested apt/flatpak/snap).
2. Smoke-test **pkexec** on real desktop / WSLg (unelevated → elevates).
3. Optional Electron AppImage.

## Blockers / notes

- Already-root → helper skips `pkexec` (expected).
- WSL often lacks pkexec → privileged actions fail apt locks; use real desktop for elevation tests.
- Bash i18n flatten needs **python3**.
- `electron-builder.yml` ≠ GHA workflow — do not move into `.github/workflows/`.
