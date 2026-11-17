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
- [x] Saved Carcará modernization plan to `.agents/idea/carcara-modern-install.md` (not implemented yet)
- [x] Wave 1 Step 1: fixed `dependences.sh`, restored `startApp.sh` license gate, unified `. app/config/config.sh` sourcing (+ `vlc.sh`)
- [x] Captured Carcará 2.0 vision (Electron UI) in `.agents/idea/carcara-2.0-electron.md` — not started; 1.x Bash track continues
- [x] Refocused 1.x plan: engine/backends first; Yad polish and Wave 3 UI marked low-priority/skip toward Electron 2.0
- [x] Wave 1 Step 2: added `carcara/app/config/install_backends.sh` (apt/Flatpak/Snap API); sourced from `config.sh`
- [x] Wave 1 Step 3: modernized `updateDistro` / `fixSystem` / `cleanDistro` (exit codes, confirms, safer locks)
- [x] Wave 1 Step 4: wired Desenvolvimento + Produção menus (`development/_menu.sh`, `productivity/_menu.sh`)
- [x] Wave 1 Step 5 (2026-11-17): ShellCheck + `bash -n` on Wave 1 scripts; `.shellcheckrc`; export shared config; docs/playbook/memory-bank closed — **Wave 1 complete**
- [x] Wave 2 (2026-11-17): thin installers on backends (vlc, discord, spotify, telegram, git, vscode, insomnia, firacode, dropbox); Social/Utilities Voltar → `break`; ShellCheck clean — **Wave 2 complete**
- [x] Cancelled Wave 3 (1.x polish / init.sh / dry-run UI); removed Wave 3 sections and references (2026-11-17)
- [x] Started Carcará 2.0: locked decisions in `carcara-2.0-electron.md`; scaffolded `carcara-electron/` (Electron + TS vanilla + `carcara-helper.sh` apt dry-run spike); `npm run build` OK
- [x] Switched Carcará 2.0 toolchain to **Bun** (2026-11-17): `bun install` / `bun.lock`; `scripts/build.ts` + `scripts/run-helper.ts` via `Bun.$`; Electron main spawns Bun bridge; docs/stack updated
- [x] Installed skill `ui-ux-pro-max`; persisted `design-system/carcara-2-0/`; app-shell UI (sidebar + pane + log) applied to Electron renderer (2026-11-17)
- [x] Root `start.sh` dual entry: interactive / `--electron` / `--terminal` (2026-11-17)
- [x] Carcará 2.0 system actions: helper `update-distro` / `fix-system` / `clean-distro` → 1.x scripts + `CARCARA_NONINTERACTIVE`; Sistema UI with confirms (2026-11-17)
- [x] Carcará 2.0 software installers via helper allowlist + Software UI categories (development/productivity/social/utilities) (2026-11-17)
- [x] Images for 1.x + 2.0 live under repo `assets/img/` (no copy under `carcara/app/assets`) (2026-11-17)
- [x] Carcará 2.0 UI rebuilt from scratch with `ui-ux-pro-max` (Flat tokens, rail/tiles/dialog, brand logo_moderno_final; design-system + renderer) (2026-11-17)
- [x] Carcará 2.0 renderer modularizado: views Sistema/Software/Sobre + components reutilizáveis; Bun bundle IIFE (2026-11-17)
- [x] Terminal Atividade: Dracula colors + JetBrains Mono (vendored) + line numbers/highlight (2026-11-17)
- [x] Brand rail polish (logo hero, 2.0 pill beside name, MIT footer); Software category nav-list (2026-11-17)
- [x] Sobre: README facts + allowlisted links; WSL openExternal via PowerShell (2026-11-17)
- [x] Helper bridge: `ping` unprivileged (no pkexec warning); privileged actions keep clear WSL warning (2026-11-17)
- [x] Session knowledge consolidated: playbook `references/carcara-2.0.md` + memory-bank (active/tech/system/product/TODO) + AGENTS/idea (2026-11-17)
- [x] Carcará 2.0 exige root como 1.x: `start.sh --electron` via sudo + `requireRoot()` no Electron main (2026-11-17)
- [x] Live smoke-test Sistema (2.0 as root): update-distro / fix-system / clean-distro all exit 0; NI skips locks/lists (2026-11-17)
- [x] Menus trimmed to essentials: 2.0 Sistema (no apt-dry-run); 1.x menuGeral without stubs (2026-11-17)
- [x] Atividade log: merge stdout+stderr chronologically (apt vs [carcara] ordering) (2026-11-17)
- [x] Carcará 2.0 env: `.env.example` + Zod/`dotenv` in `src/env.ts`; wired to main + run-helper (2026-11-17)
- [x] `carcara_confirm`: root / NONINTERACTIVE → auto-yes (updateDistro + cleanDistro; no terminal y/N) (2026-11-17)
- [x] Dotfiles apply helper: `dotfiles/apply.sh` (*.bak, --dry-run/--symlink/modules; no root) (2026-11-17)
- [x] Dotfiles menus: 1.x `menuGeral` + `applyDotfiles.sh`; 2.0 rail/view + helper `dotfiles-*` as `$SUDO_USER` (2026-11-17)
- [x] Carcará 2.0 license gate (same `carcara/app/config/license` + Continuar checkbox as 1.x) (2026-11-17)
- [x] Session knowledge re-consolidated (env/Zod, tiles hover, carcara_confirm, Dotfiles menus, license gate) → memory-bank + playbook `carcara-2.0`/`carcara`/`dotfiles` + AGENTS (2026-11-17)
- [x] Hardened `dependences.sh`: apt-family detect, apt update on demand, iputils-ping, snapd socket, Flathub via backends, NI-safe notify (2026-11-17)
