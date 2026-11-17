# Tech context — myLinux

Last updated: 2026-11-17

## Runtime

| Layer | Choice |
|-------|--------|
| Shell (1.x) | Bash |
| UI 1.x | Zenity lists, Yad progress/dialogs |
| UI 2.0 | Electron + TypeScript vanilla renderer (Bun toolchain) |
| Packages | apt-get, dpkg, Flatpak/Flathub, snap |
| VCS | Git |
| Host | Linux apt-family; WSL2 supported for helpers + Electron with caveats |

## Key paths

### 1.x

- `carcara/startApp.sh`
- `carcara/app/config/{config,dependences,menuGeral,testConnection,license,install_backends}.sh`
- `carcara/app/scripts/system/*`
- `carcara/app/scripts/software/**`

### 2.0

- `carcara-electron/` — Electron app
- `carcara-electron/scripts/{build,run-helper}.ts`
- `carcara-electron/helper/carcara-helper.sh`
- `carcara-electron/src/{main,preload,open-external}.ts`
- `carcara-electron/src/renderer/{app,main,views,components,lib}/`
- `design-system/carcara-2-0/`
- `assets/img/` — shared brand images
- `carcara-electron/assets/fonts/JetBrainsMono-Regular.woff2`

### Shared / other

- `start.sh` — dual entry
- `dotfiles/**`
- `old/**` (archive)
- `cleanup-zone-identifiers.sh`

## Commands agents use for validation

```bash
# 1.x
bash -n carcara/app/config/config.sh
shellcheck -x carcara/startApp.sh   # if available

# 2.0
cd carcara-electron
bun run typecheck    # tsc main + tsc -p tsconfig.renderer.json
bun run build
bun run helper -- ping
```

Do **not** run live `sudo`, apt mutations, or `pkexec` flows unless the owner asks.

## Constraints

- 2.0 UI is vanilla (no React) for first ship
- Renderer must not own package safety — helper allowlist only
- No remote font CDN under Electron CSP (`font-src 'self'`)
- Funding: `.github/FUNDING.yml` → ko_fi cogumm
