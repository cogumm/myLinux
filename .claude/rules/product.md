---
description: Product scope for myLinux workstation toolkit
---

# Product — myLinux

**Canonical idea:** `.agents/idea/mylinux.md`  
If memory-bank or chat summaries disagree, **the Idea file wins**. Digest: `.agents/playbook/references/product.md`

## Mission

Automate and document **Gabriel’s Linux desktop/dev environment**: update, repair, clean, install curated apps, and sync personal shell/git/terminal settings.

## Surfaces

1. **Carcará** — interactive maintenance + software menus (root).
2. **Dotfiles** — user-level shell experience (no root required to *use*; install may copy/link files).
3. **Helpers** — focused scripts (e.g. Zone.Identifier cleanup on WSL).
4. **old/** — historical reference only.

## Non-goals (v1 modernization)

- Not a multi-tenant SaaS, not a payment platform.
- Not a full distro installer / image builder.
- Not supporting every distro equally — **apt family first**.
- Not silently rewriting the user’s home without confirmation.

## Safety product rules

- Root actions must announce impact (update / purge / lock removal).
- Cleaning must not delete unrelated user projects.
- Install scripts should be **idempotent** where practical (skip if already installed).
- Disclaimer in `head()` stays: owner is not liable for misuse.
