type HelperResult = {
  code: number | null;
  stdout: string;
  stderr: string;
};

type CarcaraApi = {
  runHelper: (action: string) => Promise<HelperResult>;
};

const VIEW_META: Record<
  string,
  { eyebrow: string; title: string; lede: string }
> = {
  sistema: {
    eyebrow: "Manutenção",
    title: "Sistema",
    lede: "Atualizar, corrigir e limpar via helper privilegiado.",
  },
  software: {
    eyebrow: "Catálogo",
    title: "Software",
    lede: "Instalações curadas — apt → Flatpak → Snap.",
  },
  sobre: {
    eyebrow: "Identidade",
    title: "Sobre",
    lede: "Carcará 2.0 — painel Electron sobre o motor 1.x.",
  },
};

function carcaraApi(): CarcaraApi {
  return (window as unknown as { carcara: CarcaraApi }).carcara;
}

const logEl = document.getElementById("log") as HTMLPreElement;
const statusEl = document.getElementById("status") as HTMLParagraphElement;
const eyebrowEl = document.getElementById("view-eyebrow") as HTMLParagraphElement;
const titleEl = document.getElementById("view-title") as HTMLHeadingElement;
const ledeEl = document.getElementById("view-lede") as HTMLParagraphElement;
const confirmDialog = document.getElementById("confirm-dialog") as HTMLDialogElement;
const confirmText = document.getElementById("confirm-text") as HTMLParagraphElement;
const clearLogBtn = document.getElementById("btn-clear-log") as HTMLButtonElement;

const actionButtons = Array.from(
  document.querySelectorAll<HTMLButtonElement>("[data-action]"),
);
const navItems = Array.from(
  document.querySelectorAll<HTMLButtonElement>(".rail__link"),
);
const panels = Array.from(document.querySelectorAll<HTMLElement>(".panel"));

function appendLog(text: string): void {
  logEl.textContent += text;
  logEl.scrollTop = logEl.scrollHeight;
}

function setStatus(text: string, kind: "idle" | "busy" | "ok" | "err"): void {
  statusEl.textContent = text;
  statusEl.classList.remove("is-busy", "is-ok", "is-err");
  if (kind === "busy") statusEl.classList.add("is-busy");
  if (kind === "ok") statusEl.classList.add("is-ok");
  if (kind === "err") statusEl.classList.add("is-err");
}

function setBusy(busy: boolean): void {
  for (const btn of actionButtons) {
    btn.disabled = busy;
  }
}

function askConfirm(message: string): Promise<boolean> {
  confirmText.textContent = message;
  confirmDialog.showModal();
  return new Promise((resolve) => {
    const onClose = (): void => {
      confirmDialog.removeEventListener("close", onClose);
      resolve(confirmDialog.returnValue === "ok");
    };
    confirmDialog.addEventListener("close", onClose);
  });
}

async function runAction(action: string, confirmMsg?: string): Promise<void> {
  if (confirmMsg) {
    const ok = await askConfirm(confirmMsg);
    if (!ok) {
      setStatus("Cancelado", "idle");
      return;
    }
  }

  setBusy(true);
  setStatus("Executando…", "busy");
  appendLog(`\n$ carcara ${action}\n`);

  try {
    const result = await carcaraApi().runHelper(action);
    if (result.stdout) appendLog(result.stdout);
    if (result.stderr) appendLog(result.stderr);
    const code = result.code ?? 1;
    appendLog(`\n[exit ${code}]\n`);
    if (code === 0) {
      setStatus("Concluído", "ok");
    } else {
      setStatus(`Falhou (${code})`, "err");
    }
  } catch (err) {
    const msg = err instanceof Error ? err.message : String(err);
    appendLog(`\n[erro] ${msg}\n`);
    setStatus("Erro", "err");
  } finally {
    setBusy(false);
  }
}

function showView(view: string): void {
  const meta = VIEW_META[view] ?? VIEW_META.sistema;
  eyebrowEl.textContent = meta.eyebrow;
  titleEl.textContent = meta.title;
  ledeEl.textContent = meta.lede;

  for (const panel of panels) {
    const match = panel.id === `view-${view}`;
    panel.hidden = !match;
    panel.classList.toggle("is-visible", match);
  }

  for (const item of navItems) {
    const active = item.dataset.view === view;
    item.classList.toggle("is-active", active);
    if (active) {
      item.setAttribute("aria-current", "page");
    } else {
      item.removeAttribute("aria-current");
    }
  }
}

for (const item of navItems) {
  item.addEventListener("click", () => {
    const view = item.dataset.view;
    if (view) showView(view);
  });
}

for (const btn of actionButtons) {
  btn.addEventListener("click", () => {
    const action = btn.dataset.action;
    if (!action) return;
    void runAction(action, btn.dataset.confirm);
  });
}

clearLogBtn.addEventListener("click", () => {
  logEl.textContent = "";
  setStatus("Pronto", "idle");
});

showView("sistema");
appendLog("Carcará 2.0 pronto.\n");
