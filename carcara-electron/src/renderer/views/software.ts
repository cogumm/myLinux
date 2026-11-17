import { createNavList } from "../components/nav-list.js";
import { createTileGrid } from "../components/tile-grid.js";
import { icons } from "../components/icons.js";
import type { TileProps } from "../components/tile.js";
import type { ViewMeta } from "../lib/types.js";

export const softwareMeta: ViewMeta = {
  eyebrow: "Catálogo",
  title: "Software",
  lede: "Instalações curadas — apt → Flatpak → Snap.",
};

type Category = {
  id: string;
  title: string;
  icon: keyof typeof icons;
  tiles: TileProps[];
};

const CATEGORIES: Category[] = [
  {
    id: "development",
    title: "Desenvolvimento",
    icon: "code",
    tiles: [
      {
        kicker: "Apt",
        title: "Git",
        desc: "gui / doc / gitg",
        action: "install-git",
        confirm: "Instalar Git e ferramentas GUI via apt?",
      },
      {
        kicker: "Editor",
        title: "VS Code",
        desc: "apt keyring → Snap",
        action: "install-vscode",
        confirm: "Instalar Visual Studio Code (Microsoft apt → Snap)?",
        accent: true,
      },
      {
        kicker: "API",
        title: "Insomnia",
        desc: "Flatpak → Snap",
        action: "install-insomnia",
        confirm: "Instalar Insomnia (Flatpak → Snap)?",
      },
      {
        kicker: "Fonte",
        title: "Fira Code",
        desc: "apt fonts-firacode",
        action: "install-firacode",
        confirm: "Instalar fonte Fira Code?",
      },
    ],
  },
  {
    id: "productivity",
    title: "Produção",
    icon: "briefcase",
    tiles: [
      {
        kicker: "Sync",
        title: "Dropbox",
        desc: "Flatpak → Snap",
        action: "install-dropbox",
        confirm: "Instalar Dropbox (Flatpak → Snap)?",
      },
    ],
  },
  {
    id: "social",
    title: "Social",
    icon: "users",
    tiles: [
      {
        kicker: "Chat",
        title: "Discord",
        desc: "Flatpak → Snap",
        action: "install-discord",
        confirm: "Instalar Discord?",
      },
      {
        kicker: "Música",
        title: "Spotify",
        desc: "apt → Flatpak → Snap",
        action: "install-spotify",
        confirm: "Instalar Spotify?",
      },
      {
        kicker: "Msg",
        title: "Telegram",
        desc: "Flatpak → Snap",
        action: "install-telegram",
        confirm: "Instalar Telegram Desktop?",
      },
    ],
  },
  {
    id: "utilities",
    title: "Utilidades",
    icon: "wrench",
    tiles: [
      {
        kicker: "Mídia",
        title: "VLC",
        desc: "apt → Flatpak → Snap",
        action: "install-vlc",
        confirm: "Instalar VLC?",
      },
    ],
  },
];

export function renderSoftware(): HTMLElement {
  const layout = document.createElement("div");
  layout.className = "soft-layout";

  const pane = document.createElement("div");
  pane.className = "soft-layout__pane";
  pane.setAttribute("role", "region");
  pane.setAttribute("aria-label", "Pacotes da categoria");

  const grids = new Map<string, HTMLElement>();
  for (const cat of CATEGORIES) {
    const grid = createTileGrid(cat.tiles);
    grid.hidden = true;
    grids.set(cat.id, grid);
    pane.append(grid);
  }

  function showCategory(id: string): void {
    for (const [catId, grid] of grids) {
      grid.hidden = catId !== id;
    }
    nav.setActive(id);
  }

  const nav = createNavList(
    CATEGORIES.map((cat) => ({
      id: cat.id,
      label: cat.title,
      iconHtml: icons[cat.icon](),
    })),
    showCategory,
    { label: "Categorias de software", className: "nav-list soft-layout__nav" },
  );

  layout.append(nav.root, pane);
  showCategory(CATEGORIES[0].id);
  return layout;
}
