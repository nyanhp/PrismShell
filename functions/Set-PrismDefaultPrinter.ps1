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
