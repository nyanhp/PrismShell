function Get-PrismPrinter
{
    [CmdletBinding()]
    param ( )

    if (-not (Get-PSFConfigValue -FullName PrismShell.AutoDiscovery.Enabled))
    {
        Write-PSFMessage -String 'FindPrismPrinter.AutoDiscoDisabled'
        return (Get-PSFConfigValue -FullName PrismShell.DefaultPrinter)
    }

    Write-PSFMessage -String 'FindPrismPrinter.AutoDiscoEnabled'
    $filteredArpCache = Get-ArpCache | Where-Object MacAddress -like '00-11-22'

    if ($filteredArpCache.Count -eq 0)
    {
        Stop-PSFFunction -String 'FindPrismPrinter.HashtagSad'
    }

    if ($filteredArpCache.Count -gt 1 -and -not (Get-PSFConfigValue -FullName PrismShell.AutoDiscovery.UseFirstPrinter))
    {
        Write-PSFMessage -String 'FindPrismPrinter.MultiplePrintersFound' -Level Warning
    }

    if (Get-PSFConfigValue -FullName PrismShell.AutoDiscovery.UseFirstPrinter)
    {
        return ($filteredArpCache | Select-Object -First 1)
    }

    $filteredArpCache
}
