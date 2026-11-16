# Legacy (`old/`)

| Script | Notes |
|--------|--------|
| `myLinux.sh` | Minimal menu: connection test / clean — references missing `cleanDebian.sh` in places |
| `scripts/checkDistro.sh` | DISTRIB_ID parsing — modernize to `/etc/os-release` |
| `scripts/dev.sh` | LAMP + Ruby + Atom via dialog — obsolete packages |
| `scripts/myUbuntu.sh` | Desktop apps via dialog — mostly commented out; dead URLs |
| `scripts/docker.sh` | Docker install/clean/run — brittle `which` tests; tutum image era |

Use as archaeology. Reimplement needed behavior in Carcará with current packages.
