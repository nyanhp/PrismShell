<#
.SYNOPSIS
    Get printer settings
.DESCRIPTION
    Get all printer settings
.PARAMETER ComputerName
    The host name or IP of your Prism
.PARAMETER Session
    The session to your Prism, autocreated if not provided
.EXAMPLE
    Get-PrismSetting

    name          value
    ----          -----
    printerName   replicator
    burnInLayers
    acceleration
    homeSpeed
    liftSpeed     5000
    levelingDelay
    clearTime
    ledPower
    mipiFlush
    zOffset
#>
function Get-PrismSetting
{
    [CmdletBinding()]
    param
    (
        [Parameter()]
        [string]
        $ComputerName = (Get-PrismPrinter).IPAddress,

        [Parameter()]
        [microsoft.powershell.commands.webrequestsession]
        $Session
    )

    $uri = "http://$ComputerName/setting"

    if ($null -eq $Session)
    {
        $Session = New-PrismSession -ComputerName $ComputerName
    }

    Invoke-RestMethod -Uri $uri -Method Get -WebSession $Session
}
