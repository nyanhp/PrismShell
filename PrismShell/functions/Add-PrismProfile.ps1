<#
.SYNOPSIS
    Add a new resin profile
.DESCRIPTION
    CURRENTLY NOT WORKING
    This Cmdlet adds a resin profile to the index of available profiles (1-7).
.PARAMETER ComputerName
    The host name or IP of your Prism
.PARAMETER Session
    The session to your Prism, autocreated if not provided
.PARAMETER Index
    The integer-based index between 1 and 7 to the resin profile
.PARAMETER PrismProfile
    The profile generated with New-PrismProfile
.PARAMETER Material
    Material, e.g. AwesomeStuff
.PARAMETER BaseCureTime
    Time in seconds for the base layer cure
.PARAMETER CureTime
    Time in seconds for each layer
.PARAMETER RaiseDistance
    The distance the build plate rises after each layer
.PARAMETER Force
    Overwrite existing profiles
.EXAMPLE
    Add-PrismProfile -Index 4 -Material GoodStuff -BaseCureTime 70 -CureTime 3 -RaiseDistance 5

    Adds a new profile to the default printer
#>
function Add-PrismProfile
{
    [CmdletBinding()]
    param
    (
        [Parameter()]
        [string]
        $ComputerName = (Get-PrismPrinter),

        [Parameter()]
        [microsoft.powershell.commands.webrequestsession]
        $Session,

        [Parameter(Mandatory)]
        [ValidateRange(1,7)]
        [uint16]
        $Index,

        [Parameter(Mandatory, ParameterSetName = 'ByProfile')]
        [PrismProfile]
        $PrismProfile,

        [Parameter(Mandatory, ParameterSetName = 'Direct')]
        [string]
        $Material,

        [Parameter(Mandatory, ParameterSetName = 'Direct')]
        [uint16]
        $BaseCureTime,

        [Parameter(Mandatory, ParameterSetName = 'Direct')]
        [uint16]
        $CureTime,

        [Parameter(Mandatory, ParameterSetName = 'Direct')]
        [uint16]
        $RaiseDistance,

        [switch]
        $Force
    )

    if (-not $Force.IsPresent)
    {
        Stop-PSFFunction -String AddPrismProfile.NotImplemented
    }

    $uri = "http://$ComputerName/resin{0}.conf" -f $Index

    if ($null -eq $Session)
    {
        $Session = New-PrismSession -ComputerName $ComputerName
    }

    if ($null -ne (Get-PrismProfile -ComputerName $ComputerName -Session $Session -Index $Index) -and -not $Force.IsPresent)
    {
        Stop-PSFFunction -String 'AddPrismProfile.ProfileExistsError' -StringValues $Index,$ComputerName
    }

    if ($null -eq $PrismProfile)
    {
        $PrismProfile = New-PrismProfile -Material $Material -BaseCureTime $BaseCureTime -CureTime $CureTime -RaiseDistance $RaiseDistance
    }

    # This needs some work. Printer acknowledges with OK, but doesn't do it
    $session.Headers.Add("Content-Length", $prismJson.Length)
    $session.Headers.Add("X-Requested-With", "XMLHttpRequest")
    $session.Headers.Add("Content-Type", "text/xml-external-parsed-entity")
    $session.Headers.Add("Accept-Encoding", "gzip, deflate")
    $session.Headers.Add("Accept-Language", "en-US,en;q=0.9")
    $null = Invoke-RestMethod -Uri $uri -WebSession $session -Body $PrismProfile.ToString() -Method Post
}
