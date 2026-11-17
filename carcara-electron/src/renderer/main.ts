import { createLicenseGate } from "./components/license-gate.js";
import { carcaraApi } from "./lib/api.js";
import { mountApp } from "./app.js";

async function loadLicenseText(): Promise<string> {
  const api = carcaraApi();
  if (api.getLicenseText) {
    return api.getLicenseText();
  }
  const res = await fetch("license.txt");
  if (!res.ok) {
    throw new Error(`Não foi possível carregar a licença (${res.status})`);
  }
  return res.text();
}

async function boot(): Promise<void> {
  const root = document.getElementById("app");
  if (!root) {
    throw new Error("#app mount point missing");
  }

  let text: string;
  try {
    text = await loadLicenseText();
  } catch (err) {
    const msg = err instanceof Error ? err.message : String(err);
    root.textContent = `Erro ao carregar licença: ${msg}`;
    return;
  }

  const gate = createLicenseGate(text);
  root.replaceChildren(gate.root);
  const accepted = await gate.wait();

  if (!accepted) {
    const api = carcaraApi();
    if (api.quitApp) {
      await api.quitApp();
    } else {
      window.close();
    }
    return;
  }

  mountApp(root);
}

void boot();
