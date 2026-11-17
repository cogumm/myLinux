import { createTile, type TileProps } from "./tile.js";

export function createTileGrid(tiles: TileProps[]): HTMLDivElement {
  const grid = document.createElement("div");
  grid.className = "tile-grid";
  for (const tile of tiles) {
    grid.append(createTile(tile));
  }
  return grid;
}
