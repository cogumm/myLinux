# Legacy (`old/`)

Archive only — **do not add features**. Port useful *ideas* into `carcara/` as modern thin installers.

| Script | Notes |
|--------|--------|
| `myLinux.sh` | Minimal menu: connection test / clean — superseded by `menuGeral` / 2.0 Sistema |
| `scripts/checkDistro.sh` | Old `DISTRIB_ID` — pattern covered by `dependences.sh` + `/etc/os-release` |
| `scripts/dev.sh` | LAMP + Ruby + Atom via dialog — obsolete / unsafe — **do not port** |
| `scripts/myUbuntu.sh` | Desktop apps via dialog — dead URLs/PPAs; mine **names** only if on v2.0.1 list |
| `scripts/docker.sh` | Legacy Docker — brittle `which`; `curl\|bash`; tutum era |

## Ported

- Docker **install** path → `carcara/app/scripts/software/development/docker.sh` (official apt → `docker.io`; group `$SUDO_USER`; no curl\|bash; no tutum/clean-all).

## Reuse as ideas only (rewrite from scratch if in TODO v2.0.1)

| Idea in `old/` | Modern approach |
|----------------|-----------------|
| Anki | Flatpak |
| Wine / PlayOnLinux | WineHQ / Lutris Flatpak (Battle.net) |
| Chrome / browsers | Official keyring or Flatpak |
| GIMP / archive tools (`installZIP`) | apt / Flatpak thin installers |
| TeamViewer-class remote | Current `.deb` / Flatpak (or RustDesk/AnyDesk) |
| LibreOffice | apt / Flatpak — never alien+RPM 4.x |

## Never revive

- PHP5 / MySQL password-in-dialog / `chmod 777 www`
- Docky, Ubuntu-Tweak, Google Talk, Popcorn, Skype i386, Unity Telegram webapp
- LibreOffice via `alien` + ancient RPM
- Docker mass-delete / tutum helpers / `curl|bash` get.docker.com
