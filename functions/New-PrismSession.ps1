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
        [Parameter()]
        [string]
        $ComputerName = (Get-PrismPrinter),

        [Parameter()]
        [string]
        $MacAddress
    )

    if ([string]::IsNullOrWhiteSpace($MacAddress))
    {
        (Get-ArpCache -ComputerName $ComputerName -ErrorAction Stop).MacAddress.ToUpper()
        return
    }

    Write-PSFMessage -String 'NewPrismSession.CreateAuthCookie' -StringValues $ComputerName, $physAddress
    $cookie = New-Object System.Net.Cookie
    $cookie.name = "Authorization"
    $cookie.path = "/"
    $cookie.value = $MacAddress
    $cookie.domain = $ComputerName
    $cookie.expires = (Get-Date).AddDays(1)
    $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    $session.cookies.add($cookie)
    $session
}
