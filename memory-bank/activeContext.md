# Active context — myLinux

Last updated: 2026-11-17

## Current focus

**Carcará 2.0 usable alpha** (`carcara-electron/`, package **`2.0.1`**).  
**1.x** (`carcara/`) = install/maintenance **engine** + CLI/fallback.  
**Packaging shipped:** `.deb` via `electron-builder` + GHA Release workflow.  
**v2.0.1 Wave A shipped:** 11 catalog apps (Firefox…OBS) + `install_deb_url`.  
**Next:** owner smoke (Software / pkexec) + **Wave B→C** — `memory-bank/TODO.md`.

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

### Wave A catalog — done

- Thin installers + 1.x menus + helper + 2.0 tiles + locales (pt/en parity).
- `install_deb_url` in `install_backends.sh` (Cursor amd64 `.deb`).
- 1.x still 4 folders (browsers/Steam/OBS under utilities until Wave B).

### Catalog planning — v2.0.1 (open)

- Tracker: `TODO.md` § **v2.0.1** waves **B / C** (Wave A complete).
- `listSoftwares.md` = Snap Store pointer only (no duplicate wishlist).
- Policy: **apt → Flatpak → Snap** (+ `install_deb_url` for vendor debs).

### `old/` reuse (settled)

- Ported: Docker only. Idea-only vs do-not-port: see `references/legacy.md`.

## Validated

- Sistema as root: update / fix / clean → exit 0.
- `bun run typecheck` + `bun run build` + `bun run pack:deb` OK.
- Deb contains `resources/mylinux/{carcara,locales,dotfiles,helper}` + postinst wrapper.

## Still open

1. Smoke-test Software installers incl. Wave A (owner-requested apt/flatpak/snap).
2. Smoke-test **pkexec** on real desktop / WSLg (unelevated → elevates).
3. **v2.0.1** Wave B→C.
4. Optional AppImage.

## Blockers / notes

- Already-root → helper skips `pkexec` (expected).
- WSL often lacks pkexec → privileged actions fail apt locks; use real desktop for elevation tests.
- Bash i18n flatten needs **python3**.
- `electron-builder.yml` ≠ GHA workflow — do not move into `.github/workflows/`.
