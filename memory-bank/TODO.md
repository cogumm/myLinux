# TODO — myLinux inbox

Last updated: 2026-11-17

Unscheduled ideas (promote into active work deliberately).  
Canonical product ideas: `.agents/idea/mylinux.md`, `.agents/idea/carcara-2.0-electron.md`.  
Session dump: `memory-bank/activeContext.md` (17 Nov 2026 — packaging + version + helper paths).  
Also mirrored under “Still open” in `.agents/playbook/references/carcara-2.0.md` and `references/carcara.md`.

## Still open (summary)

| Track | Open item | Notes |
|-------|-----------|--------|
| — | _(smoke inbox clear)_ | Use `smoke:elevated` after one-time `smoke:nopasswd-install` |

**Done recently:** Waves A–C; `.deb` + AppImage; `--live-core` / `--live-extended`; passwordless `smoke:elevated`; skills.  
Wave 1–2 engine **done**. Wave 3 **cancelled** (UI is Electron 2.0).  
**v2.0.0** = usable alpha. **v2.0.1** = richer catalog + polish (waves below — catalog shipped).

## Planned ideas

- [x] Wave 1 Steps 1–5 — engine complete (17 de Novembro de 2026)
- [x] Wave 2 — thin installers on backends (17 de Novembro de 2026)
- [x] Cancel Wave 3 / start Electron 2.0 (17 de Novembro de 2026)
- [x] Carcará 2.0 alpha UI (modular renderer, helper wiring, Flat Design) (17 de Novembro de 2026)
- [x] Env Zod + `.env.example` in `carcara-electron/` (17 de Novembro de 2026)
- [x] Dotfiles menus (1.x + 2.0) + license gate 2.0 (17 de Novembro de 2026)
- [x] Session knowledge consolidated → memory-bank + playbook (17 de Novembro de 2026)
- [x] i18n + rail PT\|EN switch (17 de Novembro de 2026)
- [x] Sistema tile **Sincronizar horário** → `sync_time.sh` (17 de Novembro de 2026)
- [x] Continue [`.agents/idea/carcara-2.0-electron.md`](../.agents/idea/carcara-2.0-electron.md) — Software/pkexec smoke harness (`smoke:software`; wiring PASS on WSL; live/pkexec still host-gated) (17 de Novembro de 2026)
- [x] Package `.deb` + GitHub Actions Release workflow (17 de Novembro de 2026)
- [x] **v2.0.1** Wave A catalog (11 apps + `install_deb_url`) (17 de Novembro de 2026)
- [x] **v2.0.1** Wave B (Heroic/Lutris/browsers/Audacity/Navidrome + 1.x folders) (17 de Novembro de 2026)
- [x] **v2.0.1** Wave C (office, passwords, Proton/Nord, Node toolchain, presets, search/badges, Sobre health) (17 de Novembro de 2026)

## Carcará / scripts (1.x)

- [x] Wave 1 + Wave 2 engine work
- [x] Wave 2 installer wiring + `bash -n` via `bun run smoke:software` (17 de Novembro de 2026)
- [x] Live smoke-test baseline installers on owner machine — `sudo env "PATH=$PATH" bun run smoke:software -- --live-core` (17 de Novembro de 2026)
- [x] Harden / rewrite `dependences.sh` (apt-family, update, Flathub, NI) (17 de Novembro de 2026)
- [x] Dotfiles apply helper with `*.bak` backups (`dotfiles/apply.sh`) (17 de Novembro de 2026)
- [x] Menu 1.x **Dotfiles** → `applyDotfiles.sh` as `$SUDO_USER` (17 de Novembro de 2026)
- [x] Port Docker from `old/scripts/docker.sh` → modern `development/docker.sh` (+ 1.x/2.0 menus) (17 de Novembro de 2026)
- [x] i18n menus pt/en (`locales/*.json`, `CARCARA_LANG`) for 1.x + 2.0 (17 de Novembro de 2026)
- [x] Harden `sync_time.sh` (timedatectl → ntpdate; NI / `carcara_confirm`) (17 de Novembro de 2026)

## Carcará 2.0

- [x] Plan + scaffold `carcara-electron/` spike (helper + apt dry-run UI)
- [x] Modular views/components + ui-ux-pro-max Flat shell
- [x] System + software helper actions wired
- [x] Dual entry via root `start.sh` + README
- [x] WSL openExternal + quieter `ping`
- [x] Env: `.env.example` + Zod/`dotenv` (`src/env.ts`)
- [x] Smoke-test Sistema as root (sudo+Bun PATH): ping / update / fix / clean → exit 0 (17 de Novembro de 2026)
- [x] Dotfiles rail + helper `dotfiles-*` (unprivileged / as `$SUDO_USER`) (17 de Novembro de 2026)
- [x] License gate (1.x parity; checkbox Continuar) (17 de Novembro de 2026)
- [x] Rail language switch PT\|EN (`localStorage` override; env default) (17 de Novembro de 2026)
- [x] Sistema **sync-time** → `sync_time.sh` (17 de Novembro de 2026)
- [x] Software smoke harness (`scripts/smoke-software.sh` / `bun run smoke:software`) — UI↔helper↔scripts + ping + pkexec probe (17 de Novembro de 2026)
- [x] Live baseline installs via `--live-core` (owner machine; preserve Bun PATH under sudo) (17 de Novembro de 2026)
- [x] Broader live Software installs — `--live-extended` + `smoke:elevated` (17 de Novembro de 2026)
- [x] Passwordless elevated smoke — `smoke:nopasswd-install` + `smoke:elevated` (`sudo -n`; avoids polkit hang on WSL) (17 de Novembro de 2026)
- [x] Package `.deb` for Carcará 2.0 (`electron-builder` + `pack:deb`) (17 de Novembro de 2026)
- [x] Package **AppImage** (`pack:appimage` / `pack:linux`; CI attaches with `.deb`) (17 de Novembro de 2026)
- [x] CI: `.github/workflows/release-deb.yml` — Release published → attach `.deb` + AppImage (17 de Novembro de 2026)
- [x] Locale `{version}` for `window.title` / `ready.log` ← `package.json` (17 de Novembro de 2026)
- [x] Session knowledge re-consolidated (packaging + version + helper paths) → memory-bank + playbook (17 de Novembro de 2026)

## v2.0.1 — catalog enrichment (done)

Policy stays **apt → Flatpak/Flathub → Snap**. Thin installers + 1.x menus + 2.0 tiles + helper allowlist + `locales`.  
**Catalog tracker:** this section (v2.0.1). Research note: [`.agents/idea/listSoftwares.md`](../.agents/idea/listSoftwares.md) → [Snap Store](https://snapcraft.io/store). Promote into `softwares.md` as each item ships.

### Already in Carcará (match wishlist)

- [x] Git · VS Code · Docker Engine (`docker.sh`) · Insomnia · Discord · Telegram · Spotify  
  - Note: wishlist **Docker Desktop** ≠ Engine — skipped for v2.0.1 (Engine is enough).

### Wave A — core wishlist (ship first)

- [x] **Firefox** (Browsers) — `utilities/firefox.sh` (17 de Novembro de 2026)
- [x] **WhatsApp Desktop** (Social) — `social/whatsapp.sh` (17 de Novembro de 2026)
- [x] **Cursor** (Development) — vendor amd64 `.deb` via `install_deb_url` (17 de Novembro de 2026)
- [x] **Termius** (Development) — `development/termius.sh` (17 de Novembro de 2026)
- [x] **Anki** (Productivity) — Flatpak → Snap (17 de Novembro de 2026)
- [x] **Steam** (Games) — Flatpak → apt (17 de Novembro de 2026)
- [x] **Notion** (Productivity) — Snap → Flatpak (17 de Novembro de 2026)
- [x] **Brave** (Browsers) — apt keyring → Snap (17 de Novembro de 2026)
- [x] **Postman** (Development) — Flatpak → Snap; Insomnia kept (17 de Novembro de 2026)
- [x] **Thunderbird** (Productivity / mail) (17 de Novembro de 2026)
- [x] **OBS Studio** (Media) — `utilities/obs.sh` (17 de Novembro de 2026)
- [x] Update `softwares.md` as Wave A lands (17 de Novembro de 2026)

### Wave B — fill Snap Store categories (2.0 already lists all 19)

Categories mirror [Snap Store](https://snapcraft.io/store): Development, Games, Social, Productivity, Utilities, Music and Audio, Art and Design, Photo and Video, Server and Cloud, Books and Reference, Devices and IoT, Education, Entertainment, Finance, Health and Fitness, News and Weather, Personalisation, Science, Security.

- [x] **Games**: Steam; Heroic (Epic+GOG); Lutris (Wine/Battle.net) (17 de Novembro de 2026)
- [x] **Browsers**: Firefox, Brave, Vivaldi, Opera (GX tile), Zen (“Zem”) — 2.0 under Utilities; 1.x `browsers/` (17 de Novembro de 2026)
- [x] **Photo and Video / Music**: OBS (utilities); Audacity + Navidrome (`music/`); VLC/Spotify already shipped (17 de Novembro de 2026)
- [x] Wire 1.x `menuSof` → development / games / browsers / social / productivity / music / utilities (17 de Novembro de 2026)

### Wave C — depth (remainder of the wishlist)

- [x] **LibreOffice** · **OnlyOffice** (Productivity) (17 de Novembro de 2026)
- [x] **1Password** · **Bitwarden** (both offered; `security/`) (17 de Novembro de 2026)
- [x] **Proton Mail** · **Proton VPN** (Social / Utilities) (17 de Novembro de 2026)
- [x] **NordVPN** (Utilities) (17 de Novembro de 2026)
- [x] **Node.js** toolchain: NodeSource/apt + npm -g pnpm/yarn + Bun GitHub zip (no curl\|bash) (17 de Novembro de 2026)
- [x] **Audacity** · **Navidrome** (shipped in Wave B `music/`) (17 de Novembro de 2026)
- [x] **Docker Desktop** — skipped; Engine (`docker.sh`) is enough (17 de Novembro de 2026)
- [x] Presets: *Dev box* / *Social box* / *Gaming light* (`presets/`) (17 de Novembro de 2026)
- [x] 2.0 Software **pagination** (6/page, Anterior/Próxima) (17 de Novembro de 2026)
- [x] 2.0 UX: category search + backend badges on tiles (17 de Novembro de 2026)
- [x] Sobre/health: distro + arch + flatpak/snap via `host:info` IPC (17 de Novembro de 2026)

### Explicitly out of v2.0.1

- Snap Store mirror / install-everything
- LAMP PHP5 / RVM / Atom / dead PPAs from `old/`
- Popcorn, Skype i386, Docky, Ubuntu-Tweak, tutum Docker helpers
- Archive tools / GIMP / Slack / Signal / `gh` — only if added back to this v2.0.1 section

## Agent skills (skills.sh)

Playbook stays canonical: `.agents/playbook/`. Usage notes: `.agents/skills/README.md`. Lockfile: `skills-lock.json`.

| Status | Skill | Path | When it helps |
|--------|--------|------|----------------|
| Done | `shellcheck-configuration` (`wshobson/agents`) | `.agents/skills/shellcheck-configuration` | Lint/harden Carcará Bash |
| Done | `ui-ux-pro-max` | `.agents/skills/ui-ux-pro-max` | Carcará 2.0 design-system / Flat Design |
| Done | `bash-scripting` (`sickn33/agentic-awesome-skills`) | `.agents/skills/bash-scripting` (17 de Novembro de 2026) | Defensive scripting when rewriting installers / menus |
| Done | `debian-linux-triage` (`github/awesome-copilot`) | `.agents/skills/debian-linux-triage` (17 de Novembro de 2026) | Safer apt/dpkg/systemd design for `updateDistro` / `fixSystem` / `cleanDistro` |

Links:

- https://skills.sh/wshobson/agents/shellcheck-configuration
- https://skills.sh/sickn33/agentic-awesome-skills/bash-scripting
- https://skills.sh/github/awesome-copilot/debian-linux-triage
