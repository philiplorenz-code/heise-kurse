Configuration Spooler {

    # Computername (wenn nichts angegeben, dann localhost)
    Param([string[]]$ComputerName = "localhost")

    # Node
    Node $ComputerName {

        # Service soll gestartet sein
        Service PrintSpooler {
            Name = 'Spooler'
            State = 'Running'
        }
        Service Tele {
            Name = 'tapisrv'
            State = 'Running'
        }
        File PackagesFolder 
        { 
            DestinationPath = "C:\package" 
            Type = "Directory" 
            Ensure = "Present" 
        } 

    }
}

#3: Generate .mof file
Spooler -Computername winser03.lit.io

#4: Copy .mof files to the DSC configuration location
#$Guid = [guid]::NewGuid()
#$Guid = New-Guid | Select-Object -ExpandProperty Guid
$Guid = "8446db2f-205f-4be5-9d0a-b1e41fedabd0"
$SourceMof = 'C:\Code\Heise\heise_dsc\Spooler\winser03.lit.io.mof'
$DestinationMof = "C:\Program Files (x86)\WindowsPowerShell\DscServer\Configuration\$Guid.mof"
Copy-Item $SourceMof $DestinationMof
New-DscChecksum $DestinationMof -Force
