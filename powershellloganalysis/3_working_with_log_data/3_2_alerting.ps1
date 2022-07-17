# Anlegen ScheduledTask
# Auslesen des Logs und Zwischenspeichern der verwerteten Datetimes
# Bei Fehler/Warning/etc. Alert an Endpoint (Teams-WebHook) -> könnte aber auch InfluxDB/Api/etc. sein
# Wegsichern der verwerteten DateTimes

function Get-LogData {
    $Data = Get-Content "C:\Code\Heise\heise_loganalytics\LogTest\random_log.log"
    $ParsingTemplate = @'
{[datetime]TimeStamp*:2022.04.29 23:05:40} {[string]Type:Warning} ErrorCode: {[int]ErrorCode:9} {[string]Message:Illegal user guest from 218.49.183.17}
{[datetime]TimeStamp*:2022.04.29 23:05:40} {[string]Type:Warning} ErrorCode: {[int]ErrorCode:9} {[string]Message:error: Could not get shadow information for NOUSER}
'@
    [Array]$Data = $Data | ConvertFrom-String -TemplateContent $ParsingTemplate
    return $Data
}
function Filter-LogDataByDates {
    param (
        [datetime]$after,
        [datetime]$before,
        [array]$logdata
    )
    [array]$return = $logdata | Where-Object { $_.TimeStamp -gt $after -and $_.TimeStamp -lt $before }
    return $return
}
function Save-DateTimes {
    param(
        [array]$Data,
        [string]$FilePath
    )

    If ($Data.count -lt 2) {
        return
    }
    $From = ($Data.TimeStamp[0]).ToString("yyyy.MM.dd HH:mm:ss")
    $To = ($Data.TimeStamp[-1]).ToString("yyyy.MM.dd HH:mm:ss")

    If (Test-Path $FilePath) {
        $csv = Import-Csv $FilePath
        $csv.to = $To
        $csv | Export-Csv $FilePath -NoTypeInformation
    }
    else {
        $timestamps = @()
        $ts = New-Object PSCustomObject
        $ts | Add-Member -type NoteProperty -name From -Value $From
        $ts | Add-Member -type NoteProperty -name To -Value $To
        $timestamps += $ts

        $timestamps | Export-Csv $FilePath -NoTypeInformation
    }
}
function Get-NewLogData {
    If (Test-Path "C:\Code\Heise\heise_loganalytics\4_working_with_log_data\logtimestamps.csv") {
        $After = (Import-Csv "C:\Code\Heise\heise_loganalytics\4_working_with_log_data\logtimestamps.csv").To
    }
    Else {
        $After = ((Get-Date).AddDays(-150)).ToString("yyyy.MM.dd HH:mm:ss")
    }
    $To = (Get-Date).ToString("yyyy.MM.dd HH:mm:ss")
    $Data = Filter-LogDataByDates -after $After -before $To -logdata (Get-LogData)
    Save-DateTimes -Data $Data -FilePath "C:\Code\Heise\heise_loganalytics\4_working_with_log_data\logtimestamps.csv"
    return $Data    
}

$NewLogData = Get-NewLogData
$Errors = $NewLogData | Where-Object { $_.Type -eq "Error" }


