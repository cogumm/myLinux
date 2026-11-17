import { BrowserWindow, Menu, type MenuItemConstructorOptions } from "electron";
import { nativeT } from "./native-i18n";

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
