import type { ViewId, ViewMeta } from "../lib/types.js";
import { getSistemaMeta, renderSistema } from "./sistema.js";
import { getSoftwareMeta, renderSoftware } from "./software.js";
import { getDotfilesMeta, renderDotfiles } from "./dotfiles.js";
import { getSobreMeta, renderSobre } from "./sobre.js";

export type ViewModule = {
  id: ViewId;
  getMeta: () => ViewMeta;
  render: () => HTMLElement;
};

export const views: ViewModule[] = [
  { id: "sistema", getMeta: getSistemaMeta, render: renderSistema },
  { id: "software", getMeta: getSoftwareMeta, render: renderSoftware },
  { id: "dotfiles", getMeta: getDotfilesMeta, render: renderDotfiles },
  { id: "sobre", getMeta: getSobreMeta, render: renderSobre },
];

export function getView(id: ViewId): ViewModule {
  return views.find((v) => v.id === id) ?? views[0];
}
