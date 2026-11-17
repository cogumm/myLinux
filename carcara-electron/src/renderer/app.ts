import { createActivityConsole } from "./components/activity-console.js";
import { createConfirmDialog } from "./components/confirm-dialog.js";
import { createPanel, showPanel } from "./components/panel.js";
import { createRail } from "./components/rail.js";
import { createStageHeader } from "./components/stage-header.js";
import { bindTiles, setTilesDisabled } from "./components/tile.js";
import { carcaraApi } from "./lib/api.js";
import type { AppContext, ViewId } from "./lib/types.js";
import { getView, views } from "./views/index.js";

export function mountApp(root: HTMLElement): void {
  const skip = document.createElement("a");
  skip.className = "skip-link";
  skip.href = "#main";
  skip.textContent = "Ir ao conteúdo";

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
    const panel = createPanel(view.id, view.render(), view.id === "sistema");
    panels.set(view.id, panel);
    main.append(panel);
  }

  const console = createActivityConsole(() => {
    header.setStatus("Pronto", "idle");
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
          header.setStatus("Cancelado", "idle");
          return;
        }
      }

      ctx.setBusy(true);
      header.setStatus("Executando…", "busy");
      console.append(`$ carcara ${action}\n`, "cmd");

      try {
        const result = await carcaraApi().runHelper(action);
        if (result.stdout) console.append(result.stdout);
        if (result.stderr) console.append(result.stderr, "error");
        const code = result.code ?? 1;
        console.append(`[exit ${code}]\n`);
        if (code === 0) header.setStatus("Concluído", "ok");
        else header.setStatus(`Falhou (${code})`, "err");
      } catch (err) {
        const msg = err instanceof Error ? err.message : String(err);
        console.append(`[erro] ${msg}\n`, "error");
        header.setStatus("Erro", "err");
      } finally {
        ctx.setBusy(false);
      }
    },
  };

  bindTiles(main, (action, confirm) => {
    void ctx.runAction(action, confirm);
  });

  function navigate(id: ViewId): void {
    const view = getView(id);
    header.setMeta(view.meta);
    showPanel(panels, id);
    rail.setActive(id);
  }

  const rail = createRail(navigate);

  stage.append(header.root, main, console.root);
  shell.append(rail.root, stage);
  root.replaceChildren(skip, shell, dialog.root);

  navigate("sistema");
  console.append("Carcará 2.0 pronto.\n", "info");

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
