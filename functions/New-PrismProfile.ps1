<#
.SYNOPSIS
    Return a new printer profile
.DESCRIPTION
    Create a new printer profile that can be used with Add-PrismProfile
.PARAMETER Material
    Material, e.g. AwesomeStuff
.PARAMETER BaseCureTime
    Time in seconds for the base layer cure
.PARAMETER CureTime
    Time in seconds for each layer
.PARAMETER RaiseDistance
    The distance the build plate rises after each layer
.EXAMPLE
    New-PrismProfile -Material GoodStuff -BaseCureTime 70 -CureTime 3 -RaiseDistance 5

    Generates a new profile object
#>
function New-PrismProfile
{
    param
    (
        [Parameter(Mandatory)]
        [string]
        $Material,

        [Parameter(Mandatory)]
        [uint16]
        $BaseCureTime,

        [Parameter(Mandatory)]
        [uint16]
        $CureTime,

        [Parameter(Mandatory)]
        [uint16]
        $RaiseDistance
    )

    [PrismProfile]::new($Material, $BaseCureTime, $CureTime, $RaiseDistance)
}
