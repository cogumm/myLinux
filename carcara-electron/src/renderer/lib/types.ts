export type HelperResult = {
  code: number | null;
  stdout: string;
  stderr: string;
};

export type OpenExternalResult = { ok: boolean; error?: string };

export type CarcaraApi = {
  runHelper: (action: string) => Promise<HelperResult>;
  openExternal?: (url: string) => Promise<OpenExternalResult>;
  onNavigate?: (callback: (view: string) => void) => void;
  getLicenseText?: () => Promise<string>;
  quitApp?: () => Promise<void>;
};

export type StatusKind = "idle" | "busy" | "ok" | "err";

export type ViewId = "sistema" | "software" | "dotfiles" | "sobre";

export type ViewMeta = {
  eyebrow: string;
  title: string;
  lede: string;
};

export type AppContext = {
  runAction: (action: string, confirmMsg?: string) => Promise<void>;
  appendLog: (text: string, kind?: "default" | "info" | "error" | "cmd") => void;
  setStatus: (text: string, kind: StatusKind) => void;
  setBusy: (busy: boolean) => void;
  askConfirm: (message: string) => Promise<boolean>;
};
