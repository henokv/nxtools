cd artifacts
./Conf.ps1
New-GuestConfigurationPackage -Name Conf -Configuration Conf/localhost.mof -Type AuditAndSet -Force $true
cd ..
