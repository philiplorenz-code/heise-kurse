#Run on the target node
Configuration SetLCMPullMode {
    param([string]$ComputerName,
        [guid]$Guid
    )
    
    Node $ComputerName {
        LocalConfigurationManager {
            ConfigurationID                   = $Guid
            DownloadManagerName                = 'WebDownloadManager'
            RefreshMode                        = 'Pull' 
            RebootNodeIfNeeded                 = $true
            RefreshFrequencyMins               = 30
            ConfigurationModeFrequencyMins     = 30
            ConfigurationMode                  = 'ApplyAndAutoCorrect'
            DownloadManagerCustomData = @{
                ServerUrl                      = 'http://winser.lit.io:8080/PSDSCPullServer.svc/'
                AllowUnsecureConnection        = $true
            }
        }
    }
}

#Create the .MOF meta file for the target node
SetLCMPullMode -ComputerName winser03.lit.io -Guid 0bd8e3c8-950d-42e4-adb3-58295c01490f

#We're essenially turning on pull mode on the target
Set-DscLocalConfigurationManager -Path .\SetLCMPullMode -Verbose

#Forcefully pull update dsc configuration and apply it, check the status
Update-DscConfiguration -Wait -Verbose
Get-DscConfigurationStatus




#####
#Run on the target node
Configuration SetLCMPullMode {
    param([string]$ComputerName,
        [guid]$Guid
    )
    
    Node $ComputerName {
        LocalConfigurationManager {
            ConfigurationID                   = $Guid
            DownloadManagerName                = 'WebDownloadManager'
            RefreshMode                        = 'Pull' 
            RebootNodeIfNeeded                 = $true
            RefreshFrequencyMins               = 30
            ConfigurationModeFrequencyMins     = 30
            ConfigurationMode                  = 'ApplyAndAutoCorrect'
            DownloadManagerCustomData = @{
                ServerUrl                      = 'http://winser02.lit.io:8080/PSDSCPullServer.svc/'
                AllowUnsecureConnection        = $true
            }
        }
    }
}

$cred = Get-Credential

#Create the .MOF meta file for the target node
SetLCMPullMode -ComputerName localhost -Guid 8446db2f-205f-4be5-9d0a-b1e41fedabd0

#We're essenially turning on pull mode on the target
Set-DscLocalConfigurationManager -Path .\SetLCMPullMode -Verbose -Credential $Cred 

#Forcefully pull update dsc configuration and apply it, check the status
Update-DscConfiguration -Wait -Verbose
Get-DscConfigurationStatus
Get-DscConfiguration

Test-DscConfiguration