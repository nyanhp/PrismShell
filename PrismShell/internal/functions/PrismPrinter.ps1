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