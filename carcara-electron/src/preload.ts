import { contextBridge, ipcRenderer } from "electron";

export type HelperResult = {
  code: number | null;
  stdout: string;
  stderr: string;
};

contextBridge.exposeInMainWorld("carcara", {
  runHelper: (action: string): Promise<HelperResult> =>
    ipcRenderer.invoke("helper:run", action),
  openExternal: (
    url: string,
  ): Promise<{ ok: boolean; error?: string }> =>
    ipcRenderer.invoke("shell:openExternal", url),
});
