# TODO — myLinux inbox

Last updated: 2026-11-16

Unscheduled ideas (promote into active work deliberately):

## Planned ideas (do not start until explicitly requested)

- [ ] Continue [`.agents/idea/carcara-modern-install.md`](../.agents/idea/carcara-modern-install.md) — **1.x engine**: Step 3 system → Step 4 menus → lean Wave 2; **skip Yad polish / Wave 3 UI**
- [x] Wave 1 Step 2 — `install_backends.sh` (17 de Novembro de 2026)
- [ ] Future: [`.agents/idea/carcara-2.0-electron.md`](../.agents/idea/carcara-2.0-electron.md) — Electron (**2.0**) after 1.x backends are stable

## Carcará / scripts

- [x] Repair `carcara/app/config/dependences.sh` detection logic (Wave 1 Step 1)
- [x] Unify all `. app/config/config.sh` includes (Wave 1 Step 1)
- [x] Restore `startApp.sh` Zenity license gate (Wave 1 Step 1)
- [ ] Wire `menuSof.sh` Desenvolvimento → `development/*.sh`
- [ ] Wire Produção → `productivity/dropbox.sh` (or drop stub)
- [x] README: document Carcará as real entry (no fake `init.sh` / curl pipe)
- [ ] Optional: thin root `init.sh` wrapper that delegates to `carcara/startApp.sh` (only if wanted)
- [ ] `bash -n` / ShellCheck pass on `carcara/**/*.sh` (use installed skill `shellcheck-configuration`)
- [ ] Dotfiles apply helper with `*.bak` backups
- [ ] Replace dead patterns from `old/` only when needed (docker helper refresh?)
- [ ] Consider non-root mode for dry-run / help
- [ ] i18n optional (en) for menus — low priority

## Future agent skills (skills.sh) — install when modernizing that area

Incremental modernization; do **not** install everything at once. Playbook stays canonical: `.agents/playbook/`.

| Priority | Skill | Install | When it helps |
|----------|--------|---------|----------------|
| Done | `shellcheck-configuration` (`wshobson/agents`) | installed → `.agents/skills/shellcheck-configuration` | Lint/harden Carcará Bash during script rewrites |
| Next | `bash-scripting` (`sickn33/agentic-awesome-skills`) | `npx skills add sickn33/agentic-awesome-skills@bash-scripting` | Defensive scripting patterns when rewriting installers / menus |
| Later | `debian-linux-triage` (`github/awesome-copilot`) | `npx skills add github/awesome-copilot@debian-linux-triage` | Safer apt/dpkg/systemd flows in `updateDistro` / `fixSystem` / `cleanDistro` |

Links:

- https://skills.sh/wshobson/agents/shellcheck-configuration
- https://skills.sh/sickn33/agentic-awesome-skills/bash-scripting
- https://skills.sh/github/awesome-copilot/debian-linux-triage
