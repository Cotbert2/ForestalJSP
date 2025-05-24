// main.js
const { app, BrowserWindow,Menu,dialog } = require('electron');
const path = require('path');

function createWindow() {
  const win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false
    }
  });

  win.loadFile('./public/index.html');
  const menuTemplate = [
    {
      label: 'App',
      submenu: [
        {
          label: 'About developer',
          click: () => {
            dialog.showMessageBox(win, {
              type: 'info',
              title: 'Dev Info',
              message: 'Developed by Team 3\nClient SOAP for Forestal JSO Project\nVersión 1.0',
              buttons: ['OK']
            });
          }
        },
        {
          label: 'Quit',
          accelerator: 'CmdOrCtrl+Q',
          click: () => {
            app.quit();
          }
        }
      ]
    }
  ];
  const menu = Menu.buildFromTemplate(menuTemplate);
  Menu.setApplicationMenu(menu);
  // win.webContents.openDevTools();
}

app.whenReady().then(createWindow);
