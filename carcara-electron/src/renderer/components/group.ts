export function createGroup(
  title: string,
  content: HTMLElement,
): HTMLDivElement {
  const group = document.createElement("div");
  group.className = "group";

  const heading = document.createElement("h2");
  heading.className = "group__title";
  heading.textContent = title;

  group.append(heading, content);
  return group;
}

export function createStack(...children: HTMLElement[]): HTMLDivElement {
  const stack = document.createElement("div");
  stack.className = "stack";
  stack.append(...children);
  return stack;
}
