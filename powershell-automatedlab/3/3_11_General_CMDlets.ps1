# Lab importieren - nach Neustart oder in anderer PS-Session:
Import-Lab TestLab

# Status
# https://automatedlab.org/en/latest/AutomatedLab/en-us/Get-LabVMStatus/
Get-LabVMStatus -ComputerName DEMADC01

# Enable Remoting
# https://automatedlab.org/en/latest/AutomatedLab/en-us/Enable-LabVMRemoting/
Enable-LabVMRemoting -ComputerName DEMADC01
Enter-PSSession -ComputerName DEMADC01 -Credential (Get-Credential)


# Remove VM
# https://automatedlab.org/en/latest/AutomatedLab/en-us/Remove-LabVM/
Remove-LabVM -Name DEMAWS01

# Get Snapshot
# https://automatedlab.org/en/latest/AutomatedLab/en-us/Get-LabVMSnapshot/
Get-LabVMSnapshot -ComputerName DEMACL01
Restore-LabVMSnapshot -ComputerName DEMACL01 -SnapshotName "DEMACL01 - (12/17/2021 - 1:55:34 PM)"
Remove-LabVMSnapshot -ComputerName DEMADC01

# Get RDP Files
# https://automatedlab.org/en/latest/AutomatedLab/en-us/Get-LabVMRdpFile/
Get-LabVMRdpFile -UseLocalCredential -All -Path "./"

# Get UpTime
# https://automatedlab.org/en/latest/AutomatedLab/en-us/Get-LabVMUptime/
Get-LabVMUptime -ComputerName DEMADC01

# Install Windows Feature
# https://automatedlab.org/en/latest/AutomatedLab/en-us/Get-LabWindowsFeature/
Get-LabWindowsFeature DEMACL01 -FeatureName RSAT-AD-Tools

# Start VM
# https://automatedlab.org/en/latest/AutomatedLab/en-us/Start-LabVM/
Start-LabVM DC01

# Stop VM
# https://automatedlab.org/en/latest/AutomatedLab/en-us/Stop-LabVM/
Stop-LabVM DC01