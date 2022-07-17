# Komplexe Texte Parsen

# (Parsing jz zB auch bei Einlesen von CSV -> Komma als Delimiter -> sehr einfache Berechnungen)
# "Auto-Generated Example-Driven Parsing" hingegen viel maechtiger (mittels Template-File!

# ACHTUNG: Erst ab Version 5 möglich!


# Erster Durchgang
$Data = Get-Content "C:\Code\Heise\heise_loganalytics\assets\SampleLogCreator\log2.log"
$ParsingTemplate = @'
{TimeStamp*:2022.04.29 23:05:40} {Type:Warning} ErrorCode: {ErrorCode:9} {Message:Illegal user guest from 218.49.183.17}
{TimeStamp*:2022.04.29 23:05:40} {Type:Warning} ErrorCode: {ErrorCode:9} {Message:error: Could not get shadow information for NOUSER}
'@
$Data = $Data | ConvertFrom-String -TemplateContent $ParsingTemplate

# Datentyp-Problematik
($Data.TimeStamp[0]).GetType()

# Zweiter Druchgang -> Datentypen
$Data = Get-Content "C:\Code\Heise\heise_loganalytics\assets\SampleLogCreator\log3.log"
$ParsingTemplate = @'
{[datetime]TimeStamp*:2022.04.29 23:05:40} {[string]Type:Warning} ErrorCode: {[int]ErrorCode:9} {[string]Message:Illegal user guest from 218.49.183.17}
{[datetime]TimeStamp*:2022.04.29 23:05:40} {[string]Type:Warning} ErrorCode: {[int]ErrorCode:9} {[string]Message:error: Could not get shadow information for NOUSER}
'@
$Data = $Data | ConvertFrom-String -TemplateContent $ParsingTemplate

# Datentyp-Problematik
($Data.TimeStamp[0]).GetType()

