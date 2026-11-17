import { createTileGrid } from "../components/tile-grid.js";
import type { ViewMeta } from "../lib/types.js";
import type { TileProps } from "../components/tile.js";

export const sistemaMeta: ViewMeta = {
  eyebrow: "Manutenção",
  title: "Sistema",
  lede: "Atualizar, corrigir e limpar via helper privilegiado.",
};

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
      "Limpeza segura (lixeira, tmp, apt clean/autoclean/autoremove)? Locks e listas apt não serão removidos.",
  },
  {
    kicker: "Simular",
    title: "Apt dry-run",
    desc: "Sem alterar pacotes",
    action: "apt-dry-run",
  },
  {
    kicker: "Diagnóstico",
    title: "Ping helper",
    desc: "Testa o bridge Bun",
    action: "ping",
  },
];

export function renderSistema(): HTMLElement {
  return createTileGrid(TILES);
}
