# Code organization

```
carcara/
  startApp.sh                 # license gate → main menu
  app/config/                 # config, deps, menus, license
  app/scripts/system/         # update, clean, fix, sync_time
  app/scripts/software/       # menus + installers by category
dotfiles/                     # aliases, Bash, oh-my-zsh, git, Hyper
old/                          # frozen legacy
cleanup-zone-identifiers.sh
```

- One installer script per app.
- Category menus: `_menu.sh` or `menuSof.sh`.
- Always `. app/config/config.sh` from scripts running with cwd `carcara/` (document if a script needs another cwd).
