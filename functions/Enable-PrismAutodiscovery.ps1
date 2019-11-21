<#
.SYNOPSIS
    Enable printer auto-discovery
.DESCRIPTION
    Enable printer auto-discovery
.PARAMETER DoNotUseFirstPrinter
    If not specified, the first discovered printer will be used.
.EXAMPLE
    Enable-PrismAutodiscovery

    Configures two PSFramework settings to enable auto discovery FOREVER
#>
function Enable-PrismAutodiscovery
{
    [CmdletBinding()]
    param
    (
        [switch]
        $DoNotUseFirstPrinter
    )

    Set-PSFConfig -Module PrismShell -Name AutoDiscovery.Enabled -Value $true -PassThru | Register-PSFConfig
    Set-PSFConfig -Module PrismShell -Name AutoDiscovery.UseFirstPrinter -Value (-not $DoNotUseFirstPrinter.IsPresent) -PassThru | Register-PSFConfig
}
