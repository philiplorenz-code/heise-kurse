Install-PackageProvider Nuget -Force
Install-Module AutomatedLab -AllowClobber -SkipPublisherCheck
New-LabSourcesFolder -Drive C