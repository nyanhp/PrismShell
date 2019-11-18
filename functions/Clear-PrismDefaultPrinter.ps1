function Clear-PrismDefaultPrinter
{
    [CmdletBinding()]
    param ()

    Unregister-PSFConfig -Module PrismShell -Name DefaultPrinter.ComputerName
    Unregister-PSFConfig -Module PrismShell -Name DefaultPrinter.MacAddress
    Set-PSFConfig -Module PrismShell -Name DefaultPrinter.ComputerName -Value $null
    Set-PSFConfig -Module PrismShell -Name DefaultPrinter.MacAddress -Value $null
}
