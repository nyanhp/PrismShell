# Add all things you want to run before importing the main code

# Load the strings used in messages
. Import-ModuleFile -Path "$($script:ModuleRoot)\internal\scripts\strings.ps1"

# Add class definition
class PrismProfile
{
    #{"Material":" ","BaseCureTime": ,"CureTime": ,"RaiseDistance": }
    [string] $Material

    [nullable[uint16]] $BaseCureTime

    [nullable[uint16]] $CureTime

    [nullable[uint16]] $RaiseDistance

    [nullable[uint16]] $Index

    PrismProfile ()
    {

    }

    PrismProfile ([string] $Material, [uint16] $BaseCureTime, [uint16] $CureTime, [uint16] $RaiseDistance, [uint16] $Index)
    {
        $this.Material = $Material
        $this.BaseCureTime = $BaseCureTime
        $this.CureTime = $CureTime
        $this.RaiseDistance = $RaiseDistance
        $this.Index = $Index
    }

    [string] ToString()
    {
        return (@{
                Material      = $this.Material
                BaseCureTime  = $this.BaseCureTime
                CureTime      = $this.CureTime
                RaiseDistance = $this.RaiseDistance
            } | ConvertTo-Json -Compress)
    }
}

class PrismPrinter
{
    [string] $IPAddress
    [string] $MacAddress
    [version] $FirmwareVersion

    PrismPrinter ()
    { }

    PrismPrinter ([string] $ipAddress, [string] $macAddress)
    {
        $this.IPAddress = $ipAddress
        $this.MacAddress = $macAddress
        $this.FirmwareVersion = [version]::new()
    }

    PrismPrinter ([string] $ipAddress, [string] $macAddress, [version] $version)
    {
        $this.IPAddress = $ipAddress
        $this.MacAddress = $macAddress
        $this.FirmwareVersion = $version
    }

    [string] ToString()
    {
        return $this.IPAddress
    }
}