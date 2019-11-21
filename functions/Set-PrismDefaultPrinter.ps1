<#
.SYNOPSIS
    Set a default printer
.DESCRIPTION
    Set a default printer
.PARAMETER ComputerName
    The host name or IP of your Prism
.PARAMETER MacAddress
    The mac address of the printer
.EXAMPLE
    Set-PrismDefaultPrinter -ComputerName 192.168.2.11 -MacAddress 11:22:33:44:55:66

    Sets a default printer for all other cmdlets
#>
function Set-PrismDefaultPrinter
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [string]
        $ComputerName,

        [Parameter(Mandatory)]
        [string]
        $MacAddress
    )

    Set-PSFConfig -Module PrismShell -Name AutoDiscovery.Enabled -Value $false -PassThru | Register-PSFConfig
    Set-PSFConfig -Module PrismShell -Name DefaultPrinter.ComputerName -Value $ComputerName -PassThru | Register-PSFConfig
    Set-PSFConfig -Module PrismShell -Name DefaultPrinter.MacAddress -Value $MacAddress -PassThru | Register-PSFConfig
}
