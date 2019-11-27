<#
.SYNOPSIS
    Create a new WebRequestSession with the cookie
.DESCRIPTION
    Creates a new WeqRequestSession with the printer's MAC address in the cookie which
    serves as authentication
.PARAMETER ComputerName
    The host name or IP of your Prism
.PARAMETER MacAddress
    The mac address of the printer
.EXAMPLE
    New-PrismSession

    Create a new cookied-up web session to control your prism
#>
function New-PrismSession
{
    param
    (
        [Parameter()]
        [string]
        $ComputerName = (Get-PrismPrinter).IPAddress,

        [Parameter()]
        [string]
        $MacAddress
    )

    $physAddress = if ([string]::IsNullOrWhiteSpace($MacAddress))
    {
        try
        {
            (Get-ArpCache -ComputerName $ComputerName -ErrorAction Stop)[0].MacAddress.ToUpper()
        }
        catch
        {
            Stop-PSFFunction -String NewPrismSession.NoMacAddress -StringValues $ComputerName
        }
    }
    else
    {
        $MacAddress
    }

    Write-PSFMessage -String 'NewPrismSession.CreateAuthCookie' -StringValues $ComputerName, $physAddress
    $cookie = New-Object System.Net.Cookie
    $cookie.name = "Authorization"
    $cookie.path = "/"
    $cookie.value = $physAddress
    $cookie.domain = $ComputerName
    $cookie.expires = (Get-Date).AddDays(1)
    $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    $session.cookies.add($cookie)
    $session
}
