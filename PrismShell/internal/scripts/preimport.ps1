# Add all things you want to run before importing the main code

# Load the strings used in messages
. Import-ModuleFile -Path "$($script:ModuleRoot)\internal\scripts\strings.ps1"

# Configure validation
Register-PSFConfigValidation -Name MacAddressColon -ScriptBlock {
    param
    (
        [string]
        $MacAddress
    )

    if ([string]::IsNullOrWhiteSpace($MacAddress))
    {
        return [PSCustomObject]@{
            Message = 'Null-value supplied, but allowed'
            Success = $true
            Value = $null
        }
    }

    $res = $MacAddress -match '^([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}$'

    if ($res)
    {
        [PSCustomObject]@{
            Message = '{0} is a valid colon-separated MAC address' -f $MacAddress
            Success = $true
            Value = $MacAddress
        }
    }
    else
    {
        [PSCustomObject]@{
            Message = '{0} is not a valid colon-separated MAC address' -f $MacAddress
            Success = $false
            Value = $matchedValue
        }
    }
}

# Add class definition
class PrismProfile
{
    #{"Material":" ","BaseCureTime": ,"CureTime": ,"RaiseDistance": }
    [string] $Material

    [uint16] $BaseCureTime

    [uint16] $CureTime

    [uint16] $RaiseDistance

    PrismProfile ()
    {

    }

    PrismProfile ([string] $Material, [uint16] $BaseCureTime, [uint16] $CureTime, [uint16] $RaiseDistance)
    {
        $this.Material = $Material
        $this.BaseCureTime = $BaseCureTime
        $this.CureTime = $CureTime
        $this.RaiseDistance = $RaiseDistance
    }

    [string] ToString()
    {
        return ($this | ConvertTo-Json -Compress)
    }
}
