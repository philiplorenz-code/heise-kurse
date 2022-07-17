# CSV bereits logisch formatiert!
# Leerzeichen können nur bedingt von Computer interpretiert werden

$Log = Import-Csv "C:\Code\Heise\heise_loganalytics\assets\csv_log.csv"
$Log | Select-Object date | Sort-Object date

$Log | Where-Object {$_.errorcode -eq 9} | Select-Object date