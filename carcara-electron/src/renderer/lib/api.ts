import type { CarcaraApi, OpenExternalResult } from "./types.js";

export function carcaraApi(): CarcaraApi {
  return (window as unknown as { carcara: CarcaraApi }).carcara;
}

export async function openExternal(url: string): Promise<OpenExternalResult> {
  const api = carcaraApi();
  if (api.openExternal) {
    return api.openExternal(url);
  }
  window.open(url, "_blank", "noopener,noreferrer");
  return { ok: true };
}
