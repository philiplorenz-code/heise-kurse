# Mehrere Logfiles in Speicher laden
Get-Content "assets\1.log", "assets\2.log"
Get-Content "assets\SampleLogCreator\log.log", "assets\SampleLogCreator\log2.log"

# LogFiles in neue Datei mergen
Get-Content "assets\SampleLogCreator\log.log", "assets\SampleLogCreator\log2.log" | Set-Content "./newlog.log"

# LogFiles dynamisch importieren
Get-Content "./*.log"
Get-Content "./1_*.log"
$MergedLogs = Get-Content "./1_*.log"
