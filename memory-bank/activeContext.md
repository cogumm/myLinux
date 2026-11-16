# Active context — myLinux

Last updated: 2026-11-16

## Current focus

Carcará **1.x** modernization per `.agents/idea/carcara-modern-install.md`. **Wave 1 Step 1 done**. Next: Wave 1 Step 2 (`install_backends.sh`).  
**2.0 vision** (Electron) documented in `.agents/idea/carcara-2.0-electron.md` — do not start until requested; prefer stable 1.x backends first.

## Recent decisions

- Product is Bash/Zenity/Yad + dotfiles.
- Agent-agnostic docs: `.agents/idea/`, `.agents/playbook/`.
- Cursor adapter: `.cursor/rules/`; Claude adapter: `.claude/rules/` (mirrored policies).
- Install backend policy: apt keyrings → Flatpak/Flathub → Snap fallback.
- Script header banner required on all Carcará `.sh` files.
- Installed optional skill: `shellcheck-configuration`.

## Next useful engineering work

1. Wave 1 Step 2 — `carcara/app/config/install_backends.sh`.
2. Wave 1 Steps 3–4 — system scripts + menu wiring.
3. Wave 1 Step 5 — ShellCheck pass on touched tree.
4. Wave 2 — rewrite app installers by category.

## Blockers

None for documentation. Live apt testing needs explicit owner request.
