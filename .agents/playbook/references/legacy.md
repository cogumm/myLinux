# Legacy (`old/`)

| Script | Notes |
|--------|--------|
| `myLinux.sh` | Minimal menu: connection test / clean — references missing `cleanDebian.sh` in places |
| `scripts/checkDistro.sh` | DISTRIB_ID parsing — modernize to `/etc/os-release` |
| `scripts/dev.sh` | LAMP + Ruby + Atom via dialog — obsolete packages |
| `scripts/myUbuntu.sh` | Desktop apps via dialog — mostly commented out; dead URLs |
| `scripts/docker.sh` | Legacy Docker install/clean/run — brittle `which`; `curl\|bash`; tutum era |

**Ported:** install path → `carcara/app/scripts/software/development/docker.sh` (official apt → docker.io; group `$SUDO_USER`; no curl\|bash; no tutum/clean-all).  
Use the rest as archaeology only.
