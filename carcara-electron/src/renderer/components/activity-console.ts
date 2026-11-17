export type ActivityConsoleHandle = {
  root: HTMLElement;
  append: (text: string) => void;
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
  heading.textContent = "Atividade";

  const clearBtn = document.createElement("button");
  clearBtn.type = "button";
  clearBtn.className = "ghost";
  clearBtn.id = "btn-clear-log";
  clearBtn.setAttribute("aria-label", "Limpar log");
  clearBtn.textContent = "Limpar";

  const out = document.createElement("pre");
  out.id = "log";
  out.className = "console__out";
  out.tabIndex = 0;

  clearBtn.addEventListener("click", () => {
    out.textContent = "";
    onClear?.();
  });

  bar.append(heading, clearBtn);
  section.append(bar, out);

  return {
    root: section,
    append(text) {
      out.textContent += text;
      out.scrollTop = out.scrollHeight;
    },
    clear() {
      out.textContent = "";
    },
  };
}
