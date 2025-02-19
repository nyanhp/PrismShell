﻿<#
.SYNOPSIS
    Discover all or the first/default printer
.DESCRIPTION
    Discover all or the first/default printer
.EXAMPLE
    Get-PrismPrinter

    Lists 0-n Prisms
#>
function Get-PrismPrinter
{
    [CmdletBinding()]
    param ( )

    if (-not (Get-PSFConfigValue -FullName PrismShell.AutoDiscovery.Enabled))
    {
        Write-PSFMessage -String 'FindPrismPrinter.AutoDiscoDisabled'
        return [pscustomobject]@{
            IPAddress = Get-PSFConfigValue -FullName PrismShell.DefaultPrinter.ComputerName
            MACAddress = Get-PSFConfigValue -FullName PrismShell.DefaultPrinter.MacAddress
            Type = 'UserDefault'
        }
    }

    Write-PSFMessage -String 'FindPrismPrinter.AutoDiscoEnabled'
    $filteredArpCache = Get-ArpCache | Where-Object MacAddress -like '10:00:F7*'

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
        $filteredArpCache = $filteredArpCache | Select-Object -First 1
    }

    foreach ($entry in $filteredArpCache)
    {
        $uri = 'http://{0}/version' -f $entry.IPAddress
        $session = New-PrismSession -ComputerName $entry.IPAddress -MacAddress $entry.MacAddress.ToUpper()
        $version = (Invoke-RestMethod -Uri $uri -Method Get -WebSession $session) -as [version]

        if ($null -eq $version) {$version = [version]::new()}

        [PrismPrinter]::new($entry.IPAddress, $entry.MACAddress.ToUpper(), $version)
    }
}
