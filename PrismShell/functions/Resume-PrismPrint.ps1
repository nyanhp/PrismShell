<#
.SYNOPSIS
    Resume a print on your Prism!
.DESCRIPTION
    Resume a print on your Prism!
.PARAMETER ComputerName
    The host name or IP of your Prism
.PARAMETER Session
    The session to your Prism, autocreated if not provided
.EXAMPLE
    Resume-PrismPrint

    Resumes a paused print
#>
function Resume-PrismPrint
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

    $uri = "http://$ComputerName/CMD/Resume"
    if ($null -eq $Session)
    {
        $Session = New-PrismSession -ComputerName $ComputerName
    }

    if ((Get-PrismStatus -ComputerName $ComputerName -Session $Session).Status -in 'Idle','Unknown')
    {
        Write-PSFMessage -String 'ResumePrismPrint.NotResuming' -StringValues $ComputerName
    }

    Invoke-RestMethod -Uri $uri -Method Get -WebSession $Session
}
