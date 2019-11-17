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
}
