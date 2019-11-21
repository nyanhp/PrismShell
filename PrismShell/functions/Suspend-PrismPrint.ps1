<#
.SYNOPSIS
    Pause a print on your Prism!
.DESCRIPTION
    Pause a print on your Prism!
.PARAMETER ComputerName
    The host name or IP of your Prism
.PARAMETER Session
    The session to your Prism, autocreated if not provided
.EXAMPLE
    Suspend-PrismPrint

    Pauses a running print
#>
function Suspend-PrismPrint
{
    [CmdletBinding()]
    param
    (
        [Parameter()]
        [string]
        $ComputerName = (Get-PrismPrinter),

        [Parameter()]
        [microsoft.powershell.commands.webrequestsession]
        $Session
    )

    $uri = "http://$ComputerName/CMD/Pause"
    if ($null -eq $Session)
    {
        $Session = New-PrismSession -ComputerName $ComputerName
    }

    if ((Get-PrismStatus -ComputerName $ComputerName -Session $Session).Status -in 'Idle','Unknown')
    {
        Stop-PSFFunction -String 'SuspendPrismPrint.NotSuspending' -StringValues $ComputerName
    }

    Write-PSFMessage -String 'SuspendPrismPrint.AttemptPause' -StringValues $ComputerName
    Invoke-RestMethod -Uri $uri -Method Get -WebSession $Session
}
