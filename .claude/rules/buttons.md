---
description: Standard Carcará menu action verbs and feedback
---

# Menu actions — Carcará

Interactive flows use Zenity/Yad, not web buttons. Keep **verbs consistent** across menus:

| Action (PT) | Meaning | Typical script |
|-------------|---------|----------------|
| Atualizar sistema | apt update / upgrade / dist-upgrade | `system/updateDistro.sh` |
| Instalar… | Package or snap install (idempotent when possible) | `software/**` |
| Correção do sistema | `apt-get -f install`, `dpkg --configure -a` | `system/fixSystem.sh` |
| Limpeza do sistema | trash/tmp/apt clean + careful lock repair | `system/cleanDistro.sh` |
| Voltar | Return to parent menu | `menuSof.sh` → `menuGeral.sh` |
| Sair | Exit loop cleanly | `menuGeral.sh` |

Rules:

- Every list menu ends with **Voltar** or **Sair**.
- Yad timeout notices are for success/info only — errors stay visible in the terminal.
- Do not use emoji as the only label for an action.
- Incomplete features must say “Ainda em desenvolvimento” **or** be wired to a real script — do not fake success.
