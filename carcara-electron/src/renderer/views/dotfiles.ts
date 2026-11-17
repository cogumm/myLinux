import { createTileGrid } from "../components/tile-grid.js";
import type { ViewMeta } from "../lib/types.js";
import type { TileProps } from "../components/tile.js";

export const dotfilesMeta: ViewMeta = {
  eyebrow: "Casa",
  title: "Dotfiles",
  lede: "Aplica aliases, git, Hyper e temas no seu $HOME (backup *.bak; sem root).",
};

const TILES: TileProps[] = [
  {
    kicker: "Preview",
    title: "Dry-run",
    desc: "Mostra o que --all faria",
    action: "dotfiles-dry-run",
  },
  {
    kicker: "Shell",
    title: "Aliases",
    desc: "~/.bash_aliases + ~/.aliases/*",
    action: "dotfiles-aliases",
    confirm: "Aplicar aliases no seu usuário (backup *.bak se já existirem)?",
  },
  {
    kicker: "Pacote",
    title: "Tudo",
    desc: "aliases + git + hyper + tema",
    action: "dotfiles-all",
    confirm:
      "Aplicar pacote --all (exceto bashrc) no seu $HOME com backup *.bak?",
    accent: true,
  },
  {
    kicker: "Git",
    title: "Git config",
    desc: ".gitconfig + .gitignore_global",
    action: "dotfiles-git",
    confirm: "Aplicar template git (tokens vazios) com backup *.bak?",
  },
  {
    kicker: "Terminal",
    title: "Hyper",
    desc: "~/.hyper.js",
    action: "dotfiles-hyper",
    confirm: "Aplicar Hyper config com backup *.bak?",
  },
  {
    kicker: "Zsh",
    title: "Tema cgm",
    desc: "oh-my-zsh themes/cgm",
    action: "dotfiles-theme",
    confirm: "Instalar tema cgm.zsh-theme (requer oh-my-zsh)?",
  },
  {
    kicker: "Bash",
    title: "bashrc",
    desc: "substitui ~/.bashrc",
    action: "dotfiles-bashrc",
    confirm:
      "Substituir ~/.bashrc pelo template cGm_ (backup *.bak)? Opt-in deliberado.",
  },
];

export function renderDotfiles(): HTMLElement {
  return createTileGrid(TILES);
}
