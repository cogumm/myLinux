# System patterns — myLinux

Last updated: 2026-11-17

## Architecture (1.x)

```
startApp.sh
  └─ config.sh (paths, Yad, head, isRoot, install_backends)
  └─ dependences.sh
  └─ menuGeral.sh
       ├─ system/*.sh
       └─ menuSof.sh → category _menu.sh → per-app installers
```

## Architecture (2.0)

```
./start.sh --electron
  └─ carcara-electron (Electron)
       ├─ main.ts → IPC helper:run | shell:openExternal
       ├─ renderer (views + components) → preload
       └─ bun scripts/run-helper.ts → carcara-helper.sh → 1.x scripts
```

Dotfiles remain a separate, user-space tree.

## Patterns to keep

1. **Central config (1.x)** — Yad flags and dirs in `config.sh`.
2. **One script per app** — thin installers on `install_backends.sh`.
3. **Category menus** — Social / Utilities / Development / Productivity (same in 2.0 Software view).
4. **Disclaimer + root gate** — 1.x `head`/`isRoot`; 2.0 confirm dialog + pkexec when available.
5. **Archive, don’t delete history** — `old/` stays for reference.
6. **2.0 component factories** — `createTile` / `createRail` / `createNavList` / `createActivityConsole`; one view file per menu.
7. **Shared brand assets** — only `assets/img/`; build copies into Electron `dist/`.
8. **WSL-aware externals** — PowerShell `Start-Process` before Linux `xdg-open`.

## Patterns to fix when touching code

1. Prefer `command -v` over brittle `which` chains.
2. Yad pulsate must not hide apt exit codes (`PIPESTATUS` / noninteractive path).
3. Do not nest Electron under Bash `carcara/`.
4. Do not warn about missing `pkexec` on unprivileged actions (`ping`).
5. Do not invent a second design palette — use `design-system/carcara-2-0/`.

## File creation rules

- Prefer edit-in-place under `carcara/` and `carcara-electron/src/renderer/`.
- New 2.0 screen → `views/<name>.ts` + optional `design-system/carcara-2-0/pages/<name>.md`.
- New reusable UI → `components/` factory (not duplicated markup in views).
- New agent docs → playbook `references/` or `docs/`.

## Safety pattern

Destructive operations: UI/menu confirm (2.0 dialog / 1.x choosing the item) → run → report status (terminal log is source of truth).  
`carcara_confirm`: when already **root** or `CARCARA_NONINTERACTIVE=1`, auto-yes (`-y`) — no terminal `[y/N]` (Carcará always elevates via `isRoot`).  
Cleaning home trash uses `$SUDO_USER` when elevated.
