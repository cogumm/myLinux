import type { CarcaraApi } from "./types.js";

export function carcaraApi(): CarcaraApi {
  return (window as unknown as { carcara: CarcaraApi }).carcara;
}

export async function openExternal(url: string): Promise<void> {
  const api = carcaraApi();
  if (api.openExternal) {
    await api.openExternal(url);
    return;
  }
  window.open(url, "_blank", "noopener,noreferrer");
}
