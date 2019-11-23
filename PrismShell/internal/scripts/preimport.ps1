# Add all things you want to run before importing the main code

# Load the strings used in messages
. Import-ModuleFile -Path "$($script:ModuleRoot)\internal\scripts\strings.ps1"

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
