---
description: Memory bank workflow for myLinux
---

# Memory Bank — myLinux

Memory resets between sessions. **Read ALL `memory-bank/` core files at the start of EVERY task** before coding.

## Structure

`projectbrief.md` → `productContext.md` / `systemPatterns.md` / `techContext.md` → `activeContext.md` → `TODO.md` → `progress.md`

| File | Purpose |
|------|---------|
| `projectbrief.md` | Scope, mission, phases |
| `productContext.md` | User journeys (Carcará, dotfiles, WSL helper) |
| `techContext.md` | Stack, commands, constraints |
| `systemPatterns.md` | Script layout, sourcing, safety patterns |
| `activeContext.md` | Current focus, recent decisions |
| `TODO.md` | Unscheduled inbox |
| `progress.md` | Cumulative log (**append-only**) |

**Also read:** `.agents/playbook/SKILL.md`, `.agents/idea/mylinux.md`.

## When to update

| Trigger | Update |
|---------|--------|
| Focus changes | `activeContext.md` |
| Milestone shipped | `progress.md` (append only) |
| New stable pattern | `systemPatterns.md` + playbook `references/` |
| Stack / setup | `techContext.md` |
| User says update memory bank | review **all** core files |
| Unversioned idea | `TODO.md` first |

**Language:** memory-bank, playbook, and idea docs in **English**.

### Dates

Before changing `Last updated:`, run `date '+%Y-%m-%d'`. Never guess.

### `progress.md` — append-only

Never delete completed history. Only add. Tick not-started → completed; if consolidating, mark old lines `(superseded by …)`.

`activeContext.md` may be rewritten; `progress.md` is the permanent log.
