# Active context — myLinux

Last updated: 2026-11-16

## Current focus

Agent scaffolding (AGENTS, memory-bank, `.cursor`, docs, design-system) describes the **myLinux** Linux toolkit. Code under `carcara/`, `dotfiles/`, `old/` is the source of truth.

## Recent decisions

- Product is Bash/Zenity/Yad + dotfiles.
- Agent-agnostic docs: `.agents/idea/`, `.agents/playbook/`.
- Cursor adapter: `.cursor/rules/`; Claude adapter: `.claude/rules/` (mirrored policies).
- Design system: `design-system/carcara/` (TUI).
- `old/` remains archive; modernization happens in `carcara/`.
- Installed optional skill: `shellcheck-configuration` (skills.sh / `wshobson/agents`). Future skills listed in `TODO.md` for gradual modernization.

## Next useful engineering work

1. Fix `dependences.sh` and wire Development menu to existing installers.
2. Idempotent refresh of vscode/git/firacode/social installers.
3. Safe dotfiles apply script with backups.
4. Run ShellCheck on `carcara/**/*.sh` using the installed skill when touching scripts.
5. Optional: root `init.sh` wrapper → Carcará (only if wanted).

## Blockers

None for documentation. Live apt testing needs explicit owner request.
