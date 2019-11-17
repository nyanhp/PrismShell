<#
.SYNOPSIS
    Resume a print on your Prism!
.DESCRIPTION
    Resume a print on your Prism!
.PARAMETER ComputerName
    The host name or IP of your Prism
.PARAMETER Session
    The session to your Prism, autocreated if not provided
#>
function Resume-PrismPrint
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [string]
        $ComputerName,

        [Parameter()]
        [microsoft.powershell.commands.webrequestsession]
        $Session
    )

    $uri = "http://$ComputerName/CMD/Resume"
    if ($null -eq $Session)
    {
        $Session = New-PrismSession -ComputerName $ComputerName
    }

    if ((Get-PrismStatus -ComputerName $ComputerName -Session $Session).Status -in 'Idle','Unknown')
    {
        Write-Warning -Message 'Not executing Resume. Printer is currently idle'
    }

    Invoke-RestMethod -Uri $uri -Method Get -WebSession $Session
}
