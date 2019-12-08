<#
.SYNOPSIS
    Change printer settings
.DESCRIPTION
    Change individual printer settings. Do this at your own peril! This cmdlet tries to validate
    your data, but certain settings might still damage your printer, e.g. increasing the LED power to
    the maximum allowed value of 140%
.PARAMETER ComputerName
    The host name or IP of your Prism
.PARAMETER Session
    The session to your Prism, autocreated if not provided
.EXAMPLE
    Set-PrismSetting -PrinterName replicator01 -BurnInLayers 3

    Change the printer name and the number of burn-in layers
#>
function Set-PrismSetting
{
    [CmdletBinding()]
    param
    (
        [Parameter()]
        [string]
        $ComputerName = (Get-PrismPrinter).IPAddress,

        [Parameter()]
        [microsoft.powershell.commands.webrequestsession]
        $Session,

        # New printer name
        [Parameter()]
        [string]
        $PrinterName,

        # How many layers for burn-in should be used. Maximum 10
        [Parameter()]
        [ValidateRange(0, 10)]
        [nullable[uint16]]
        $BurnInLayers,

        # Maximum 10000
        [Parameter()]
        [ValidateRange(0, 10000)]
        [nullable[uint16]]
        $Acceleration,

        # Maximum 12000
        [Parameter()]
        [ValidateRange(0, 12000)]
        [nullable[uint16]]
        $HomeSpeed,

        # Maximum 15000
        [Parameter()]
        [ValidateRange(0, 15000)]
        [nullable[uint16]]
        $LiftSpeed,

        # Leveling delay in seconds
        [Parameter()]
        [nullable[uint16]]
        $LevelingDelaySecond,

        # Clear delay in seconds
        [Parameter()]
        [nullable[uint16]]
        $ClearDelaySecond,

        # LED power, min 20%, max 140%
        [Parameter()]
        [ValidateRange(20, 140)]
        [nullable[uint16]]
        $LedPowerPercent,

        # MIPI flush, max 1000
        [Parameter()]
        [ValidateRange(0, 1000)]
        [nullable[uint16]]
        $MipiFlush,

        # Z Offset in µm
        [Parameter()]
        [ValidateRange(0, 500)]
        [nullable[uint16]]
        $ZOffset
    )

    $uri = "http://$ComputerName/setting"

    if ($null -eq $Session)
    {
        $Session = New-PrismSession -ComputerName $ComputerName
    }

    $body = @{
        printerName   = $PrinterName
        burnInLayers  = $BurnInLayers
        acceleration  = $Acceleration
        homeSpeed     = $HomeSpeed
        liftSpeed     = $LiftSpeed
        levelingDelay = $LevelingDelaySecond
        clearTime     = $ClearDelaySecond
        ledPower      = $LedPowerPercent
        mipiFlush     = $MipiFlush
        zOffset       = $ZOffset
    }

    Write-PSFMessage -String 'SetPrismSetting.SettingApplied' -StringValues $ComputerName, ($body | Out-String)
    Invoke-RestMethod -Method Post -Uri $uri -WebSession $Session -Body ($body | ConvertTo-Json) -ContentType application/json
}
