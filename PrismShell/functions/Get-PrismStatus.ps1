<#
.SYNOPSIS
    Get the current status
.DESCRIPTION
    Get the current printer status
.PARAMETER ComputerName
    The host name or IP of your Prism
.PARAMETER Session
    The session to your Prism, autocreated if not provided
.EXAMPLE
    Get-PrismStatus

    Gets current printer status
#>
function Get-PrismStatus
{
    param
    (
        [Parameter()]
        [string]
        $ComputerName = (Get-PrismPrinter).IPAddress,

        [Parameter()]
        [microsoft.powershell.commands.webrequestsession]
        $Session
    )

    $uri = "http://$ComputerName/status"

    if ($null -eq $Session)
    {
        $Session = New-PrismSession -ComputerName $ComputerName
    }

    $statusMessage, $file = (Invoke-RestMethod -Uri $uri -Method Get -WebSession $Session) -split '\s+'
    $status,$complete,$eta = $statusMessage -split ','

    [PSCustomObject]@{
        Status = if ($status -eq 'P') { 'Printing' } elseif ($status -eq 'I') { 'Idle' } else { 'Unknown' }
        Layer = $complete
        TimeRemaining = $eta -as [timespan]
        FileName = $file
    }
}
