# Show available OS
Get-LabAvailableOperatingSystem -Path C:\LabSources

# Install Lab and VM
New-LabDefinition -Name MyFirstLab -DefaultVirtualizationEngine HyperV
Add-LabMachineDefinition -Name Win10Test -OperatingSystem 'Windows 10 Pro'
Install-Lab
Show-LabDeploymentSummary

# Notification
Send-ALNotification -Activity 'Installing Software' -Message 'Software being installed..' -Provider Toast,Ifttt

# Install Software to TestLab-VM
Install-LabSoftwarePackage -ComputerName Win10Test -Path $labSources\SoftwarePackages\Notepad++.exe -CommandLine /S

# Copy files to TestLab-VM
Copy-LabFileItem -Path 'C:\LabSources\2Copy' -ComputerName Win10Test -DestinationFolderPath C:\Temp

# Show Labs
Get-Lab -List

# Remove Lab
Remove-Lab MyFirstLab