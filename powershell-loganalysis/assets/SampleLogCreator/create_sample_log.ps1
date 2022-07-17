function Write-Log {
    param (
        [Parameter(Mandatory=$true)]
        [String]$Path,

        [ValidateSet('Error','Info','Warning')] 
        [String]$Type,

        [Parameter(Mandatory=$true)]
        [String]$Message,

        [Parameter(Mandatory=$true)]
        [DateTime]$TimeStamp,

        [Parameter(Mandatory=$true)]
        [Int32]$ErrorCode
    )

    begin{
        if([string]::IsNullOrWhiteSpace($Type)) {
            $Type = "Info"
        }
    }

    process{
        Write-Host $Path
        [string]$TimeStamp = $TimeStamp.ToString("yyyy/MM/dd HH:mm:ss")
        $Output = $TimeStamp + " " + $Type + " ErrorCode: " + $ErrorCode + " " + $Message
        $Output | Out-File -Append -FilePath $Path
    }
    
    
}
# Write-Log -Type "Info" -Message "AAH" -TimeStamp (Get-Date) -ErrorCode 12 -Path "./logile.log"

function Create-RandomLog {
    param (
        [Parameter(Mandatory=$true)]
        [String]$Path
    )
    [Array]$Types = ("Info", "Warning", "Error")
    [Array]$Messages = Get-Content "C:\Code\Heise\heise_loganalytics\assets\SampleLogCreator\LogMessages.txt"
    [Array]$ErrorCodes = (2,3,4,5,6,7,8,9)

    $Type = Get-RandomFromArray -array $Types
    $Message = Get-RandomFromArray -array $Messages
    $ErrorCode = Get-RandomFromArray -array $ErrorCodes
    $TimeStamp = Get-Date
    $Path = $Path

    Write-Log -Type $Type -Message $Message -TimeStamp $TimeStamp -ErrorCode $ErrorCode -Path $Path

}

function Get-RandomFromArray {
    param (
        [Array]$array
    )
    $count = $array.Count
    $rand = Get-Random -Minimum 0 -Maximum $count
    return $array[$rand]
}

for ($i = 0; $i -lt 1000; $i++){
    Create-RandomLog -Path "C:\Code\Heise\heise_loganalytics\assets\SampleLogCreator\log3.log"
    Start-Sleep 10
}