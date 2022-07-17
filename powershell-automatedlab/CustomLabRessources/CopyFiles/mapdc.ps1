# Credential
[string]$Username = "Administrator"
[string]$Password = "Password1"
[securestring]$secPass = ConvertTo-SecureString $Password -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential($Username,$secPass)

New-PSDrive -Name U -PSProvider FileSystem -Root \\DEMADC01\C$ -Credential $Cred -Persist