# TODO — myLinux inbox

Last updated: 2026-11-17

Unscheduled ideas (promote into active work deliberately):

## Planned ideas (do not start until explicitly requested)

- [x] Wave 1 Steps 1–5 — engine complete (17 de Novembro de 2026)
- [x] Wave 2 — thin installers on backends (17 de Novembro de 2026)
- [ ] Optional Wave 3 CLI only / **skip** if 2.0 starts ([`.agents/idea/carcara-modern-install.md`](../.agents/idea/carcara-modern-install.md))
- [ ] Future: [`.agents/idea/carcara-2.0-electron.md`](../.agents/idea/carcara-2.0-electron.md) — Electron (**2.0**)

## Carcará / scripts

- [x] Repair `carcara/app/config/dependences.sh` detection logic (Wave 1 Step 1)
- [x] Unify all `. app/config/config.sh` includes (Wave 1 Step 1)
- [x] Restore `startApp.sh` Zenity license gate (Wave 1 Step 1)
- [x] Wire `menuSof.sh` Desenvolvimento → `development/_menu.sh`
- [x] Wire Produção → `productivity/_menu.sh` (Dropbox)
- [x] README: document Carcará as real entry (no fake `init.sh` / curl pipe)
- [x] Wave 1 Step 5 — `bash -n` + ShellCheck on Wave 1 scripts
- [x] Wave 2 — rewrite installers onto `install_backends.sh` + Social/Utilities Voltar
- [ ] Optional: thin root `init.sh` wrapper that delegates to `carcara/startApp.sh` (only if wanted)
- [ ] Dotfiles apply helper with `*.bak` backups
- [ ] Replace dead patterns from `old/` only when needed (docker helper refresh?)
- [ ] Consider non-root mode for dry-run / help
- [ ] i18n optional (en) for menus — low priority
- [ ] Live smoke-test of Wave 2 installers (owner-requested machine)

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
