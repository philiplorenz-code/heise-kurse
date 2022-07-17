# Pipeline einfache Beispiele
Notepad
Get-Process -ProcessName Notepad
Stop-Process -ProcessName Notepad
Get-Process Notepad | Stop-Process

Write-Host "Test"
"Test" | Write-Host

# Datei auslesen
Get-ChildItem "../assets"
Get-ChildItem "../assets" | Where-Object {$_.Extension -eq ".log"} | Get-Content
(Get-ChildItem "../assets" | Where-Object {$_.Extension -eq ".log"} | Get-Content).Count 