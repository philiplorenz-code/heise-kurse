Configuration WinSer04 {

    # Computername (wenn nichts angegeben, dann localhost)
    Param(
        [string[]]$ComputerName = "localhost"
    )

    # DSC Moduled
    Import-DscResource -ModuleName NetworkingDsc
    Import-DscResource -ModuleName ComputerManagementDsc
    Import-DscResource -ModuleName xPSDesiredStateConfiguration

    # Node
    Node $ComputerName {

        # Service soll gestartet sein
        Service PrintSpooler {
            Name  = 'TeamViewer'
            State = 'Running'
        }


        # Network
        IPAddress NewIPv4Address
        {
            IPAddress      = '192.168.179.123'
            InterfaceAlias = 'Ethernet Instance 0'
            AddressFamily  = 'IPV4'
        }

        DefaultGatewayAddress SetDefaultGateway
        {
            Address        = '192.168.179.1'
            InterfaceAlias = 'Ethernet Instance 0'
            AddressFamily  = 'IPv4'
        }

        DnsServerAddress DnsServerAddress
        {
            Address        = '192.168.179.87'
            InterfaceAlias = 'Ethernet Instance 0'
            AddressFamily  = 'IPv4'
            Validate       = $true
        }

        Firewall AddFirewallRule
        {
            Name                  = 'AnyAny'
            DisplayName           = 'AnyAnyOB'
            Ensure                = 'Present'
            Enabled               = 'True'
            Profile               = ('Domain', 'Private', 'Public')
            Direction             = 'OutBound'
            Protocol              = 'TCP'
            Description           = 'AnyAny'
        }

        HostsFile HostsFileAddEntry
        {
            HostName  = 'test'
            IPAddress = '192.168.179.87'
            Ensure    = 'Present'
        }

        # Computer Management
        PowerShellExecutionPolicy ExecutionPolicy
        {
            ExecutionPolicyScope = 'LocalMachine'
            ExecutionPolicy      = 'Unrestricted'
        }

        IEEnhancedSecurityConfiguration 'DisableForAdministrators'
        {
            Role    = 'Administrators'
            Enabled = $false
        }

        # xPSDSC
        xWindowsFeature AddFeature
        {
            Name                 = "Web-Server"
            Ensure               = 'Present'
            IncludeAllSubFeature = $true
        }

        xRemoteFile DownloadFile
        {
            DestinationPath = "C:\Temp\sample.png"
            Uri             = 'https://upload.wikimedia.org/wikipedia/commons/2/2f/PowerShell_5.0_icon.png'
            UserAgent       = [Microsoft.PowerShell.Commands.PSUserAgent]::InternetExplorer
            Headers         =  @{'Accept-Language' = 'en-US'}
        }

        


    }
}

#3: Generate .mof file
WinSer04 -Computername winser04.lit.io


#4: Copy .mof files to the DSC configuration location
#$Guid = [guid]::NewGuid()
#$Guid = New-Guid | Select-Object -ExpandProperty Guid
$Guid = "572421a0-4d6f-43b7-a98c-8ea87d7e0172"
$SourceMof = 'C:\Code\Heise\heise_dsc\WinSer04\winser04.lit.io.mof'
$DestinationMof = "C:\Program Files (x86)\WindowsPowerShell\DscServer\Configuration\$Guid.mof"
Copy-Item $SourceMof $DestinationMof
New-DscChecksum $DestinationMof -Force

