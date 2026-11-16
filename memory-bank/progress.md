# Progress — myLinux

Append-only log. Do not delete completed history.

## Completed — agent re-home to myLinux (2026-11-16)

- [x] Analyzed legacy trees: `.github`, `carcara/**`, `dotfiles/**`, `old/**`, `carcara/README.md`
- [x] Rewrote `AGENTS.md` / `CLAUDE.md` / `skills-lock.json` for the Linux toolkit
- [x] Adapted `.cursor/rules/*` as Cursor adapter
- [x] Rewrote `memory-bank/*` for myLinux
- [x] Adapted `design-system/carcara/` and `docs/` for Carcará/dotfiles
- [x] Agent docs describe only myLinux (Carcará, dotfiles, helpers)
- [x] Moved idea + playbook to agent-agnostic `.agents/` (`.agents/idea/`, `.agents/playbook/`); `.cursor/skills` / `.cursor/Idea` retired as canonical homes
- [x] Installed `shellcheck-configuration` from skills.sh into `.agents/skills/`; locked in `skills-lock.json`
- [x] Documented future skills (`bash-scripting`, `debian-linux-triage`) in `TODO.md` for gradual modernization
- [x] Mirrored `.cursor/rules/*.mdc` → `.claude/rules/*.md` for Claude Code
- [x] Updated root `README.md` (Carcará entry, layout, docs links; removed missing `init.sh` / curl install)
