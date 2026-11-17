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
          backend: "apt",
        },
        {
          kicker: "Runtime",
          title: "Node toolchain",
          desc: t("desc.nodejs"),
          action: "install-nodejs",
          confirm: t("install.nodejs") + "?",
          backend: "mixed",
          accent: true,
        },
        {
          kicker: "Preset",
          title: "Dev box",
          desc: t("desc.presetDev"),
          action: "preset-dev",
          confirm: t("install.presetDev") + "?",
          backend: "mixed",
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
          backend: "flatpak",
        },
        {
          kicker: "Epic/GOG",
          title: "Heroic",
          desc: t("desc.heroic"),
          action: "install-heroic",
          confirm: t("install.heroic") + "?",
          backend: "flatpak",
        },
        {
          kicker: "Wine",
          title: "Lutris",
          desc: t("desc.lutris"),
          action: "install-lutris",
          confirm: t("install.lutris") + "?",
          backend: "flatpak",
        },
        {
          kicker: "Preset",
          title: "Gaming light",
          desc: t("desc.presetGaming"),
          action: "preset-gaming",
          confirm: t("install.presetGaming") + "?",
          backend: "mixed",
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
          backend: "flatpak",
        },
        {
          kicker: "Msg",
          title: "Telegram",
          desc: t("desc.telegram"),
          action: "install-telegram",
          confirm: t("install.telegram") + "?",
          backend: "flatpak",
        },
        {
          kicker: "Msg",
          title: "WhatsApp",
          desc: t("desc.whatsapp"),
          action: "install-whatsapp",
          confirm: t("install.whatsapp") + "?",
          backend: "flatpak",
        },
        {
          kicker: "Mail",
          title: "Proton Mail",
          desc: t("desc.protonMail"),
          action: "install-proton-mail",
          confirm: t("install.protonMail") + "?",
          backend: "flatpak",
        },
        {
          kicker: "Preset",
          title: "Social box",
          desc: t("desc.presetSocial"),
          action: "preset-social",
          confirm: t("install.presetSocial") + "?",
          backend: "mixed",
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
          backend: "flatpak",
        },
        {
          kicker: "Cards",
          title: "Anki",
          desc: t("desc.anki"),
          action: "install-anki",
          confirm: t("install.anki") + "?",
          backend: "flatpak",
        },
        {
          kicker: "Notes",
          title: "Notion",
          desc: t("desc.notion"),
          action: "install-notion",
          confirm: t("install.notion") + "?",
          backend: "snap",
        },
        {
          kicker: "Mail",
          title: "Thunderbird",
          desc: t("desc.thunderbird"),
          action: "install-thunderbird",
          confirm: t("install.thunderbird") + "?",
          backend: "apt",
        },
        {
          kicker: "Office",
          title: "LibreOffice",
          desc: t("desc.libreoffice"),
          action: "install-libreoffice",
          confirm: t("install.libreoffice") + "?",
          backend: "apt",
          accent: true,
        },
        {
          kicker: "Office",
          title: "OnlyOffice",
          desc: t("desc.onlyoffice"),
          action: "install-onlyoffice",
          confirm: t("install.onlyoffice") + "?",
          backend: "flatpak",
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
          backend: "apt",
        },
        {
          kicker: "Web",
          title: "Brave",
          desc: t("desc.brave"),
          action: "install-brave",
          confirm: t("install.brave") + "?",
          backend: "apt",
        },
        {
          kicker: "Web",
          title: "Vivaldi",
          desc: t("desc.vivaldi"),
          action: "install-vivaldi",
          confirm: t("install.vivaldi") + "?",
          backend: "apt",
        },
        {
          kicker: "Web",
          title: "Opera GX",
          desc: t("desc.opera"),
          action: "install-opera",
          confirm: t("install.opera") + "?",
          backend: "snap",
        },
        {
          kicker: "Web",
          title: "Zen",
          desc: t("desc.zen"),
          action: "install-zen",
          confirm: t("install.zen") + "?",
          backend: "appimage",
        },
        {
          kicker: "VPN",
          title: "Proton VPN",
          desc: t("desc.protonVpn"),
          action: "install-proton-vpn",
          confirm: t("install.protonVpn") + "?",
          backend: "flatpak",
        },
        {
          kicker: "VPN",
          title: "NordVPN",
          desc: t("desc.nordvpn"),
          action: "install-nordvpn",
          confirm: t("install.nordvpn") + "?",
          backend: "snap",
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
      tiles: [
        {
          kicker: "Pass",
          title: "Bitwarden",
          desc: t("desc.bitwarden"),
          action: "install-bitwarden",
          confirm: t("install.bitwarden") + "?",
          backend: "flatpak",
          accent: true,
        },
        {
          kicker: "Pass",
          title: "1Password",
          desc: t("desc.onepassword"),
          action: "install-onepassword",
          confirm: t("install.onepassword") + "?",
          backend: "deb",
        },
      ],
    },
  ];
}

function createEmptyCategory(message?: string): HTMLElement {
  const empty = document.createElement("div");
  empty.className = "soft-empty";
  empty.setAttribute("role", "status");
  empty.textContent = message ?? t("cat.empty");
  return empty;
}

function filterTiles(tiles: TileProps[], query: string): TileProps[] {
  const q = query.trim().toLowerCase();
  if (!q) return tiles;
  return tiles.filter((tile) => {
    const hay = `${tile.title} ${tile.desc ?? ""} ${tile.kicker ?? ""} ${tile.backend ?? ""}`.toLowerCase();
    return hay.includes(q);
  });
}

export function renderSoftware(): HTMLElement {
  const cats = categories();
  const layout = document.createElement("div");
  layout.className = "soft-layout";

  const pane = document.createElement("div");
  pane.className = "soft-layout__pane";
  pane.setAttribute("role", "region");
  pane.setAttribute("aria-label", t("view.software.title"));

  const search = document.createElement("input");
  search.type = "search";
  search.className = "soft-search";
  search.placeholder = t("soft.searchPlaceholder");
  search.setAttribute("aria-label", t("soft.searchAria"));

  type PanelState = {
    root: HTMLElement;
    tiles: TileProps[];
    paged: ReturnType<typeof createPagedTiles> | null;
  };

  const panels = new Map<string, PanelState>();
  let activeId = cats[0]?.id ?? "development";

  for (const cat of cats) {
    const wrap = document.createElement("div");
    wrap.hidden = true;
    wrap.dataset.category = cat.id;
    wrap.className = "soft-cat";

    if (cat.tiles.length === 0) {
      wrap.append(createEmptyCategory());
      panels.set(cat.id, { root: wrap, tiles: [], paged: null });
    } else {
      const paged = createPagedTiles(cat.tiles, { pageSize: SOFTWARE_PAGE_SIZE });
      wrap.append(paged.root);
      panels.set(cat.id, { root: wrap, tiles: cat.tiles, paged });
    }
    pane.append(wrap);
  }

  function applyFilter(): void {
    const state = panels.get(activeId);
    if (!state) return;
    if (state.tiles.length === 0) return;
    const filtered = filterTiles(state.tiles, search.value);
    if (filtered.length === 0) {
      state.root.replaceChildren(createEmptyCategory(t("soft.noMatch")));
      state.paged = null;
      return;
    }
    if (!state.paged) {
      const paged = createPagedTiles(filtered, { pageSize: SOFTWARE_PAGE_SIZE });
      state.root.replaceChildren(paged.root);
      state.paged = paged;
      return;
    }
    state.paged.setTiles(filtered);
  }

  function showCategory(id: string): void {
    activeId = id;
    for (const [catId, state] of panels) {
      state.root.hidden = catId !== id;
    }
    nav.setActive(id);
    applyFilter();
  }

  search.addEventListener("input", () => applyFilter());

  const nav = createNavList(
    cats.map((cat) => ({
      id: cat.id,
      label: t(cat.titleKey),
      iconHtml: icons[cat.icon](),
    })),
    showCategory,
    { label: t("view.software.title"), className: "nav-list soft-layout__nav" },
  );

  const paneStack = document.createElement("div");
  paneStack.className = "soft-layout__stack";
  paneStack.append(search, pane);

  layout.append(nav.root, paneStack);
  showCategory(activeId);
  return layout;
}
