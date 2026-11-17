import { createTileGrid } from "../components/tile-grid.js";
import { t } from "../lib/i18n.js";
import type { ViewMeta } from "../lib/types.js";
import type { TileProps } from "../components/tile.js";

export function getSistemaMeta(): ViewMeta {
  return {
    eyebrow: t("view.sistema.eyebrow"),
    title: t("view.sistema.title"),
    lede: t("view.sistema.lede"),
  };
}

export function renderSistema(): HTMLElement {
  const tiles: TileProps[] = [
    {
      kicker: "Apt",
      title: t("tile.update.title"),
      desc: t("tile.update.desc"),
      action: "update-distro",
      confirm: t("tile.update.confirm"),
      accent: true,
    },
    {
      kicker: "Apt",
      title: t("tile.fix.title"),
      desc: t("tile.fix.desc"),
      action: "fix-system",
      confirm: t("tile.fix.confirm"),
    },
    {
      kicker: "Apt",
      title: t("tile.clean.title"),
      desc: t("tile.clean.desc"),
      action: "clean-distro",
      confirm: t("tile.clean.confirm"),
    },
    {
      kicker: "ICMP",
      title: t("tile.ping.title"),
      desc: t("tile.ping.desc"),
      action: "ping",
    },
  ];
  return createTileGrid(tiles);
}
