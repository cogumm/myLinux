---
description: Prefer editing existing shell/dotfile paths; avoid fragmentation
---

# Code organization

Do not create new files unless truly necessary.

Before creating any file, check whether a suitable script or dotfile already exists.

Prefer editing existing files under `carcara/` and `dotfiles/`.

Avoid fragmenting menus and installers. One app = one script under the right category (`development/`, `social/`, `utilities/`, `productivity/`, `system/`).

Prefer small reusable helpers in `config.sh` (`head`, `isRoot`, paths, Yad presets).

Comments only for complex spots or traps (WSL, dpkg locks).

If a new file is required: justify it in one sentence, follow existing naming (`camelCase.sh` / `_menu.sh`), and do not duplicate logic.

**`old/`:** do not add features. Extract and rewrite into `carcara/` if something is still useful.

Priority: reuse → improve what exists → only then create new structure.

Detail: `.agents/playbook/references/code-organization.md`
