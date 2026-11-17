import { highlightLogLine, type LogKind } from "../lib/log-highlight.js";
import { t } from "../lib/i18n.js";

export type ActivityConsoleHandle = {
  root: HTMLElement;
  append: (text: string, kind?: LogKind) => void;
  clear: () => void;
};

export function createActivityConsole(
  onClear?: () => void,
): ActivityConsoleHandle {
  const section = document.createElement("section");
  section.className = "console";
  section.setAttribute("aria-labelledby", "log-title");

  const bar = document.createElement("div");
  bar.className = "console__bar";

  const heading = document.createElement("h2");
  heading.id = "log-title";
  heading.textContent = t("console.title");

  const clearBtn = document.createElement("button");
  clearBtn.type = "button";
  clearBtn.className = "console__clear";
  clearBtn.id = "btn-clear-log";
  clearBtn.setAttribute("aria-label", t("console.clearAria"));
  clearBtn.textContent = t("console.clear");

  const scroll = document.createElement("div");
  scroll.className = "console__scroll";
  scroll.id = "log";
  scroll.tabIndex = 0;
  scroll.setAttribute("role", "log");
  scroll.setAttribute("aria-live", "polite");

  let lineNo = 0;
  let pending = "";

  function addLine(line: string, kind: LogKind): void {
    lineNo += 1;
    const row = document.createElement("div");
    row.className = "console__row";

    const ln = document.createElement("span");
    ln.className = "console__ln";
    ln.textContent = String(lineNo);
    ln.setAttribute("aria-hidden", "true");

    const code = document.createElement("span");
    code.className = "console__code";
    code.innerHTML = highlightLogLine(line, kind);

    row.append(ln, code);
    scroll.append(row);
  }

  function append(text: string, kind: LogKind = "default"): void {
    const chunk = pending + text;
    const parts = chunk.split("\n");
    pending = parts.pop() ?? "";
    for (const line of parts) {
      addLine(line, kind);
    }
    scroll.scrollTop = scroll.scrollHeight;
  }

  function clear(): void {
    scroll.replaceChildren();
    lineNo = 0;
    pending = "";
  }

  clearBtn.addEventListener("click", () => {
    clear();
    onClear?.();
  });

  bar.append(heading, clearBtn);
  section.append(bar, scroll);

  return { root: section, append, clear };
}
