# System patterns — myLinux

Last updated: 2026-11-17

## Architecture (1.x)

```
startApp.sh
  └─ config.sh (paths, Yad, head, isRoot, install_backends + carcara_confirm)
  └─ dependences.sh
  └─ Zenity license gate (carcara/app/config/license)
  └─ menuGeral.sh
       ├─ system/{update,fix,clean,applyDotfiles}.sh
       └─ menuSof.sh → category _menu.sh → per-app installers
```

## Architecture (2.0)

```
./start.sh --electron (sudo + Bun PATH + WSL GPU flags)
  └─ carcara-electron
       ├─ main.ts → requireRoot, IPC (helper / license / quit / openExternal)
       ├─ renderer: license-gate → app shell (views + components)
       └─ bun scripts/run-helper.ts → carcara-helper.sh
            ├─ privileged → 1.x scripts (CARCARA_NONINTERACTIVE=1)
            └─ unprivileged → ping | dotfiles-* (as $SUDO_USER)
```

Dotfiles tree is user-space (`dotfiles/apply.sh`); Carcará menus only **invoke** it.

## Patterns to keep

1. **Central config (1.x)** — Yad flags and dirs in `config.sh`; shared API in `install_backends.sh`.
2. **One script per app** — thin installers on backends.
3. **Category menus** — Social / Utilities / Development / Productivity (same in 2.0 Software).
4. **Disclaimer + root gate** — 1.x Zenity license + `isRoot`; 2.0 license-gate + `requireRoot()` + action confirms.
5. **Archive, don’t delete history** — `old/` stays for reference.
6. **2.0 component factories** — `createTile` / `createRail` / `createLicenseGate` / `createActivityConsole`; one view file per menu.
7. **Shared brand assets** — only `assets/img/`; build copies into Electron `dist/`.
8. **WSL-aware externals** — PowerShell `Start-Process` before Linux `xdg-open`.
9. **Zod env** — validate in `src/env.ts`; `z.prettifyError` for failures.
10. **Dotfiles as user** — always `$SUDO_USER` / non-root `$HOME`; never apply as root.

## Patterns to fix when touching code

1. Prefer `command -v` over brittle `which` chains.
2. Yad pulsate must not hide apt exit codes (`PIPESTATUS` / noninteractive path).
3. Do not nest Electron under Bash `carcara/`.
4. Do not warn about missing `pkexec` on unprivileged actions (`ping`, `dotfiles-*`).
5. Do not invent a second design palette — use `design-system/carcara-2-0/`.
6. Do not use Zod 4 deprecated `ZodError.flatten()` — use `z.prettifyError` / `z.treeifyError`.
7. Tile “featured” look is **hover-only**; do not restore permanent orange tile borders.

## File creation rules

- Prefer edit-in-place under `carcara/` and `carcara-electron/src/renderer/`.
- New 2.0 screen → `views/<name>.ts` + optional `design-system/carcara-2-0/pages/<name>.md`.
- New reusable UI → `components/` factory (not duplicated markup in views).
- New agent docs → playbook `references/` or `docs/`.

## Safety pattern

1. **License** once per launch (1.x Zenity / 2.0 license-gate).
2. **UI confirm** for mutating actions (2.0 `<dialog>` / 1.x choosing the menu item).
3. **`carcara_confirm`**: root or `CARCARA_NONINTERACTIVE=1` → auto-yes (`-y`); no terminal `[y/N]`.
4. Run → report status (terminal / Atividade log is source of truth).
5. Cleaning home trash uses `$SUDO_USER` when elevated.
