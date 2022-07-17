# Eigene Basis-Funktion
function Find-StringInFile{
    param (
        [String]$FilePath,
        [String]$SearchString
    )

    $SearchString = "*" + $SearchString + "*"
    $return = @()
    foreach ($line in (Get-Content $Filepath)) {
        if($line -like $SearchString){
            $return += $line
        }
    }
    return $return
}
Find-StringInFile -FilePath "C:\Code\Heise\heise_loganalytics\assets\SampleLogCreator\log.log" -SearchString "Failed password for admin"


# Select-String
# Bulk-Search:
# Select-String
# Bulk-Search:
(Select-String -Path "./random_log.log" -Pattern "Failed password for illegal user").count
Select-String -Path "./random_log.log" -Pattern "Failed password for illegal user", "Could not get shadow"
Select-String -Path "./random_log.log" -Pattern "Failed password for illegal user", "Could not get shadow" | Select-Object FileName, Pattern, Line


# Regex:
Select-String -Path "C:\Code\Heise\heise_loganalytics\assets\1.log" -Pattern '^(.+)@(.+)$'

# Context:
Select-String -Path "./random_log.log" -Pattern "Failed password for illegal user" -Context 2 | Select-Object -First 1



