function Install-nxAptPackage
{
    [CmdletBinding()]
    [OutputType([void])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [string[]]
        # Name of the Package fo find in the Cached list of packages. Make sure you update the cache as needed.
        $Name,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        # Specifc Version of a package that you want to find in the Cached list of packages.
        $Version
    )

    begin
    {
        $verbose = $VerbosePreference -ne 'SilentlyContinue' -or ($PSBoundParameters.ContainsKey('Verbose') -and $PSBoundParameters['Verbose'])
    }

    process
    {
        # apt-get install
        $aptGetInstallParams = @('install','--quiet')
        foreach ($packageName in $Name)
        {
            $packageToInstall = $packageName
            if ($PSBoundParameters.ContainsKey('Version'))
            {
                Write-Verbose -Message "Trying to install package '$packageName' at the specified version '$Version'."
                # Overriding $packageToInstall
                $packageToInstall = '{0}={1}' -f $packageName, $Version
            }

            Invoke-NativeCommand -Executable 'apt-get' -Parameters @($aptGetInstallParams+$packageToInstall) -Verbose:$verbose |
            ForEach-Object -Process {
                if ($_ -is [System.Management.Automation.ErrorRecord])
                {
                    Write-Error -Message $_
                }
                else
                {
                    Write-Verbose -Message ($_+"`r").TrimEnd('\+')
                }
            }
        }
    }
}
