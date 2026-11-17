import { createTileGrid } from "../components/tile-grid.js";
import type { ViewMeta } from "../lib/types.js";
import type { TileProps } from "../components/tile.js";

export const sistemaMeta: ViewMeta = {
  eyebrow: "Manutenção",
  title: "Sistema",
  lede: "Atualizar, corrigir, limpar e testar a rede.",
};

/** Core verbs only — same product surface as Carcará 1.x (no spike/dry-run). */
const TILES: TileProps[] = [
  {
    kicker: "Apt",
    title: "Atualizar sistema",
    desc: "update → upgrade → full-upgrade",
    action: "update-distro",
    confirm:
      "Atualizar o sistema (apt update + upgrade + full-upgrade)? Requer privilégios.",
    accent: true,
  },
  {
    kicker: "Reparar",
    title: "Correção do sistema",
    desc: "Dependências e configure -a",
    action: "fix-system",
    confirm: "Corrigir pacotes quebrados (apt -f + dpkg --configure -a)?",
  },
  {
    kicker: "Limpar",
    title: "Limpeza do sistema",
    desc: "Caminho seguro, sem locks",
    action: "clean-distro",
    confirm:
      "Limpeza do sistema (lixeira, tmp, apt clean/autoclean/autoremove, locks e listas apt)? Requer privilégios.",
  },
  {
    kicker: "Rede",
    title: "Testar conexão",
    desc: "Teste de conexão → Google (ICMP)",
    action: "ping",
  },
];

export function renderSistema(): HTMLElement {
  return createTileGrid(TILES);
}
