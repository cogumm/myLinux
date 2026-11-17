import { createGroup, createStack } from "../components/group.js";
import { createTileGrid } from "../components/tile-grid.js";
import type { TileProps } from "../components/tile.js";
import type { ViewMeta } from "../lib/types.js";

export const softwareMeta: ViewMeta = {
  eyebrow: "Catálogo",
  title: "Software",
  lede: "Instalações curadas — apt → Flatpak → Snap.",
};

type Category = {
  title: string;
  tiles: TileProps[];
};

const CATEGORIES: Category[] = [
  {
    title: "Desenvolvimento",
    tiles: [
      {
        title: "Git",
        desc: "apt · gui / doc / gitg",
        action: "install-git",
        confirm: "Instalar Git e ferramentas GUI via apt?",
      },
      {
        title: "VS Code",
        desc: "apt keyring → Snap",
        action: "install-vscode",
        confirm: "Instalar Visual Studio Code (Microsoft apt → Snap)?",
        accent: true,
      },
      {
        title: "Insomnia",
        desc: "Flatpak → Snap",
        action: "install-insomnia",
        confirm: "Instalar Insomnia (Flatpak → Snap)?",
      },
      {
        title: "Fira Code",
        desc: "apt fonts-firacode",
        action: "install-firacode",
        confirm: "Instalar fonte Fira Code?",
      },
    ],
  },
  {
    title: "Produção",
    tiles: [
      {
        title: "Dropbox",
        desc: "Flatpak → Snap",
        action: "install-dropbox",
        confirm: "Instalar Dropbox (Flatpak → Snap)?",
      },
    ],
  },
  {
    title: "Social",
    tiles: [
      {
        title: "Discord",
        desc: "Flatpak → Snap",
        action: "install-discord",
        confirm: "Instalar Discord?",
      },
      {
        title: "Spotify",
        desc: "apt → Flatpak → Snap",
        action: "install-spotify",
        confirm: "Instalar Spotify?",
      },
      {
        title: "Telegram",
        desc: "Flatpak → Snap",
        action: "install-telegram",
        confirm: "Instalar Telegram Desktop?",
      },
    ],
  },
  {
    title: "Utilidades",
    tiles: [
      {
        title: "VLC",
        desc: "apt → Flatpak → Snap",
        action: "install-vlc",
        confirm: "Instalar VLC?",
      },
    ],
  },
];

export function renderSoftware(): HTMLElement {
  return createStack(
    ...CATEGORIES.map((cat) =>
      createGroup(cat.title, createTileGrid(cat.tiles)),
    ),
  );
}
