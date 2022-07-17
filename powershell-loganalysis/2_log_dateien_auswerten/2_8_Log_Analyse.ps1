# Aus 3_6
$Data = Get-Content "C:\Code\Heise\heise_loganalytics\LogTest\random_log.log"
$ParsingTemplate = @'
{[datetime]TimeStamp*:2022.04.29 23:05:40} {[string]Type:Warning} ErrorCode: {[int]ErrorCode:9} {[string]Message:Illegal user guest from 218.49.183.17}
{[datetime]TimeStamp*:2022.04.29 23:05:40} {[string]Type:Warning} ErrorCode: {[int]ErrorCode:9} {[string]Message:error: Could not get shadow information for NOUSER}
'@
[Array]$Data = $Data | ConvertFrom-String -TemplateContent $ParsingTemplate

$Data | Get-Member | Where-Object {$_.MemberType -eq "NoteProperty"}

# Fehler zählen:
($Data | Where-Object {$_.Type -eq "Error"}).Count

# Auf Zeitraum filtern (letzte 2 Tage)
$TwoDaysAgo = (Get-Date).AddDays(-2)
$Data | Where-Object {$_.TimeStamp -gt $TwoDaysAgo}

# Auf Zeitraum filtern (Datumspezifisch)
function Filter-LogDataByDates {
    param (
        [datetime]$after,
        [datetime]$before,
        [array]$logdata
    )
    [array]$return = $logdata | Where-Object {$_.TimeStamp -gt $after -and $_.TimeStamp -lt $before}
    return $return
}

Filter-LogDataByDates -after "2022.05.20" -before "2022.05.24" -logdata $Data

# Kombination
[array]$FilteredData = Filter-LogDataByDates -after "2022.05.20" -before "2022.05.24" -logdata $Data
[array]$Warning = $FilteredData | Where-Object {$_.Type -eq "Warning"}
$Warning.Count

# Liste neu sortieren
$Data | Sort-Object ErrorCode

# Liste nach Attribut gruppieren
$Data | Sort-Object ErrorCode | Group-Object ErrorCode
