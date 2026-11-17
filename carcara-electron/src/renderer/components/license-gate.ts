import { t } from "../lib/i18n.js";

/**
 * Same policy as Carcará 1.x Zenity --text-info --checkbox="Continuar":
 * user must accept terms before the shell mounts.
 */
export type LicenseGateHandle = {
  root: HTMLElement;
  /** Resolves true if accepted, false if declined. */
  wait: () => Promise<boolean>;
};

export function createLicenseGate(licenseText: string): LicenseGateHandle {
  const root = document.createElement("div");
  root.className = "license-gate";
  root.setAttribute("role", "dialog");
  root.setAttribute("aria-modal", "true");
  root.setAttribute("aria-labelledby", "license-title");

  const card = document.createElement("div");
  card.className = "license-gate__card";

  const title = document.createElement("h1");
  title.id = "license-title";
  title.className = "license-gate__title";
  title.textContent = t("license.title");

  const lede = document.createElement("p");
  lede.className = "license-gate__lede";
  lede.textContent = t("license.lede");

  const pre = document.createElement("pre");
  pre.className = "license-gate__body";
  pre.textContent = licenseText.trimEnd() + "\n";
  pre.tabIndex = 0;

  const checkLabel = document.createElement("label");
  checkLabel.className = "license-gate__check";
  const check = document.createElement("input");
  check.type = "checkbox";
  check.id = "license-accept";
  const checkText = document.createElement("span");
  checkText.textContent = t("license.checkbox");
  checkLabel.append(check, checkText);

  const actions = document.createElement("div");
  actions.className = "license-gate__actions";

  const quit = document.createElement("button");
  quit.type = "button";
  quit.className = "btn";
  quit.textContent = t("license.quit");

  const ok = document.createElement("button");
  ok.type = "button";
  ok.className = "btn btn--accent";
  ok.textContent = t("license.accept");
  ok.disabled = true;

  check.addEventListener("change", () => {
    ok.disabled = !check.checked;
  });

  actions.append(quit, ok);
  card.append(title, lede, pre, checkLabel, actions);
  root.append(card);

  return {
    root,
    wait() {
      return new Promise((resolve) => {
        const finish = (accepted: boolean): void => {
          quit.removeEventListener("click", onQuit);
          ok.removeEventListener("click", onOk);
          resolve(accepted);
        };
        const onQuit = (): void => finish(false);
        const onOk = (): void => {
          if (!check.checked) return;
          finish(true);
        };
        quit.addEventListener("click", onQuit);
        ok.addEventListener("click", onOk);
        check.focus();
      });
    },
  };
}
