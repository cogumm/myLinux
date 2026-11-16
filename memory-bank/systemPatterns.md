# System patterns — myLinux

Last updated: 2026-11-16

## Architecture

```
startApp.sh
  └─ config.sh (paths, Yad, head, isRoot)
  └─ dependences.sh
  └─ menuGeral.sh
       ├─ system/*.sh
       └─ menuSof.sh → category _menu.sh → per-app installers
```

Dotfiles are a separate, user-space tree (no coupling to Yad).

## Patterns to keep

1. **Central config** — shared Yad flags and directory variables in `config.sh`.
2. **One script per app** — easy to enable from menus.
3. **Category menus** — Social / Utilities / Development / Productivity.
4. **Disclaimer + root gate** — `head` + `isRoot` at config load for privileged tools.
5. **Archive, don’t delete history** — `old/` stays for reference.

## Patterns to fix when touching code

1. Broken dependency detection in `dependences.sh`.
2. Inconsistent source path (`app/config.sh` vs `app/config/config.sh`).
3. `which -a` misuse; prefer `command -v`.
4. Piping apt into Yad pulsate hides exit codes — capture `PIPESTATUS`.
5. README entrypoint drift (`init.sh` missing).

## File creation rules

- Prefer edit-in-place.
- New installer → matching category folder + menu entry.
- New agent docs → playbook `references/` or `docs/`.

## Safety pattern

Destructive operations: announce → optional confirm → run → report status. Cleaning home trash uses `$SUDO_USER` when invoked via sudo.
