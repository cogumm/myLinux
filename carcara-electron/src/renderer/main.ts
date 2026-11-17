import { createLicenseGate } from "./components/license-gate.js";
import { carcaraApi } from "./lib/api.js";
import { resolveLang, setLang } from "./lib/i18n.js";
import { mountApp } from "./app.js";

async function loadLicenseText(): Promise<string> {
  const api = carcaraApi();
  if (api.getLicenseText) {
    return api.getLicenseText();
  }
  const res = await fetch("license.txt");
  if (!res.ok) {
    throw new Error(`license load failed (${res.status})`);
  }
  return res.text();
}

async function boot(): Promise<void> {
  const root = document.getElementById("app");
  if (!root) {
    throw new Error("#app mount point missing");
  }

  const api = carcaraApi();
  if (api.getLang) {
    setLang(resolveLang(await api.getLang()));
  } else {
    setLang(resolveLang(undefined));
  }

  let text: string;
  try {
    text = await loadLicenseText();
  } catch (err) {
    const msg = err instanceof Error ? err.message : String(err);
    root.textContent = msg;
    return;
  }

  const gate = createLicenseGate(text);
  root.replaceChildren(gate.root);
  const accepted = await gate.wait();

  if (!accepted) {
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
