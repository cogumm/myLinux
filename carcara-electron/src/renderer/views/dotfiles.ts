import { createTileGrid } from "../components/tile-grid.js";
import { t } from "../lib/i18n.js";
import type { ViewMeta } from "../lib/types.js";
import type { TileProps } from "../components/tile.js";

export function getDotfilesMeta(): ViewMeta {
  return {
    eyebrow: t("view.dotfiles.eyebrow"),
    title: t("view.dotfiles.title"),
    lede: t("view.dotfiles.lede"),
  };
}

export function renderDotfiles(): HTMLElement {
  const tiles: TileProps[] = [
    {
      kicker: "Preview",
      title: t("dotfiles.dryrun"),
      desc: "--dry-run --all",
      action: "dotfiles-dry-run",
    },
    {
      kicker: "Shell",
      title: t("dotfiles.aliases"),
      desc: "~/.bash_aliases + ~/.aliases/*",
      action: "dotfiles-aliases",
      confirm: t("dotfiles.notify.aliases"),
    },
    {
      kicker: "Pack",
      title: t("dotfiles.all"),
      desc: "aliases + git + hyper + theme",
      action: "dotfiles-all",
      confirm: t("dotfiles.notify.all"),
      accent: true,
    },
    {
      kicker: "Git",
      title: t("dotfiles.git"),
      desc: ".gitconfig + .gitignore_global",
      action: "dotfiles-git",
      confirm: t("dotfiles.notify.git"),
    },
    {
      kicker: "Term",
      title: t("dotfiles.hyper"),
      desc: "~/.hyper.js",
      action: "dotfiles-hyper",
      confirm: t("dotfiles.notify.hyper"),
    },
    {
      kicker: "Zsh",
      title: t("dotfiles.theme"),
      desc: "oh-my-zsh themes/cgm",
      action: "dotfiles-theme",
      confirm: t("dotfiles.notify.theme"),
    },
    {
      kicker: "Bash",
      title: t("dotfiles.bashrc"),
      desc: "~/.bashrc",
      action: "dotfiles-bashrc",
      confirm: t("dotfiles.notify.bashrc"),
    },
  ];
  return createTileGrid(tiles);
}
