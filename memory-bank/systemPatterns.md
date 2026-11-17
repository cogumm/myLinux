# System patterns — myLinux

Last updated: 2026-11-17

## Architecture (1.x)

```
startApp.sh
  └─ config.sh (paths, Yad, head, isRoot, install_backends + carcara_confirm + i18n)
  └─ dependences.sh
  └─ Zenity license gate (carcara/app/config/license)
  └─ menuGeral.sh
       ├─ system/{update,fix,clean,applyDotfiles,sync_time}.sh
       └─ menuSof.sh → category _menu.sh → per-app installers
```

## Architecture (2.0)

```
./start.sh --electron (sudo + Bun PATH + WSL GPU flags)   # OR .deb → /usr/bin/carcara (pkexec)
  └─ carcara-electron
       ├─ main.ts → requireRoot, paths, IPC
       ├─ run-helper-node.ts → helper/carcara-helper.sh (+ pkexec env when needed)
       │    (dev CLI: bun scripts/run-helper.ts — Bun.$; not required in .deb)
       ├─ renderer: license-gate → app shell (views + components)
       │    rail: Sistema | Software | Dotfiles | Sobre + PT|EN + version pill
       └─ CARCARA_REPO_ROOT → carcara/ | locales/ | dotfiles/
            ├─ privileged → 1.x scripts (CARCARA_NONINTERACTIVE=1) incl. sync-time
            └─ unprivileged → ping | dotfiles-* (as $SUDO_USER)
```

**Packaged layout:** `resources/mylinux/{carcara,locales,dotfiles,assets,carcara-electron/helper}`.

Dotfiles tree is user-space (`dotfiles/apply.sh`); Carcará menus only **invoke** it.

## Patterns to keep

1. **Central config (1.x)** — Yad flags and dirs in `config.sh`; shared API in `install_backends.sh`.
2. **One script per app** — thin installers on backends (`install_deb_url` for vendor `.deb` when needed).
3. **Category menus** — 2.0 Software follows **Snap Store** taxonomy (19 cats) + search/badges; 1.x folders: development / games / browsers / social / productivity / music / security / utilities / presets.
4. **Disclaimer + root gate** — 1.x Zenity license + `isRoot`; 2.0 license-gate + `requireRoot()` + action confirms; `.deb` launcher elevates via pkexec.
5. **Archive, don’t delete history** — `old/` stays for reference; port *ideas*, not dead scripts.
6. **2.0 component factories** — `createTile` / `createRail` / `createLicenseGate` / `createActivityConsole` / `createPagedTiles` / `createLangSwitch`; one view file per menu.
7. **Shared brand assets** — only `assets/img/`; build copies into Electron `dist/`.
8. **WSL-aware externals** — PowerShell `Start-Process` before Linux `xdg-open`.
9. **Zod env** — validate in `src/env.ts`; `z.prettifyError` for failures.
10. **Dotfiles as user** — always `$SUDO_USER` / non-root `$HOME`; never apply as root.
11. **Shared i18n** — nested `locales/{pt,en}.json` → flatten → dotted `t("…")`; optional `{version}` vars; rail PT\|EN via `localStorage`.
12. **Software pagination** — 6 tiles/page; hide pager when ≤1 page; tile clicks via event delegation.
13. **Brand version** — pill + `window.title` / `ready.log` = `package.json` `"version"` (`APP_VERSION` / `app.getVersion()`).
14. **Packaging split** — `electron-builder.yml` next to the Electron app; GHA workflow only orchestrates. Packaged app must not require Bun.
15. **Maintainer-script macros** — FPM/`electron-builder` eats `${LetterOnly}` in afterInstall; avoid brace macros with letter-only names.

## Patterns to fix when touching code

1. Prefer `command -v` over brittle `which` chains.
2. Yad pulsate must not hide apt exit codes (`PIPESTATUS` / noninteractive path).
3. Do not nest Electron under Bash `carcara/`.
4. Do not warn about missing `pkexec` on unprivileged actions (`ping`, `dotfiles-*`).
5. Do not invent a second design palette — use `design-system/carcara-2-0/`.
6. Do not use Zod 4 deprecated `ZodError.flatten()` — use `z.prettifyError` / `z.treeifyError`.
7. Tile “featured” look is **hover-only**; do not restore permanent orange tile borders.
8. Keep `locales/pt.json` and `en.json` **same nested shape**; never leave flat-only keys in one language.
9. Do not duplicate the software wishlist in `listSoftwares.md` — waves live in `TODO.md`.
10. Do not move `electron-builder.yml` into `.github/workflows/` — that folder is for Actions only.
11. Do not hardcode version strings in locales — use `{version}` + interpolate.

## File creation rules

- Prefer edit-in-place under `carcara/` and `carcara-electron/src/renderer/`.
- New 2.0 screen → `views/<name>.ts` + optional `design-system/carcara-2-0/pages/<name>.md`.
- New reusable UI → `components/` factory (not duplicated markup in views).
- New agent docs → playbook `references/` or `docs/`.
- New installer → thin script + 1.x `_menu` + helper allowlist + 2.0 tile + locale keys (both langs).
- Packaging tweaks → `electron-builder.yml` / `build/deb/` / `paths.ts` / `run-helper-node.ts`; CI → `.github/workflows/release-deb.yml`.

## Safety pattern

1. **License** once per launch (1.x Zenity / 2.0 license-gate).
2. **UI confirm** for mutating actions (2.0 `<dialog>` / 1.x choosing the menu item).
3. **`carcara_confirm`**: root or `CARCARA_NONINTERACTIVE=1` → auto-yes (`-y`); no terminal `[y/N]`.
4. Run → report status (terminal / Atividade log is source of truth).
5. Cleaning home trash uses `$SUDO_USER` when elevated.
6. Never live `sudo` / apt / pkexec / install `.deb` on the machine unless the owner asks in that message.
