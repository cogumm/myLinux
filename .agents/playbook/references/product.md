# Product digest

**myLinux** = personal Linux environment automation (Gabriel / CoGUMm).

- **Carcará 1.x** — Bash engine + Zenity/Yad CLI/fallback (update / install / fix / clean / Dotfiles)
- **Carcará 2.0** — Electron product UI over the same engine (Bun for build/dev; `.deb` runtime without Bun)
- **Dotfiles** — `apply.sh` with `*.bak`; menus in both tracks
- **Releases** — GitHub Release → CI attaches `carcara_*_amd64.deb`
- **old/** — archive only

Not a multi-tenant SaaS, not a payment platform, not a web application.  
Apt-family first. Still open: live Software/pkexec smoke-tests + v2.0.1 catalog + optional AppImage — see `memory-bank/TODO.md`.
