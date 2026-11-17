# Idea — Carcará 2.0 (Electron)

Status: **v2.0.1 shipped** — ready for **v2.0.2** (see `memory-bank/TODO.md`)  
Saved: 16 de Novembro de 2026  
Updated: 17 de Novembro de 2026 (2.0.1 closed: catalog, packaging, smoke)  
Related: [mylinux.md](mylinux.md) · [carcara-modern-install.md](carcara-modern-install.md) (1.x engine — complete)

## Intent

Ship **Carcará 2.0** as a desktop app with a modern UI using **Electron**.  
**Carcará 1.x** (`carcara/` Bash + Zenity/Yad) stays as CLI/fallback and owns the install engine (`install_backends.sh` + thin installers).

## Locked decisions (17 de Novembro de 2026)

| Question | Decision |
|----------|----------|
| Repo layout | Sibling app: **`carcara-electron/`** (do not nest under Bash `carcara/`) |
| Toolchain | **[Bun](https://bun.sh/docs)** — install, scripts, and Shell (`$`) bridge ([runtime/shell](https://bun.sh/docs/runtime/shell)) |
| UI kit | **Vanilla** HTML/CSS + TypeScript renderer (no React for first ship) |
| UI/UX | Skill **`ui-ux-pro-max`** → `design-system/carcara-2-0/` (Flat Design, light utility shell) |
| Privilege | UI as **desktop user**; helper allowlist + **pkexec** for apt/install/fix/clean (`CARCARA_REQUIRE_ROOT=1` legacy only) |
| Packaging | `.deb` + AppImage via `electron-builder` + GHA on Release |
| Engine | **Reuse** `carcara/app/config/install_backends.sh` and existing system/app scripts — never reimplement apt/flatpak/snap in the renderer |

## Why Electron + Bun

- Web UI without inventing a new desktop toolkit.
- Better layout, theming, accessibility, and progress UX than Yad.
- Same install backends via privileged helper; UI is never the source of truth for package safety.
- Bun owns **dev/build** (`bun install`, `scripts/build.ts`, optional `scripts/run-helper.ts`). Packaged Electron uses Node `run-helper-node.ts` → Bash helper — **no Bun on installed systems**. `.deb` via electron-builder + GHA Release.

## Product sketch

| Area | 2.0 behavior |
|------|----------------|
| Shell | Electron main + preload + renderer; Yad/Zenity not required for primary UX |
| Actions | Update / repair / clean / install curated apps (same categories as 1.x) |
| Install engine | Invoke 1.x scripts/backends through `helper/carcara-helper.sh` |
| Privilege | Explicit elevation per dangerous action; stream logs into the UI |
| Dotfiles | Rail view → helper `dotfiles-*` → `dotfiles/apply.sh` as `$SUDO_USER` |
| WSL | Detect limited GUI/polkit; show CLI fallback hints |

## Stack

- **Bun** ≥ 1.1 (package manager + script runner + Shell)
- Electron (current stable) + TypeScript (main/preload compiled with `tsc` for Electron’s Node)
- Vanilla renderer (PT labels, same verbs as 1.x); version from `package.json` (`{version}` in locales)
- Scripts: `bun run dev` / `build` / `start` / `helper` / `pack:deb` / `pack:appimage` / `pack:linux`
- Helper: Bash allowlist + Node `run-helper-node.ts` (runtime) + Bun `run-helper.ts` (dev)
- Packaging: `electron-builder.yml` + `build/deb/after-install.sh` + `.github/workflows/release-deb.yml`

## Repo layout

```
assets/img/                   # logo.png (1.x docs + 2.0 UI)
carcara-electron/
  package.json                # packageManager: bun
  bun.lock
  tsconfig.json
  helper/carcara-helper.sh    # pkexec-facing allowlist
  electron-builder.yml        # .deb config (not under .github/workflows/)
  build/deb/after-install.sh  # pkexec /usr/bin/carcara wrapper
  scripts/
    build.ts                  # Bun.$ → tsc + copy static + assets/img/logo.png
    run-helper.ts             # Bun.$ → pkexec|helper (dev)
  src/
    main.ts                   # BrowserWindow + IPC → run-helper-node
    paths.ts / run-helper-node.ts
    preload.ts
    renderer/
      index.html              # #app mount + CSP
      styles.css
      main.ts                 # entry → Bun bundle → dist/renderer/renderer.js
      app.ts                  # shell + routing
      views/                  # one file per menu
        sistema.ts
        software.ts
        sobre.ts
        index.ts
      components/             # reusable UI factories
        tile.ts / tile-grid.ts / group.ts / rail.ts / …
      lib/                    # types + helper API
  README.md
design-system/carcara-2-0/    # ui-ux-pro-max MASTER + page overrides
  MASTER.md
  pages/app-shell.md
```

## App UI layout (`ui-ux-pro-max`)

Canonical tokens and rules: [`design-system/carcara-2-0/MASTER.md`](../../design-system/carcara-2-0/MASTER.md).  
Shell overrides: [`design-system/carcara-2-0/pages/app-shell.md`](../../design-system/carcara-2-0/pages/app-shell.md).

| Decision | Choice |
|----------|--------|
| Skill | `.agents/skills/ui-ux-pro-max` (search + `--design-system --persist`) |
| Style | **Flat Design** — light utility shell, teal primary `#0F766E`, accent CTA `#C2410C`; console Dracula dark |
| Structure | Sidebar nav + primary pane + activity log (desktop tool, not landing “Product Demo”) |
| Type | Inter / system-ui (no remote font CDN under Electron CSP) |
| A11y | Focus rings, keyboard nav, reduced-motion, no emoji-as-icons |

Any new 2.0 screen: read page override under `pages/` first, else MASTER. Re-run the skill search when changing visual direction — do not invent a parallel palette.

## Privilege helper contract

- Renderer → preload IPC → Electron main → `bun scripts/run-helper.ts <action>` → Bun `$` → `pkexec` (or direct) `helper/carcara-helper.sh`.
- Helper allowlist: system (`ping`, `apt-dry-run`, `update-distro`, `fix-system`, `clean-distro`) + installs (`install-vlc|discord|spotify|telegram|git|vscode|insomnia|firacode|docker|dropbox`) + `dotfiles-*`.
- System/install actions run 1.x scripts under `CARCARA_NONINTERACTIVE=1` (no Yad; `carcara_confirm` auto-yes when root/NI).
- UI confirms before mutating actions; streams helper stdout/stderr into Atividade.
- Unknown actions → exit 2. No arbitrary shell from the UI.

## Relationship to 1.x

```mermaid
flowchart LR
  bash1x[Carcara_1x_Bash_Yad] --> backends[Shared_install_backends]
  electron2x[Carcara_2x_Electron] --> helper[carcara_helper_allowlist]
  helper --> backends
  backends --> aptChan[apt_keyrings]
  backends --> flatpakChan[Flatpak_Flathub]
  backends --> snapChan[Snap]
```

- Do not delete 1.x when 2.0 ships — keep `cd carcara && sudo bash startApp.sh`.
- Dual entry: repo-root **`./start.sh`** (interactive or `--electron` / `--terminal`).

## Non-goals

- Not a cloud SaaS / multi-tenant product.
- Not a full distro installer / ISO builder.
- Not silent remote `curl | bash` as the default install path for the app itself.
- Not replacing `dotfiles/` with cloud sync in v2.0.0.
- Not porting Yad polish or a third Bash “polish wave”.

## Implementation checklist

- [x] Write detailed 2.0 plan (stack, folder layout, privilege helper)
- [x] Spike scaffold: `carcara-electron/` + Bun bridge (`bun run build` / `bun scripts/run-helper.ts ping` OK)
- [x] UI direction via `ui-ux-pro-max` → `design-system/carcara-2-0/` + app-shell renderer
- [x] Full UI rebuild from scratch (Flat tokens, rail + tiles + dialog confirm, brand `logo_moderno_final`) — 17 de Novembro de 2026
- [x] Renderer modular: `views/{sistema,software,sobre}.ts` + reusable `components/` (Bun IIFE bundle) — 17 de Novembro de 2026
- [x] Port system actions (update / fix / clean) through helper → 1.x scripts (17 de Novembro de 2026)
- [x] Port software categories / installers through helper (17 de Novembro de 2026)
- [x] Terminal theme (Dracula + JetBrains Mono + line highlight); brand rail polish; Software category rail (17 de Novembro de 2026)
- [x] Sobre from README + WSL-safe `openExternal`; `ping` unprivileged (no pkexec noise) (17 de Novembro de 2026)
- [x] Session knowledge consolidated in playbook + memory-bank (17 de Novembro de 2026)
- [x] Root gate for 2.0 UI + live Sistema smoke-test (update/fix/clean exit 0) (17 de Novembro de 2026)
- [x] Env: `.env.example` + Zod/`dotenv` (`src/env.ts`) wired to main + helper (17 de Novembro de 2026)
- [x] Dotfiles rail + helper `dotfiles-*` → `apply.sh` as `$SUDO_USER` (17 de Novembro de 2026)
- [x] License gate (1.x parity: checkbox Continuar before shell) (17 de Novembro de 2026)
- [x] Package `.deb` (`electron-builder.yml` + `bun run pack:deb` + Release workflow) (17 de Novembro de 2026)
- [x] AppImage target (`pack:appimage` / CI `pack:linux`) — 17 de Novembro de 2026
- [x] Software / pkexec smoke harness (`bun run smoke:software`; wiring + ping + probe) — 17 de Novembro de 2026
- [x] Live baseline `--live-core` on owner machine (sudo + `PATH=$PATH`) — 17 de Novembro de 2026
- [x] Broader `--live-extended` + passwordless `smoke:elevated` (sudoers; WSL-friendly) — 17 de Novembro de 2026
- [x] Document dual entry in root README + `carcara-electron/README.md` (alpha)
