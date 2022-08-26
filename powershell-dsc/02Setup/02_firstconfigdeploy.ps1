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

    }
}

# MOF erstellen (wird im aktuellen Verzeichnis angelegt)
Spooler -ComputerName winser03

# TODO: Achtung - hier so sprechen, dass Cut möglich
# Config anwenden
Start-DscConfiguration -path Spooler -Wait -Force

# Config ansehen
Get-DscConfiguration -CimSession winser03

# Config testen
Test-DscConfiguration -CimSession winser03

# Config/Doument entfernen
Remove-DscConfigurationDocument -CimSession winser03 -Stage Current