# Optional skills

Canonical project playbook: `../playbook/SKILL.md`  
Lockfile: `../../skills-lock.json`

Install with `npx skills add <source>@<skill>` from the repo root. Reinstall overwrites the skill tree — keep **repo policy** here and in `AGENTS.md`, not inside vendored `SKILL.md` files.

## Installed

| Skill | Source | Use |
|-------|--------|-----|
| `shellcheck-configuration/` | `wshobson/agents` | ShellCheck setup + lint guidance for Carcará scripts |
| `ui-ux-pro-max/` | `nextlevelbuilder/ui-ux-pro-max-skill` | Carcará 2.0 Flat Design / design-system |
| `bash-scripting/` | `sickn33/agentic-awesome-skills` | Defensive Bash checklist when rewriting installers / menus |
| `debian-linux-triage/` | `github/awesome-copilot` | apt / dpkg / systemd triage for system scripts |

## myLinux constraints (always)

- Playbook + `.cursor/rules` / `AGENTS.md` win over skill prompts.
- Never run live `sudo`, apt, purge, or pkexec unless the owner asks in that message.
- Prefer editing existing scripts under `carcara/` / `dotfiles/`; quote expansions; `command -v`; no `curl | bash` in new code.
- `bash-scripting` may reference sibling skills (`bash-pro`, etc.) that are **not** installed — treat it as a defensive workflow index; pair with `shellcheck-configuration` + playbook `shell-safety`.
- `debian-linux-triage` is for **diagnosis plans and safer script design**, not unsolicited remediation on the host. Prefer apt-family (`/etc/os-release`); align with `updateDistro` / `fixSystem` / `cleanDistro` patterns.
