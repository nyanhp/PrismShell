class PrismProfile
{
    #{"Material":" ","BaseCureTime": ,"CureTime": ,"RaiseDistance": }
    [string] $Material

    [nullable[uint16]] $BaseCureTime

    [nullable[uint16]] $CureTime

    [nullable[uint16]] $RaiseDistance

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
