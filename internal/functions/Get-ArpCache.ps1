function Get-ArpCache
{
    param
    (
        [Parameter()]
        [string]
        $ComputerName
    )

    if (-not [string]::IsNullOrWhiteSpace($ComputerName))
    {
        try
        {
            $ipAddress = [System.Net.Dns]::GetHostByName($ComputerName).AddressList[0].IPAddressToString
        }
        catch
        {
            Stop-PSFFunction -EnableException $true -String GetArpCache.DnsLookupFailed -StringValues $ComputerName -Cmdlet $PSCmdlet -Exception $_.Exception
        }
    }

    $cacheText = & (Get-Command -Name arp).Path --% -a

    $cache = foreach ($entry in ($cacheText | Where-Object {$_ -match '^\s*\d'}))
    {
        Write-PSFMessage -String 'GetArpCache.AddingEntry' -StringValues $entry
        $ip, $mac, $type = $entry.Trim() -split '\s+'

        [PSCustomObject]@{
            IPAddress    = $ip
            MACAddress   = ($mac -replace '-',':')
            Type         = $type
        }
    }

    if (-not [string]::IsNullOrWhiteSpace($ipAddress))
    {
        Write-PSFMessage -String 'GetArpCache.Filtering' -StringValues $ipAddress
        return ($cache | Where-Object IPAddress -eq $ipAddress)
    }

    $cache
}
