# Tech context — myLinux

Last updated: 2026-11-17

## Runtime

| Layer | Choice |
|-------|--------|
| Shell (1.x) | Bash (+ python3 for nested locale flatten) |
| UI 1.x | Zenity lists, Yad progress/dialogs |
| UI 2.0 | Electron + TypeScript vanilla renderer (Bun toolchain) |
| Env (2.0) | `dotenv` + **Zod 4** (`src/env.ts`) |
| i18n | Nested `locales/{pt,en}.json` → flattened dotted keys; `{version}` interpolate |
| Packaging | **electron-builder** → `.deb`; GHA `release-deb.yml` on Release |
| Runtime (.deb) | Node `run-helper-node` + Bash helper — **no Bun** |
| Packages | apt-get, dpkg, Flatpak/Flathub, snap |
| VCS | Git — default branch **`main`** |
| Host | Linux apt-family; WSL2 supported for helpers + Electron with caveats |

## Key paths

### 1.x

- `carcara/startApp.sh` — deps → **license** → `menuGeral.sh`
- `carcara/app/config/{config,dependences,menuGeral,testConnection,license,install_backends,i18n}.sh` — backends incl. `install_deb_url`
- `carcara/app/scripts/system/{updateDistro,fixSystem,cleanDistro,applyDotfiles,sync_time}.sh`
- `carcara/app/scripts/software/**`

### 2.0

- `carcara-electron/` — Electron app (`package.json` `"version"` → pill, title, ready log, `.deb`)
- `carcara-electron/.env.example` / `.env` — Zod-validated (`CARCARA_LANG`, window, ping, root)
- `carcara-electron/src/env.ts`
- `carcara-electron/src/native-i18n.ts` — main-process `nativeT(key, vars?)`
- `carcara-electron/scripts/{build,run-helper}.ts` — Bun build + **dev** helper bridge
- `carcara-electron/src/paths.ts` — repo root (dev) vs `resources/mylinux` (packaged)
- `carcara-electron/src/run-helper-node.ts` — packaged/runtime helper (pkexec + env)
- `carcara-electron/electron-builder.yml` — stays under `carcara-electron/` (not `.github/`)
- `carcara-electron/build/deb/after-install.sh` — `/usr/bin/carcara` pkexec wrapper
- `.github/workflows/release-deb.yml` — Release published → attach `carcara_*_amd64.deb`
- `carcara-electron/helper/carcara-helper.sh` — allowlist; honors `CARCARA_REPO_ROOT`
- `carcara-electron/src/{main,preload,open-external,app-menu}.ts`
- `carcara-electron/src/renderer/{main,app,views,components,lib}/`
- `carcara-electron/src/renderer/lib/{i18n,flatten-locale,version}.ts`
- `carcara-electron/src/renderer/components/{paged-tiles,pager,lang-switch,license-gate}.ts`
- `design-system/carcara-2-0/`
- `assets/img/` — shared brand images
- `carcara-electron/assets/fonts/JetBrainsMono-Regular.woff2`
- `carcara-electron/release/` — local pack output (gitignored)

### Dotfiles / shared

- `dotfiles/apply.sh` — non-root apply with `*.bak`
- `docs/dotfiles.md`
- `locales/{pt,en}.json` — nested UI strings
- `start.sh` — dual entry (+ Bun PATH + WSL GPU)
- `old/**` (archive — see playbook `legacy.md`)
- `cleanup-zone-identifiers.sh`
- `memory-bank/TODO.md` — **v2.0.1** catalog waves
- `docs/releases/X.Y.Z.md` — per-version release notes (required before tag `vX.Y.Z`)

## Commands agents use for validation

```bash
# 1.x
bash -n carcara/app/config/i18n.sh
bash -n carcara/app/scripts/system/sync_time.sh
CARCARA_LANG=en bash -c 'source carcara/app/config/i18n.sh; t menu.choose'

# Dotfiles
dotfiles/apply.sh --dry-run --all

# 2.0
cd carcara-electron
bun run typecheck
bun run build
bun run helper -- ping
bun run helper -- sync-time   # privileged / owner-requested
bun run helper -- dotfiles-dry-run
bun run pack:deb              # → release/carcara_<ver>_amd64.deb (heavy; needs network)
bun run smoke:software        # Software wiring + ping + pkexec probe
```

Do **not** run live `sudo`, apt mutations, or `pkexec` flows unless the owner asks.

## Release checklist (agents)

Only when the owner asks to cut a release:

1. Ensure `carcara-electron/package.json` `"version"` = `X.Y.Z`.
2. Add `docs/releases/X.Y.Z.md` (novidades / install / limits).
3. Commit → annotated tag `vX.Y.Z` on **that** commit (HEAD after the notes land).
4. Publish GitHub Release for the tag (triggers `release-deb.yml` → attach `.deb`).

See `systemPatterns.md` pattern 16.

## Packaging notes (agents)

- `electron-builder.yml` = app packager config; `.github/workflows/*.yml` = CI only.
- afterInstall: avoid `${LetterOnly}` — FPM treats them as macros (`Macro REAL is not defined`).
- `extraMetadata.name: carcara` → Debian `Package:` field; artifact name still `carcara_${version}_amd64.deb`.
- Bump version in `carcara-electron/package.json` before tagging `vX.Y.Z` (CI can sync from tag).
- `pack:deb` / `pack:dir` use `--publish never` + `publish: null` in yml — softprops attaches the `.deb`. Tag + app cwd without `.git` must not trigger electron-builder publish.
- `package.json` must declare `"repository"` (GitHub) for electron-builder metadata even when publish is off.

## Constraints

- 2.0 UI is vanilla (no React) for first ship
- Renderer must not own package safety — helper allowlist only
- Packaged `.deb` must not require Bun on the target machine
- No remote font CDN under Electron CSP (`font-src 'self'`)
- Dotfiles apply never as root
- Nested locales require python3 on hosts that run 1.x `t`
- Funding: `.github/FUNDING.yml` → ko_fi cogumm
