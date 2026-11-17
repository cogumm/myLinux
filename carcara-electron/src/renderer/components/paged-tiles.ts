import { createPager } from "./pager.js";
import { createTile, type TileProps } from "./tile.js";

export type PagedTilesOptions = {
  /** Tiles per page (default 6). */
  pageSize?: number;
};

export type PagedTilesHandle = {
  root: HTMLElement;
  /** Replace catalog and reset to page 1. */
  setTiles: (tiles: TileProps[]) => void;
  goToPage: (page: number) => void;
};

/**
 * Tile grid with bottom pager. Hides controls when everything fits on one page.
 * Relies on `bindTiles` event delegation on an ancestor (see `tile.ts`).
 */
export function createPagedTiles(
  tiles: TileProps[],
  options: PagedTilesOptions = {},
): PagedTilesHandle {
  const pageSize = Math.max(1, options.pageSize ?? 6);
  let items = tiles.slice();
  let page = 1;

  const root = document.createElement("div");
  root.className = "paged-tiles";

  const grid = document.createElement("div");
  grid.className = "tile-grid";

  const pager = createPager(
    () => goToPage(page - 1),
    () => goToPage(page + 1),
  );

  root.append(grid, pager.root);

  function pageCount(): number {
    return Math.max(1, Math.ceil(items.length / pageSize));
  }

  function render(): void {
    const total = pageCount();
    if (page > total) page = total;
    if (page < 1) page = 1;

    const start = (page - 1) * pageSize;
    const slice = items.slice(start, start + pageSize);
    grid.replaceChildren(...slice.map((tile) => createTile(tile)));
    pager.setState(page, items.length === 0 ? 1 : total);
  }

  function goToPage(next: number): void {
    const total = pageCount();
    page = Math.min(Math.max(1, next), total);
    render();
  }

  function setTiles(next: TileProps[]): void {
    items = next.slice();
    page = 1;
    render();
  }

  render();
  return { root, setTiles, goToPage };
}
