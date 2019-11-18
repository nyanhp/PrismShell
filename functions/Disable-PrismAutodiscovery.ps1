<#
.SYNOPSIS
    Disables auto-discovery
.DESCRIPTION
    Disables printer auto-discovery
#>
function Disable-PrismAutodiscovery
{
    [CmdletBinding()]
    param ( )

    Set-PSFConfig -Module PrismShell -Name AutoDiscovery.Enabled -Value $false -PassThru | Register-PSFConfig
}
