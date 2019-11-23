<#
.SYNOPSIS
    Remove a file on the SD card
.DESCRIPTION
    Remove a file on the SD card
.PARAMETER ComputerName
    The host name or IP of your Prism
.PARAMETER Session
    The session to your Prism, autocreated if not provided
.PARAMETER Name
    The name of the file, can be piped from Get-PrismFile
.EXAMPLE
    Get-PrismFile -Name Daishi.cddlp | Remove-PrismFile

    Checks if your awesome Daishi BattleMech model exists, and if it does, removes it. Shame on you :(
    Unless you were making room for a Marauder...
#>
function Remove-PrismFile
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

        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]
        $Name
    )

    begin
    {
        $uri = "http://$ComputerName/CMD/Del/{0}"
        if ($null -eq $Session)
        {
            $Session = New-PrismSession -ComputerName $ComputerName
        }
    }

    process
    {
        Write-PSFMessage -String 'RemovePrismFile.Removing' -StringValues $ComputerName, $Name
        $null = Invoke-RestMethod -Uri ($uri -f $Name) -Method Get -WebSession $Session -ErrorAction Stop
    }
}
