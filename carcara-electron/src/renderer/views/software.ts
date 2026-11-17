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
          kicker: "IDE",
          title: "Cursor",
          desc: t("desc.cursor"),
          action: "install-cursor",
          confirm: t("install.cursor") + "?",
        },
        {
          kicker: "API",
          title: "Insomnia",
          desc: t("desc.insomnia"),
          action: "install-insomnia",
          confirm: t("install.insomnia") + "?",
        },
        {
          kicker: "API",
          title: "Postman",
          desc: t("desc.postman"),
          action: "install-postman",
          confirm: t("install.postman") + "?",
        },
        {
          kicker: "SSH",
          title: "Termius",
          desc: t("desc.termius"),
          action: "install-termius",
          confirm: t("install.termius") + "?",
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
      tiles: [
        {
          kicker: "Store",
          title: "Steam",
          desc: t("desc.steam"),
          action: "install-steam",
          confirm: t("install.steam") + "?",
          accent: true,
        },
        {
          kicker: "Epic/GOG",
          title: "Heroic",
          desc: t("desc.heroic"),
          action: "install-heroic",
          confirm: t("install.heroic") + "?",
        },
        {
          kicker: "Wine",
          title: "Lutris",
          desc: t("desc.lutris"),
          action: "install-lutris",
          confirm: t("install.lutris") + "?",
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
        {
          kicker: "Msg",
          title: "WhatsApp",
          desc: t("desc.whatsapp"),
          action: "install-whatsapp",
          confirm: t("install.whatsapp") + "?",
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
        {
          kicker: "Cards",
          title: "Anki",
          desc: t("desc.anki"),
          action: "install-anki",
          confirm: t("install.anki") + "?",
        },
        {
          kicker: "Notes",
          title: "Notion",
          desc: t("desc.notion"),
          action: "install-notion",
          confirm: t("install.notion") + "?",
        },
        {
          kicker: "Mail",
          title: "Thunderbird",
          desc: t("desc.thunderbird"),
          action: "install-thunderbird",
          confirm: t("install.thunderbird") + "?",
        },
      ],
    },
    {
      id: "utilities",
      titleKey: "cat.utilities",
      icon: "wrench",
      tiles: [
        {
          kicker: "Web",
          title: "Firefox",
          desc: t("desc.firefox"),
          action: "install-firefox",
          confirm: t("install.firefox") + "?",
          accent: true,
        },
        {
          kicker: "Web",
          title: "Brave",
          desc: t("desc.brave"),
          action: "install-brave",
          confirm: t("install.brave") + "?",
        },
        {
          kicker: "Web",
          title: "Vivaldi",
          desc: t("desc.vivaldi"),
          action: "install-vivaldi",
          confirm: t("install.vivaldi") + "?",
        },
        {
          kicker: "Web",
          title: "Opera GX",
          desc: t("desc.opera"),
          action: "install-opera",
          confirm: t("install.opera") + "?",
        },
        {
          kicker: "Web",
          title: "Zen",
          desc: t("desc.zen"),
          action: "install-zen",
          confirm: t("install.zen") + "?",
        },
      ],
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
        {
          kicker: "Edit",
          title: "Audacity",
          desc: t("desc.audacity"),
          action: "install-audacity",
          confirm: t("install.audacity") + "?",
          accent: true,
        },
        {
          kicker: "Server",
          title: "Navidrome",
          desc: t("desc.navidrome"),
          action: "install-navidrome",
          confirm: t("install.navidrome") + "?",
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
        {
          kicker: "Stream",
          title: "OBS Studio",
          desc: t("desc.obs"),
          action: "install-obs",
          confirm: t("install.obs") + "?",
          accent: true,
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
