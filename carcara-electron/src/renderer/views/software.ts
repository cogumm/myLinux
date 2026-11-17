import { createNavList } from "../components/nav-list.js";
import { createPagedTiles } from "../components/paged-tiles.js";
import { icons } from "../components/icons.js";
import { t } from "../lib/i18n.js";
import type { TileProps } from "../components/tile.js";
import type { ViewMeta } from "../lib/types.js";

/** Catalog page size — grows with Wave A/B/C without flooding the pane. */
const SOFTWARE_PAGE_SIZE = 6;

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

/** Snap Store category order (https://snapcraft.io/store). */
function categories(): Category[] {
  return [
    {
      id: "development",
      titleKey: "cat.development",
      icon: "code",
      tiles: [
        {
          kicker: "VCS",
          title: "Git",
          desc: t("desc.git"),
          action: "install-git",
          confirm: t("install.git") + "?",
        },
        {
          kicker: "IDE",
          title: "VS Code",
          desc: t("desc.vscode"),
          action: "install-vscode",
          confirm: t("install.vscode") + "?",
          accent: true,
        },
        {
          kicker: "API",
          title: "Insomnia",
          desc: t("desc.insomnia"),
          action: "install-insomnia",
          confirm: t("install.insomnia") + "?",
        },
        {
          kicker: "Font",
          title: "Fira Code",
          desc: t("desc.firacode"),
          action: "install-firacode",
          confirm: t("install.firacode") + "?",
        },
      ],
    },
    {
      id: "games",
      titleKey: "cat.games",
      icon: "gamepad",
      tiles: [],
    },
    {
      id: "social",
      titleKey: "cat.social",
      icon: "users",
      tiles: [
        {
          kicker: "Chat",
          title: "Discord",
          desc: t("desc.discord"),
          action: "install-discord",
          confirm: t("install.discord") + "?",
        },
        {
          kicker: "Msg",
          title: "Telegram",
          desc: t("desc.telegram"),
          action: "install-telegram",
          confirm: t("install.telegram") + "?",
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
          desc: t("desc.dropbox"),
          action: "install-dropbox",
          confirm: t("install.dropbox") + "?",
        },
      ],
    },
    {
      id: "utilities",
      titleKey: "cat.utilities",
      icon: "wrench",
      tiles: [],
    },
    {
      id: "music-and-audio",
      titleKey: "cat.musicAndAudio",
      icon: "music",
      tiles: [
        {
          kicker: "Stream",
          title: "Spotify",
          desc: t("desc.spotify"),
          action: "install-spotify",
          confirm: t("install.spotify") + "?",
        },
      ],
    },
    {
      id: "art-and-design",
      titleKey: "cat.artAndDesign",
      icon: "palette",
      tiles: [],
    },
    {
      id: "photo-and-video",
      titleKey: "cat.photoAndVideo",
      icon: "camera",
      tiles: [
        {
          kicker: "Player",
          title: "VLC",
          desc: t("desc.vlc"),
          action: "install-vlc",
          confirm: t("install.vlc") + "?",
        },
      ],
    },
    {
      id: "server-and-cloud",
      titleKey: "cat.serverAndCloud",
      icon: "cloud",
      tiles: [
        {
          kicker: "Containers",
          title: "Docker",
          desc: t("desc.docker"),
          action: "install-docker",
          confirm: t("tile.docker.confirm"),
        },
      ],
    },
    {
      id: "books-and-reference",
      titleKey: "cat.booksAndReference",
      icon: "book",
      tiles: [],
    },
    {
      id: "devices-and-iot",
      titleKey: "cat.devicesAndIot",
      icon: "chip",
      tiles: [],
    },
    {
      id: "education",
      titleKey: "cat.education",
      icon: "education",
      tiles: [],
    },
    {
      id: "entertainment",
      titleKey: "cat.entertainment",
      icon: "film",
      tiles: [],
    },
    {
      id: "finance",
      titleKey: "cat.finance",
      icon: "finance",
      tiles: [],
    },
    {
      id: "health-and-fitness",
      titleKey: "cat.healthAndFitness",
      icon: "heart",
      tiles: [],
    },
    {
      id: "news-and-weather",
      titleKey: "cat.newsAndWeather",
      icon: "news",
      tiles: [],
    },
    {
      id: "personalisation",
      titleKey: "cat.personalisation",
      icon: "sparkles",
      tiles: [],
    },
    {
      id: "science",
      titleKey: "cat.science",
      icon: "flask",
      tiles: [],
    },
    {
      id: "security",
      titleKey: "cat.security",
      icon: "shield",
      tiles: [],
    },
  ];
}

function createEmptyCategory(): HTMLElement {
  const empty = document.createElement("div");
  empty.className = "soft-empty";
  empty.setAttribute("role", "status");
  empty.textContent = t("cat.empty");
  return empty;
}

export function renderSoftware(): HTMLElement {
  const cats = categories();
  const layout = document.createElement("div");
  layout.className = "soft-layout";

  const pane = document.createElement("div");
  pane.className = "soft-layout__pane";
  pane.setAttribute("role", "region");
  pane.setAttribute("aria-label", t("view.software.title"));

  const panels = new Map<string, HTMLElement>();
  for (const cat of cats) {
    const panel =
      cat.tiles.length > 0
        ? createPagedTiles(cat.tiles, { pageSize: SOFTWARE_PAGE_SIZE }).root
        : createEmptyCategory();
    panel.hidden = true;
    panel.dataset.category = cat.id;
    panels.set(cat.id, panel);
    pane.append(panel);
  }

  function showCategory(id: string): void {
    for (const [catId, panel] of panels) {
      panel.hidden = catId !== id;
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
