import { createNavList } from "../components/nav-list.js";
import { createTileGrid } from "../components/tile-grid.js";
import { icons } from "../components/icons.js";
import { t } from "../lib/i18n.js";
import type { TileProps } from "../components/tile.js";
import type { ViewMeta } from "../lib/types.js";

export function getSoftwareMeta(): ViewMeta {
  return {
    eyebrow: t("view.software.eyebrow"),
    title: t("view.software.title"),
    lede: t("view.software.lede"),
  };
}

type Category = {
  id: string;
  titleKey: string;
  icon: keyof typeof icons;
  tiles: TileProps[];
};

function categories(): Category[] {
  return [
    {
      id: "development",
      titleKey: "cat.development",
      icon: "code",
      tiles: [
        {
          kicker: "Apt",
          title: "Git",
          desc: "gui / doc / gitg",
          action: "install-git",
          confirm: t("install.git") + "?",
        },
        {
          kicker: "Editor",
          title: "VS Code",
          desc: "apt keyring → Snap",
          action: "install-vscode",
          confirm: t("install.vscode") + "?",
          accent: true,
        },
        {
          kicker: "API",
          title: "Insomnia",
          desc: "Flatpak → Snap",
          action: "install-insomnia",
          confirm: t("install.insomnia") + "?",
        },
        {
          kicker: "Font",
          title: "Fira Code",
          desc: "apt fonts-firacode",
          action: "install-firacode",
          confirm: t("install.firacode") + "?",
        },
        {
          kicker: "Runtime",
          title: "Docker",
          desc: "official apt → docker.io",
          action: "install-docker",
          confirm: t("tile.docker.confirm"),
        },
      ],
    },
    {
      id: "productivity",
      titleKey: "cat.productivity",
      icon: "briefcase",
      tiles: [
        {
          kicker: "Sync",
          title: "Dropbox",
          desc: "Flatpak → Snap",
          action: "install-dropbox",
          confirm: t("install.dropbox") + "?",
        },
      ],
    },
    {
      id: "social",
      titleKey: "cat.social",
      icon: "users",
      tiles: [
        {
          kicker: "Chat",
          title: "Discord",
          desc: "Flatpak → Snap",
          action: "install-discord",
          confirm: t("install.discord") + "?",
        },
        {
          kicker: "Music",
          title: "Spotify",
          desc: "apt → Flatpak → Snap",
          action: "install-spotify",
          confirm: t("install.spotify") + "?",
        },
        {
          kicker: "Msg",
          title: "Telegram",
          desc: "Flatpak → Snap",
          action: "install-telegram",
          confirm: t("install.telegram") + "?",
        },
      ],
    },
    {
      id: "utilities",
      titleKey: "cat.utilities",
      icon: "wrench",
      tiles: [
        {
          kicker: "Media",
          title: "VLC",
          desc: "apt → Flatpak → Snap",
          action: "install-vlc",
          confirm: t("install.vlc") + "?",
        },
      ],
    },
  ];
}

export function renderSoftware(): HTMLElement {
  const cats = categories();
  const layout = document.createElement("div");
  layout.className = "soft-layout";

  const pane = document.createElement("div");
  pane.className = "soft-layout__pane";
  pane.setAttribute("role", "region");

  const grids = new Map<string, HTMLElement>();
  for (const cat of cats) {
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
    cats.map((cat) => ({
      id: cat.id,
      label: t(cat.titleKey),
      iconHtml: icons[cat.icon](),
    })),
    showCategory,
    { label: t("view.software.title"), className: "nav-list soft-layout__nav" },
  );

  layout.append(nav.root, pane);
  showCategory(cats[0].id);
  return layout;
}
