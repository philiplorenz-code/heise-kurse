# 2 Möglichkeiten: Auf Zuruf oder ebenfalls scheduled
# LogDaten auslesen und Datenmodell erstellen
# LogDaten in saubere Form bringen (Excel) -> Alternativ auch PowerBI/Dashboardingsoftwar/etc.
# Bereitstellung der Excel-Datei (Mail) -> Alternativ auch OneDrive-Freigabe/Laufwerk

Import-Module ImportExcel


function Get-LogData {
    $Data = Get-Content "C:\Code\Heise\heise_loganalytics\LogTest\random_log.log"
    $ParsingTemplate = @'
{[datetime]TimeStamp*:2022.04.29 23:05:40} {[string]Type:Warning} ErrorCode: {[int]ErrorCode:9} {[string]Message:Illegal user guest from 218.49.183.17}
{[datetime]TimeStamp*:2022.04.29 23:05:40} {[string]Type:Warning} ErrorCode: {[int]ErrorCode:9} {[string]Message:error: Could not get shadow information for NOUSER}
'@
    [Array]$Data = $Data | ConvertFrom-String -TemplateContent $ParsingTemplate
    return $Data
}

# Hier evtl Funktion sinnvoll, mit der man ein gewisses Datum mitgibt - Hinweis, dass wir die Funktion an der Stelle missbrauchen
function Filter-LogDataByDates {
    param (
        [datetime]$after,
        [datetime]$before,
        [array]$logdata
    )
    [array]$return = $logdata | Where-Object {$_.TimeStamp -gt $after -and $_.TimeStamp -lt $before}
    return $return
}

function Get-TodaysLogs {
    $Today = (Get-Date).Date
    $Tomorrow = $Today.AddDays(1)
    Filter-LogDataByDates -after $Today -before $Tomorrow -logdata (Get-LogData)
}

# Excel-Datei erstellen
$TodaysLogs = Get-TodaysLogs
$today = (Get-Date).ToString("dd/MM/yyyy")
$params = @{
    Path = "./log_export.xlsx"
    WorksheetName = $Today
    FreezeTopRow = $true
    IncludePivotTable = $true
    PivotRows = "Type" 
    PivotData = @{"Type"="Count"} 
    IncludePivotChart  = $true
    PivotChartType = "Pie3D"
}
$TodaysLogs | Export-Excel @params

# Mail versenden
$params = @{
    Credential = Get-Credential
    SmtpServer = "smtp-relay.sendinblue.com"
    Port = 587
    UseSsl = $true
    From = "learningit.official@gmail.com"
    To = "philip@learning-it.io"
    Subject = 'Neue Logs'
    Body = 'Neue Logbericht befindet sich im Anhang'
    Attachments = "C:\Code\Heise\heise_loganalytics\log_export.xlsx"
}

Send-MailMessage @params