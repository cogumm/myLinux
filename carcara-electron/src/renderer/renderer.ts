type HelperResult = {
  code: number | null;
  stdout: string;
  stderr: string;
};

type CarcaraApi = {
  runHelper: (action: string) => Promise<HelperResult>;
};

const VIEW_META: Record<string, { title: string; lede: string }> = {
  sistema: {
    title: "Sistema",
    lede: "Manutenção apt — ações elevadas via helper.",
  },
  software: {
    title: "Software",
    lede: "Instalações curadas (apt → Flatpak → Snap).",
  },
  sobre: {
    title: "Sobre",
    lede: "Carcará 2.0 — painel Electron sobre o motor 1.x.",
  },
};

function carcaraApi(): CarcaraApi {
  return (window as unknown as { carcara: CarcaraApi }).carcara;
}

const logEl = document.getElementById("log") as HTMLPreElement;
const statusEl = document.getElementById("status") as HTMLParagraphElement;
const titleEl = document.getElementById("view-title") as HTMLHeadingElement;
const ledeEl = document.getElementById("view-lede") as HTMLParagraphElement;
const actionButtons = Array.from(
  document.querySelectorAll<HTMLButtonElement>("[data-action]"),
);
const navItems = Array.from(document.querySelectorAll<HTMLButtonElement>(".nav-item"));

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
  actionButtons.forEach((btn) => {
    btn.disabled = busy;
  });
  setStatus(busy ? "Executando…" : "Pronto", busy ? "busy" : "idle");
}

function showView(view: string): void {
  const meta = VIEW_META[view] ?? VIEW_META.sistema;
  titleEl.textContent = meta.title;
  ledeEl.textContent = meta.lede;

  document.querySelectorAll<HTMLElement>(".view").forEach((el) => {
    const match = el.id === `view-${view}`;
    el.hidden = !match;
    el.classList.toggle("is-visible", match);
  });

  navItems.forEach((btn) => {
    const active = btn.dataset.view === view;
    btn.classList.toggle("is-active", active);
    if (active) {
      btn.setAttribute("aria-current", "page");
    } else {
      btn.removeAttribute("aria-current");
    }
  });
}

async function runAction(action: string): Promise<void> {
  setBusy(true);
  logEl.classList.remove("ok", "err");
  appendLog(`\n--- ${action} ---\n`);
  try {
    const result = await carcaraApi().runHelper(action);
    if (result.stdout) appendLog(result.stdout);
    if (result.stderr) appendLog(result.stderr);
    appendLog(`\n[exit ${result.code ?? "null"}]\n`);
    const ok = result.code === 0;
    logEl.classList.add(ok ? "ok" : "err");
    setStatus(ok ? "Concluído" : "Falhou", ok ? "ok" : "err");
  } catch (err) {
    appendLog(`\n[ipc error] ${String(err)}\n`);
    logEl.classList.add("err");
    setStatus("Erro IPC", "err");
  } finally {
    actionButtons.forEach((btn) => {
      btn.disabled = false;
    });
  }
}

navItems.forEach((btn) => {
  btn.addEventListener("click", () => {
    showView(btn.dataset.view ?? "sistema");
  });
});

actionButtons.forEach((btn) => {
  btn.addEventListener("click", () => {
    const action = btn.dataset.action;
    if (!action) return;
    const confirmMsg = btn.dataset.confirm;
    if (confirmMsg && !window.confirm(confirmMsg)) {
      appendLog(`\n--- ${action} cancelado pelo usuário ---\n`);
      return;
    }
    void runAction(action);
  });
});

showView("sistema");
appendLog(
  "Carcará 2.0 pronto. Sistema: Atualizar / Corrigir / Limpar (confirmação na UI).\n",
);
