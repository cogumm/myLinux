---
description: Safety rules for apt, root, and destructive shell operations
---

# Shell safety — myLinux

- Assume scripts may run as **root**. Guard with `isRoot` only when privilege is required; never force root for pure dotfile copy if avoidable.
- Quote all path expansions: `"$var"`, especially under `/home`, `/var`, WSL mounts.
- Prefer `apt-get` with explicit packages; avoid unbounded `purge` / `rm -rf` on `$HOME`.
- Removing `/var/lib/dpkg/lock` or apt lists is last-resort repair — confirm with the user on production machines.
- Do not pipe remote scripts to bash in new code (`curl | bash`) unless the owner explicitly wants that UX; prefer clone + local run.
- Check network before downloads (`testConnection.sh` pattern).
- Idempotency: if `command -v tool` succeeds, skip reinstall or offer refresh only.
- Log or echo the command about to run for destructive steps.
- On WSL, never delete Windows-side files unless the path was explicitly passed (see `cleanup-zone-identifiers.sh`).
