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
.PARAMETER Name
    Resin name
.EXAMPLE
    Get-PrismProfile

    List all profiles
#>
function Get-PrismProfile
{
    [CmdletBinding(DefaultParameterSetName = 'Id')]
    param
    (
        [Parameter()]
        [string]
        $ComputerName = (Get-PrismPrinter).IPAddress,

        [Parameter()]
        [microsoft.powershell.commands.webrequestsession]
        $Session,

        [Parameter(ParameterSetName = 'Id')]
        [ValidateRange(1, 7)]
        [uint16]
        $Index,

        [Parameter(ParameterSetName = 'Name')]
        [string]
        $Name
    )

    $uri = "http://$ComputerName/user/{0}.conf"

    if ($null -eq $Session)
    {
        $Session = New-PrismSession -ComputerName $ComputerName
    }

    foreach ($i in (1..7))
    {
        if ($Index -and $i -ne $Index)
        {
            Write-PSFMessage -String 'GetPrismProfile.FilterIndex' -StringValues $ComputerName, $Index, $i
            continue
        }

        $profileData = Invoke-RestMethod -Uri ($uri -f $i) -Method Get -WebSession $Session

        if (-not [string]::IsNullOrWhiteSpace($Name) -and $profileData.Material -ne $Name)
        {
            continue
        }

        if ($profileData -is [System.String])
        {
            continue
        }

        $profileData
    }
}
