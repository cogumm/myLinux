import { BrowserWindow, Menu, type MenuItemConstructorOptions } from "electron";
import { readFileSync } from "node:fs";
import path from "node:path";
import { env } from "./env";

function nativeT(key: string): string {
  try {
    const file = path.join(
      __dirname,
      "..",
      "..",
      "locales",
      `${env.CARCARA_LANG}.json`,
    );
    const dict = JSON.parse(readFileSync(file, "utf8")) as Record<string, string>;
    return dict[key] ?? key;
  } catch {
    return key;
  }
}

/**
 * Native menu — File + About only (no Edit / View / Window / Help chrome).
 * About opens the in-app Sobre view via IPC. Labels follow CARCARA_LANG.
 */
export function installAppMenu(): void {
  const template: MenuItemConstructorOptions[] = [
    {
      label: nativeT("native.file"),
      submenu: [{ role: "quit", label: nativeT("native.quit") }],
    },
    {
      label: nativeT("native.about"),
      submenu: [
        {
          label: nativeT("native.aboutItem"),
          click: () => {
            const win =
              BrowserWindow.getFocusedWindow() ??
              BrowserWindow.getAllWindows()[0];
            win?.webContents.send("app:navigate", "sobre");
          },
        },
      ],
    },
  ];

  Menu.setApplicationMenu(Menu.buildFromTemplate(template));
}
