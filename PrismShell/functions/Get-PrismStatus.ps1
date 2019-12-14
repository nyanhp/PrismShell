<#
.SYNOPSIS
    Get the current status
.DESCRIPTION
    Get the current printer status
.PARAMETER ComputerName
    The host name or IP of your Prism
.PARAMETER Session
    The session to your Prism, autocreated if not provided
.PARAMETER Thumbnail
    Show thumbnail when retrieving status
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
        $Session,

        [switch]
        $Thumbnail
    )

    $uri = "http://$ComputerName/status"
    $thumbnailUri = "http://$ComputerName/thumbnail.bmp"

    if ($null -eq $Session)
    {
        $Session = New-PrismSession -ComputerName $ComputerName
    }

    $statusMessage, $file = (Invoke-RestMethod -Uri $uri -Method Get -WebSession $Session) -split '\s+'
    $status, $complete, $eta = $statusMessage -split ','

    if ($Thumbnail.IsPresent)
    {
        $tmp = Join-Path -Path ([System.IO.Path]::GetTempPath()) -ChildPath 'prismthumbnail.bmp'
        $null = Invoke-RestMethod -WebSession $Session -Uri $thumbnailUri -Method Get -OutFile $tmp
        Show-PrismThumbnail -Path $tmp
    }
write-verbose $status
    [PSCustomObject]@{
        Status        = if ($status -eq 'P')
        {
            'Printing'
        }
        elseif ($status -eq 'L')
        {
            'Leveling'
        }
        elseif ($status -eq 'H')
        {
            'Homing'
        }
        elseif ($status -eq 'I')
        {
            'Idle'
        }
        else
        {
            'Unknown (printer status indicator was {0})' -f $status
        }
        Layer         = $complete
        TimeRemaining = $eta -as [timespan]
        FileName      = $file
    }
}
