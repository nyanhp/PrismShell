
<#
.SYNOPSIS
    Start a print on your Prism!
.DESCRIPTION
    Starts to print a file that can be retrieved with Get-PrismFile
.PARAMETER ComputerName
    The host name or IP of your Prism
.PARAMETER Session
    The session to your Prism, autocreated if not provided
.PARAMETER Name
    The file name to print
.PARAMETER Index
    The resin profile to print with, e.g. Get-PrismProfile
#>
function Start-PrismPrint
{
    [CmdletBinding()]
    param
    (
        [Parameter()]
        [string]
        $ComputerName = (Get-PrismPrinter),

        [Parameter()]
        [microsoft.powershell.commands.webrequestsession]
        $Session,

        [Parameter(Mandatory)]
        [string]
        $Name,

        [Parameter(Mandatory)]
        [ValidateRange(1, 7)]
        [uint16]
        $Index
    )

    $uri = "http://$ComputerName/CMD/Print{0}{1}"
    if ($null -eq $Session)
    {
        $Session = New-PrismSession -ComputerName $ComputerName
    }

    if ($null -eq (Get-PrismProfile -ComputerName $ComputerName -Session $Session -Index $Index))
    {
        Stop-PSFFunction -String 'StartPrismPrint.ProfileMissing' -StringValues $ComputerName, $Index
    }

    if ($null -eq (Get-PrismFile -ComputerName $ComputerName -Session $Session -Name $Name))
    {
        Stop-PSFFunction -String 'StartPrismPrint.FileNotFound' -StringValues $ComputerName, $Name, $((Get-PrismFile -ComputerName $ComputerName -Session $Session).Name -join ',')
    }

    Write-PSFMessage -String 'StartPrismPrint.Starting' -StringValues $ComputerName, $Name, $Index
    $null = Invoke-RestMethod -Uri ($uri -f $Index, $Name) -Method Get -WebSession $Session
}
