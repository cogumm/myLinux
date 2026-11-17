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
  getLicenseText: (): Promise<string> =>
    ipcRenderer.invoke("license:get"),
  getLang: (): Promise<string> => ipcRenderer.invoke("app:lang"),
  quitApp: (): Promise<void> => ipcRenderer.invoke("app:quit"),
  onNavigate: (callback: (view: string) => void): void => {
    ipcRenderer.on("app:navigate", (_event, view: unknown) => {
      if (typeof view === "string") callback(view);
    });
  },
});
