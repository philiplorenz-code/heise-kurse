# General
$LabName = "TestLab"

# Network
New-LabDefinition -Name $LabName -DefaultVirtualizationEngine HyperV
Add-LabVirtualNetworkDefinition -Name $LabName -AddressSpace 192.168.123.0/24

# Run
Install-Lab
Show-LabDeploymentSummary -Detailed

Get-Lab -List

Remove-Lab TestLab