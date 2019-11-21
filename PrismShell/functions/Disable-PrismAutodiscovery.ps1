<#
.SYNOPSIS
    Disables auto-discovery
.DESCRIPTION
    Disables printer auto-discovery
.EXAMPLE
    Disable-PrismAutodiscovery

    Disables the auto discovery setting FOREVER
#>
function Disable-PrismAutodiscovery
{
    [CmdletBinding()]
    param ( )

    Set-PSFConfig -Module PrismShell -Name AutoDiscovery.Enabled -Value $false -PassThru | Register-PSFConfig
}
