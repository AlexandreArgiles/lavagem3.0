Set WshShell = CreateObject("WScript.Shell") 
strPath = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) 
WshShell.CurrentDirectory = strPath 
' Inicia o servidor Node.js invisivel 
WshShell.Run "npm start", 0, False 
' Aguarda 4 segundos para o servidor subir 
WScript.Sleep 4000 
' Abre o navegador 
WshShell.Run "http://localhost:3000" 
