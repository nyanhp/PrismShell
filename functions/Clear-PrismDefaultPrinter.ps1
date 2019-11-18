<#
.SYNOPSIS
    Remove the default printer
.DESCRIPTION
    Remove the default printer, e.g. to start using auto discovery
.EXAMPLE
    Clear-PrismDefaultPrinter

    Removes default host name and MAC address setting
#>
function Clear-PrismDefaultPrinter
{
    [CmdletBinding()]
    param ()

    Unregister-PSFConfig -Module PrismShell -Name DefaultPrinter.ComputerName
    Unregister-PSFConfig -Module PrismShell -Name DefaultPrinter.MacAddress
    Set-PSFConfig -Module PrismShell -Name DefaultPrinter.ComputerName -Value $null
    Set-PSFConfig -Module PrismShell -Name DefaultPrinter.MacAddress -Value $null
}
