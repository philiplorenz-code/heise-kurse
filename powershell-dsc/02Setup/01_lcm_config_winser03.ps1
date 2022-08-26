# LCM Config auf Zielserver
# Generelle Einstellungen/Config für DSC auf Node
Configuration LCMConfig {
    # Parameters
    Param([string[]]$ComputerName = "localhost")
    # Target Node
    Node $ComputerName {
        # LCM Resource
        LocalConfigurationManager {
            ConfigurationMode              = "ApplyAndAutoCorrect"
            ConfigurationModeFrequencyMins = 30
        }
    }
}

# MOF erstellen
LCMConfig -ComputerName winser03

# LCM Config auslesen
Get-DscLocalConfigurationManager -CimSession winser03 

# LCMConfig ausrollen
Set-DscLocalConfigurationManager -Path LCMConfig

# LCM Config erneut auslesen
Get-DscLocalConfigurationManager -CimSession winser03