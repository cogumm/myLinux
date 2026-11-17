import type { CarcaraApi } from "./types.js";

export function carcaraApi(): CarcaraApi {
  return (window as unknown as { carcara: CarcaraApi }).carcara;
}
