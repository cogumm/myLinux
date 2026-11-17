# Tech context — myLinux

Last updated: 2026-11-17

## Runtime

| Layer | Choice |
|-------|--------|
| Shell (1.x) | Bash |
| UI 1.x | Zenity lists, Yad progress/dialogs |
| UI 2.0 | Electron + TypeScript vanilla renderer (Bun toolchain) |
| Env (2.0) | `dotenv` + **Zod 4** (`src/env.ts`) |
| Packages | apt-get, dpkg, Flatpak/Flathub, snap |
| VCS | Git |
| Host | Linux apt-family; WSL2 supported for helpers + Electron with caveats |

## Key paths

### 1.x

- `carcara/startApp.sh` — deps → **license** → `menuGeral.sh`
- `carcara/app/config/{config,dependences,menuGeral,testConnection,license,install_backends}.sh`
- `carcara/app/scripts/system/{updateDistro,fixSystem,cleanDistro,applyDotfiles}.sh`
- `carcara/app/scripts/software/**`

### 2.0

- `carcara-electron/` — Electron app
- `carcara-electron/.env.example` / `.env` — Zod-validated
- `carcara-electron/src/env.ts`
- `carcara-electron/scripts/{build,run-helper}.ts`
- `carcara-electron/helper/carcara-helper.sh`
- `carcara-electron/src/{main,preload,open-external,app-menu}.ts`
- `carcara-electron/src/renderer/{main,app,views,components,lib}/`
- `carcara-electron/src/renderer/components/license-gate.ts`
- `design-system/carcara-2-0/`
- `assets/img/` — shared brand images
- `carcara-electron/assets/fonts/JetBrainsMono-Regular.woff2`

### Dotfiles / shared

- `dotfiles/apply.sh` — non-root apply with `*.bak`
- `docs/dotfiles.md`
- `start.sh` — dual entry (+ Bun PATH + WSL GPU)
- `old/**` (archive)
- `cleanup-zone-identifiers.sh`

## Commands agents use for validation

```bash
# 1.x
bash -n carcara/app/config/config.sh
bash -n carcara/app/scripts/system/applyDotfiles.sh
shellcheck -x carcara/startApp.sh   # if available

# Dotfiles
dotfiles/apply.sh --dry-run --all

# 2.0
cd carcara-electron
bun run typecheck
bun run build
bun run helper -- ping
bun run helper -- dotfiles-dry-run
```

Do **not** run live `sudo`, apt mutations, or `pkexec` flows unless the owner asks.

## Constraints

- 2.0 UI is vanilla (no React) for first ship
- Renderer must not own package safety — helper allowlist only
- No remote font CDN under Electron CSP (`font-src 'self'`)
- Dotfiles apply never as root
- Funding: `.github/FUNDING.yml` → ko_fi cogumm
