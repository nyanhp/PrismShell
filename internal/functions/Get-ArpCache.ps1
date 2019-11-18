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
        $ipAddress = [System.Net.Dns]::GetHostByName($ComputerName).AddressList[0].IPAddressToString
    }

    $cacheText = & (Get-Command -Name arp).Path --% -a

    $cache = foreach ($entry in ($cacheText | Where-Object {$_ -match '^\s*\d'}))
    {
        $ip, $mac, $type = $entry.Trim() -split '\s+'

        [PSCustomObject]@{
            IPAddress    = $ip
            MACAddress   = ($mac -replace '-',':')
            Type         = $type
        }
    }

    if (-not [string]::IsNullOrWhiteSpace($ipAddress))
    {
        return ($cache | Where-Object IPAddress -eq $ipAddress)
    }

    $cache
}
