<#
.SYNOPSIS
    List all files on the SD card
.DESCRIPTION
    List all files on the SD card
.PARAMETER ComputerName
    The host name or IP of your Prism
.PARAMETER Session
    The session to your Prism, autocreated if not provided
.PARAMETER Name
    Filter the file list by name. Returns $null if the file does not exist
#>
function Get-PrismFile
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [string]
        $ComputerName,

        [Parameter()]
        [microsoft.powershell.commands.webrequestsession]
        $Session,

        [Parameter()]
        [string]
        $Name
    )

    $uri = "http://$ComputerName/filelist.json"

    if ($null -eq $Session)
    {
        $Session = New-PrismSession -ComputerName $ComputerName
    }

    [System.IO.FileInfo[]]$files = (Invoke-RestMethod -Uri $uri -WebSession $session).Text

    if (-not [string]::IsNullOrWhiteSpace($Name))
    {
        return ($files | Where-Object Name -eq $Name)
    }

    $files
}
