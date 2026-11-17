import { BrowserWindow, Menu, type MenuItemConstructorOptions } from "electron";

/**
 * Native menu — Arquivo + Sobre only (no Edit / View / Window / Help chrome).
 * Sobre opens the in-app Sobre view via IPC.
 */
export function installAppMenu(): void {
  const template: MenuItemConstructorOptions[] = [
    {
      label: "Arquivo",
      submenu: [{ role: "quit", label: "Sair" }],
    },
    {
      label: "Sobre",
      submenu: [
        {
          label: "Sobre o projeto",
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
