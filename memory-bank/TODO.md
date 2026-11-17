# TODO — myLinux inbox

Last updated: 2026-11-17

Unscheduled ideas (promote into active work deliberately).  
Canonical product ideas: `.agents/idea/mylinux.md`, `.agents/idea/carcara-2.0-electron.md`.  
Session dump: `memory-bank/activeContext.md` (17 Nov 2026 — packaging + version + helper paths).  
Also mirrored under “Still open” in `.agents/playbook/references/carcara-2.0.md` and `references/carcara.md`.

## Still open (summary)

| Track | Open item | Notes |
|-------|-----------|--------|
| **2.0** | Smoke-test Software installers via UI | Owner-requested apt/flatpak/snap |
| **2.0** | Smoke-test privileged actions with **pkexec** | Real Linux desktop / WSLg (not already-root) |
| **2.0** | Optional AppImage | `.deb` + Release CI **done** |
| **2.0.1** | Catalog wave **C** (below) | Waves A+B **done** |
| **1.x** | Live smoke-test Wave 2 installers | Same machine gate as 2.0 Software |
| Skills | `bash-scripting`, `debian-linux-triage` | Install when rewriting that area |

Wave 1–2 engine **done**. Wave 3 **cancelled** (UI is Electron 2.0).  
**v2.0.0** = usable alpha. **v2.0.1** = richer catalog + polish (waves below).

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
- [ ] Continue [`.agents/idea/carcara-2.0-electron.md`](../.agents/idea/carcara-2.0-electron.md) — Software/pkexec smoke-test (owner machine)
- [x] Package `.deb` + GitHub Actions Release workflow (17 de Novembro de 2026)
- [x] **v2.0.1** Wave A catalog (11 apps + `install_deb_url`) (17 de Novembro de 2026)
- [x] **v2.0.1** Wave B (Heroic/Lutris/browsers/Audacity/Navidrome + 1.x folders) (17 de Novembro de 2026)
- [ ] **v2.0.1** catalog wave C (see section below)

## Carcará / scripts (1.x)

- [x] Wave 1 + Wave 2 engine work
- [ ] Live smoke-test of Wave 2 installers (owner-requested machine)
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
- [ ] Smoke-test Software installers (owner-requested)
- [ ] Smoke-test with **pkexec** on real desktop / WSLg (unelevated user → elevates)
- [x] Package `.deb` for Carcará 2.0 (`electron-builder` + `pack:deb`; AppImage optional later) (17 de Novembro de 2026)
- [x] CI: `.github/workflows/release-deb.yml` — Release published → attach `carcara_*_amd64.deb` (17 de Novembro de 2026)
- [x] Locale `{version}` for `window.title` / `ready.log` ← `package.json` (17 de Novembro de 2026)
- [x] Session knowledge re-consolidated (packaging + version + helper paths) → memory-bank + playbook (17 de Novembro de 2026)
- [ ] Optional AppImage target

## v2.0.1 — catalog enrichment (planned)

Policy stays **apt → Flatpak/Flathub → Snap**. Thin installers + 1.x menus + 2.0 tiles + helper allowlist + `locales`.  
**Catalog tracker:** this section (v2.0.1). Research note: [`.agents/idea/listSoftwares.md`](../.agents/idea/listSoftwares.md) → [Snap Store](https://snapcraft.io/store). Promote into `softwares.md` as each item ships.

### Already in Carcará (match wishlist)

- [x] Git · VS Code · Docker Engine (`docker.sh`) · Insomnia · Discord · Telegram · Spotify  
  - Note: wishlist **Docker Desktop** ≠ Engine — decide later if Desktop gets its own tile.

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

- [ ] **LibreOffice** · **OnlyOffice** (Productivity)
- [ ] **1Password** · **Bitwarden** (passwords) — pick one default or offer both
- [ ] **Proton Mail** · **Proton VPN** (Social / Utilities)
- [ ] **NordVPN** (Utilities)
- [ ] **Node.js** toolchain: Node + npm + **pnpm** + **Yarn** + **Bun** (Development; prefer mise/fnm or NodeSource — no `curl|bash` unless owner asks)
- [x] **Audacity** · **Navidrome** (shipped in Wave B `music/`) (17 de Novembro de 2026)
- [ ] **Docker Desktop** tile only if Engine is not enough (clarify vs `docker.sh`)
- [ ] Presets: *Dev box* / *Social box* / *Gaming light*
- [x] 2.0 Software **pagination** (6/page, Anterior/Próxima) (17 de Novembro de 2026)
- [ ] 2.0 UX: search/filter tiles; backend badge (`apt` · `flatpak` · `snap`)
- [ ] Sobre/health: distro + arch + flatpak/snap status

### Explicitly out of v2.0.1

- Snap Store mirror / install-everything
- LAMP PHP5 / RVM / Atom / dead PPAs from `old/`
- Popcorn, Skype i386, Docky, Ubuntu-Tweak, tutum Docker helpers
- Archive tools / GIMP / Slack / Signal / `gh` — only if added back to this v2.0.1 section

## Future agent skills (skills.sh) — install when modernizing that area

Incremental modernization; do **not** install everything at once. Playbook stays canonical: `.agents/playbook/`.

| Priority | Skill | Install | When it helps |
|----------|--------|---------|----------------|
| Done | `shellcheck-configuration` (`wshobson/agents`) | installed → `.agents/skills/shellcheck-configuration` | Lint/harden Carcará Bash during script rewrites |
| Done | `ui-ux-pro-max` | installed → `.agents/skills/ui-ux-pro-max` | Carcará 2.0 design-system / Flat Design |
| Next | `bash-scripting` (`sickn33/agentic-awesome-skills`) | `npx skills add sickn33/agentic-awesome-skills@bash-scripting` | Defensive scripting patterns when rewriting installers / menus |
| Later | `debian-linux-triage` (`github/awesome-copilot`) | `npx skills add github/awesome-copilot@debian-linux-triage` | Safer apt/dpkg/systemd flows in `updateDistro` / `fixSystem` / `cleanDistro` |

Links:

- https://skills.sh/wshobson/agents/shellcheck-configuration
- https://skills.sh/sickn33/agentic-awesome-skills/bash-scripting
- https://skills.sh/github/awesome-copilot/debian-linux-triage
