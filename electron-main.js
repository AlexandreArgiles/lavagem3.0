const { app, BrowserWindow } = require('electron');
const path = require('path');

app.disableHardwareAcceleration();

require('./server.js');

const { app, BrowserWindow } = require('electron');
const path = require('path');

// Força o Windows a chamar o programa de "SpumaCar" nas notificações
app.setAppUserModelId("SpumaCar");

app.disableHardwareAcceleration();

require('./server.js');

let mainWindow;

function createWindow() {
    mainWindow = new BrowserWindow({
        width: 1280,
        height: 800,
        minWidth: 900,
        minHeight: 600,
        // Removi o autoHideMenuBar e usei o setMenu(null) abaixo
        icon: path.join(__dirname, 'public/favicon.ico'), 
        webPreferences: {
            nodeIntegration: false,
            contextIsolation: true
        }
    });

    // 1. ARRANCANDO O MENU PELA RAIZ (Evita que a tecla ALT roube o teclado)
    mainWindow.setMenu(null);

    setTimeout(() => {
        mainWindow.loadURL('http://localhost:3000');
        
    }, 1000);

    mainWindow.on('closed', function () {
        mainWindow = null;
    });
}

app.whenReady().then(() => {
    createWindow();

    app.on('activate', function () {
        if (BrowserWindow.getAllWindows().length === 0) createWindow();
    });
});

app.on('window-all-closed', function () {
    if (process.platform !== 'darwin') app.quit();
});