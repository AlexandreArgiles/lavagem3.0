@echo off
title Instalador SpumaCar (V2.1 - Robust)
color 0b

echo ==========================================
echo   INSTALADOR SPUMACAR v2.1
echo ==========================================
echo.

:: 1. Instalar dependencias
echo [1/4] Verificando dependencias...
call npm install
if %errorlevel% neq 0 (
    color 0c
    echo [ERRO] Falha ao instalar. Verifique se o Node.js esta instalado.
    pause
    exit
)

:: 2. Criar script de INICIALIZACAO INVISIVEL (.vbs)
:: Metodo seguro: escrevendo linha por linha para evitar erros de sintaxe
echo [2/4] Criando script de inicializacao silenciosa...

echo Set WshShell = CreateObject("WScript.Shell") > iniciar.vbs
echo strPath = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) >> iniciar.vbs
echo WshShell.CurrentDirectory = strPath >> iniciar.vbs
echo ' Inicia o servidor Node.js invisivel >> iniciar.vbs
echo WshShell.Run "npm start", 0, False >> iniciar.vbs
echo ' Aguarda 4 segundos para o servidor subir >> iniciar.vbs
echo WScript.Sleep 4000 >> iniciar.vbs
echo ' Abre o navegador >> iniciar.vbs
echo WshShell.Run "http://localhost:3000" >> iniciar.vbs

:: 3. Criar script para PARAR o sistema (.bat)
echo [3/4] Criando script de desligamento...

echo @echo off > parar.bat
echo echo Parando o SpumaCar... >> parar.bat
echo taskkill /F /IM node.exe >> parar.bat
echo timeout /t 2 ^>nul >> parar.bat

:: 4. Criar Atalhos na Area de Trabalho
echo [4/4] Criando atalhos na Area de Trabalho...
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\SpumaCar.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%~dp0iniciar.vbs" >> %SCRIPT%
echo oLink.WorkingDirectory = "%~dp0" >> %SCRIPT%
echo oLink.IconLocation = "%SystemRoot%\system32\SHELL32.dll, 15" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

echo sLinkFile2 = "%USERPROFILE%\Desktop\Parar SpumaCar.lnk" >> %SCRIPT%
echo Set oLink2 = oWS.CreateShortcut(sLinkFile2) >> %SCRIPT%
echo oLink2.TargetPath = "%~dp0parar.bat" >> %SCRIPT%
echo oLink2.WorkingDirectory = "%~dp0" >> %SCRIPT%
echo oLink2.IconLocation = "%SystemRoot%\system32\SHELL32.dll, 27" >> %SCRIPT%
echo oLink2.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%

echo.
echo ==========================================
echo    INSTALACAO CONCLUIDA!
echo ==========================================
echo.
echo Verifique sua Area de Trabalho.
pause