import { createActivityConsole } from "./components/activity-console.js";
import { createConfirmDialog } from "./components/confirm-dialog.js";
import { createPanel, showPanel } from "./components/panel.js";
import { createRail } from "./components/rail.js";
import { createStageHeader } from "./components/stage-header.js";
import { bindTiles, setTilesDisabled } from "./components/tile.js";
import { carcaraApi } from "./lib/api.js";
import {
  applyDocumentLang,
  persistLang,
  t,
  type Lang,
} from "./lib/i18n.js";
import type { AppContext, ViewId } from "./lib/types.js";
import { APP_VERSION } from "./lib/version.js";
import { getView, views } from "./views/index.js";

export type MountOptions = {
  /** Preserve active view when remounting after a language change. */
  view?: ViewId;
  /** Skip the welcome log line (used on lang remount). */
  quiet?: boolean;
};

export function mountApp(root: HTMLElement, options: MountOptions = {}): void {
  applyDocumentLang();

  let currentView: ViewId = options.view ?? "sistema";

  const skip = document.createElement("a");
  skip.className = "skip-link";
  skip.href = "#main";
  skip.textContent = t("skip.link");

  const shell = document.createElement("div");
  shell.className = "shell";

  const stage = document.createElement("div");
  stage.className = "stage";

  const header = createStageHeader();
  const main = document.createElement("main");
  main.id = "main";
  main.className = "stage__body";

  const panels = new Map<ViewId, HTMLElement>();
  for (const view of views) {
    const panel = createPanel(view.id, view.render(), view.id === currentView);
    panels.set(view.id, panel);
    main.append(panel);
  }

  const console = createActivityConsole(() => {
    header.setStatus(t("status.ready"), "idle");
  });
  const dialog = createConfirmDialog();

  const ctx: AppContext = {
    appendLog: (text) => console.append(text),
    setStatus: (text, kind) => header.setStatus(text, kind),
    setBusy: (busy) => setTilesDisabled(main, busy),
    askConfirm: (message) => dialog.ask(message),
    async runAction(action, confirmMsg) {
      if (confirmMsg) {
        const ok = await dialog.ask(confirmMsg);
        if (!ok) {
          header.setStatus(t("status.cancelled"), "idle");
          return;
        }
      }

      ctx.setBusy(true);
      header.setStatus(t("status.busy"), "busy");
      console.append(`$ carcara ${action}\n`, "cmd");

      try {
        const result = await carcaraApi().runHelper(action);
        if (result.stdout) console.append(result.stdout);
        if (result.stderr) console.append(result.stderr, "error");
        const code = result.code ?? 1;
        console.append(`[exit ${code}]\n`);
        if (code === 0) header.setStatus(t("status.ok"), "ok");
        else header.setStatus(`${t("status.err")} (${code})`, "err");
      } catch (err) {
        const msg = err instanceof Error ? err.message : String(err);
        console.append(`[erro] ${msg}\n`, "error");
        header.setStatus(t("status.err"), "err");
      } finally {
        ctx.setBusy(false);
      }
    },
  };

  bindTiles(main, (action, confirm) => {
    void ctx.runAction(action, confirm);
  });

  function navigate(id: ViewId): void {
    currentView = id;
    const view = getView(id);
    header.setMeta(view.getMeta());
    showPanel(panels, id);
    rail.setActive(id);
  }

  function onLangChange(lang: Lang): void {
    persistLang(lang);
    mountApp(root, { view: currentView, quiet: true });
  }

  const rail = createRail(navigate, { onLangChange });

  stage.append(header.root, main, console.root);
  shell.append(rail.root, stage);
  root.replaceChildren(skip, shell, dialog.root);

  header.setStatus(t("status.ready"), "idle");
  navigate(currentView);
  if (!options.quiet) {
    console.append(t("ready.log", { version: APP_VERSION }), "info");
  }

  carcaraApi().onNavigate?.((view) => {
    if (
      view === "sistema" ||
      view === "software" ||
      view === "dotfiles" ||
      view === "sobre"
    ) {
      navigate(view);
    }
  });
}
