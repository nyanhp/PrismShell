<#
.SYNOPSIS
    Stop a print on your Prism!
.DESCRIPTION
    Stop a print on your Prism!
.PARAMETER ComputerName
    The host name or IP of your Prism
.PARAMETER Session
    The session to your Prism, autocreated if not provided
#>
function Stop-PrismPrint
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

    $uri = "http://$ComputerName/CMD/Cancel"
    if ($null -eq $Session)
    {
        $Session = New-PrismSession -ComputerName $ComputerName
    }

    if ((Get-PrismStatus -ComputerName $ComputerName -Session $Session).Status -in 'Idle','Unknown')
    {
        Stop-PSFFunction -String 'StopPrismPrint.NotStopping' -StringValues $ComputerName
    }

    Write-PSFMessage -String 'StopPrismPrint.AttemptStop' -StringValues $ComputerName
    Invoke-RestMethod -Uri $uri -Method Get -WebSession $Session
}
