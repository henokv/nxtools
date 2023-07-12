Configuration Conf {
    Import-DscResource -ModuleName 'nxtools'
    nxFile MyFile {
        Ensure = 'Present'
        DestinationPath = '/tmp/myfile'
        # SourcePath = '/tmp/myFileToCopyFrom'
        Type = 'File'
        # Contents = 'Some content I want to manage here.'
        Mode = '0777'
        # Force = $true
        Owner = 'root'
        Group = 'root'
    }

    nxFileLine DoNotRequireTTY
    {
        FilePath = "/tmp/sudoers.1"
        ContainsLine = 'Defaults:monuser !requiretty'
        DoesNotContainPattern = "Defaults:monuser[ ]+requiretty"
    }
  }
  Conf
