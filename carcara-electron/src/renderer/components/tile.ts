export type TileProps = {
  title: string;
  desc?: string;
  kicker?: string;
  action: string;
  confirm?: string;
  accent?: boolean;
};

export function createTile(props: TileProps): HTMLButtonElement {
  const btn = document.createElement("button");
  btn.type = "button";
  btn.className = props.accent ? "tile tile--accent" : "tile";
  btn.dataset.action = props.action;
  if (props.confirm) btn.dataset.confirm = props.confirm;

  if (props.kicker) {
    const kicker = document.createElement("span");
    kicker.className = "tile__kicker";
    kicker.textContent = props.kicker;
    btn.append(kicker);
  }

  const title = document.createElement("span");
  title.className = "tile__title";
  title.textContent = props.title;
  btn.append(title);

  if (props.desc) {
    const desc = document.createElement("span");
    desc.className = "tile__desc";
    desc.textContent = props.desc;
    btn.append(desc);
  }

  return btn;
}

/**
 * Event delegation so paginated / swapped tile grids keep working without
 * re-binding after each page change.
 */
export function bindTiles(
  root: ParentNode,
  onAction: (action: string, confirm?: string) => void,
): void {
  root.addEventListener("click", (event) => {
    const target = event.target;
    if (!(target instanceof Element)) return;
    const btn = target.closest<HTMLButtonElement>("button[data-action]");
    if (!btn || !root.contains(btn)) return;
    if (btn.disabled) return;
    const action = btn.dataset.action;
    if (!action) return;
    onAction(action, btn.dataset.confirm);
  });
}

export function setTilesDisabled(root: ParentNode, disabled: boolean): void {
  const buttons = Array.from(
    root.querySelectorAll<HTMLButtonElement>("[data-action]"),
  );
  for (const btn of buttons) {
    btn.disabled = disabled;
  }
}
