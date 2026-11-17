# Code organization

```
start.sh                      # choose Electron 2.0 or terminal 1.x
assets/img/                   # shared brand images
carcara/                      # 1.x engine + TUI
  startApp.sh
  app/config/                 # config, backends, deps, menus
  app/scripts/system|software/
carcara-electron/             # 2.0 Electron UI (sibling — do not nest under carcara/)
  src/renderer/views/         # one file per menu
  src/renderer/components/    # reusable factories
  helper/ + scripts/          # allowlist + Bun bridge
dotfiles/                     # apply.sh + aliases/git/Hyper (user-space)
old/                          # frozen legacy
design-system/carcara-2-0/    # Flat Design tokens (ui-ux-pro-max)
cleanup-zone-identifiers.sh
```

- One installer script per app (1.x); 2.0 views call helper actions only.
- Category menus: `_menu.sh` / `menuSof.sh` (1.x); Software `nav-list` (2.0).
- Always `. app/config/config.sh` from scripts with cwd `carcara/`.
- **Header banner required** on every Carcará `.sh`: see `.agents/idea/carcara-modern-install.md` → “Script header convention”.
- Dotfiles: `references/dotfiles.md`. 2.0: `references/carcara-2.0.md`. Session dump: `memory-bank/activeContext.md`.
