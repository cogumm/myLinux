import type { ViewId, ViewMeta } from "../lib/types.js";
import { renderSistema, sistemaMeta } from "./sistema.js";
import { renderSoftware, softwareMeta } from "./software.js";
import { renderSobre, sobreMeta } from "./sobre.js";

export type ViewModule = {
  id: ViewId;
  meta: ViewMeta;
  render: () => HTMLElement;
};

export const views: ViewModule[] = [
  { id: "sistema", meta: sistemaMeta, render: renderSistema },
  { id: "software", meta: softwareMeta, render: renderSoftware },
  { id: "sobre", meta: sobreMeta, render: renderSobre },
];

export function getView(id: ViewId): ViewModule {
  return views.find((v) => v.id === id) ?? views[0];
}
