<#
.SYNOPSIS
    Create a new WebRequestSession with the cookie
.DESCRIPTION
    Creates a new WeqRequestSession with the printer's MAC address in the cookie which
    serves as authentication
.PARAMETER ComputerName
    The host name or IP of your Prism
#>
function New-PrismSession
{
    param
    (
        [Parameter(Mandatory)]
        [string]
        $ComputerName
    )

    $cookie = New-Object System.Net.Cookie
    $cookie.name = "Authorization"
    $cookie.path = "/"
    $cookie.value = (Get-ArpCache -ComputerName $ComputerName).MacAddress.ToUpper()
    $cookie.domain = $ComputerName
    $cookie.expires = (Get-Date).AddDays(1)
    $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    $session.cookies.add($cookie)
    $session
}
