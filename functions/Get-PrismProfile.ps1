<#
.SYNOPSIS
    List all profiles
.DESCRIPTION
    List all printer profiles, optionally filter by ID
.PARAMETER ComputerName
    The host name or IP of your Prism
.PARAMETER Session
    The session to your Prism, autocreated if not provided
.PARAMETER Index
    Integer-based index between 1 and 7 that you want to retrieve
#>
function Get-PrismProfile
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [string]
        $ComputerName,

        [Parameter()]
        [microsoft.powershell.commands.webrequestsession]
        $Session,

        [Parameter()]
        [ValidateRange(1,7)]
        [uint16]
        $Index
    )

    $uri = "http://$ComputerName/user/{0}.conf"

    if ($null -eq $Session)
    {
        $Session = New-PrismSession -ComputerName $ComputerName
    }

    foreach ($i in (1..7))
    {
        if ($Index -and $i -ne $Index) { continue }

        $profileData = Invoke-RestMethod -Uri ($uri -f $i) -Method Get -WebSession $Session
        if ($profileData -is [System.String]) { continue }

        $profileData
    }
}
