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
.PARAMETER Wait
    Indicates that the cmdlet will wait until the print is finished.
.PARAMETER AsJob
    Returns a Job object that waits in the background for the print to finish, or until you close PowerShell
.EXAMPLE
    Start-PrismPrint -Index 2 -Name MAD5A.cddlp

    Printer your awesome Marauder with your second profile
#>
function Start-PrismPrint
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

        [Parameter(Mandatory)]
        [string]
        $Name,

        [Parameter(Mandatory)]
        [ValidateRange(1, 7)]
        [uint16]
        $Index,

        [Parameter(ParameterSetName = 'Wait')]
        [switch]
        $Wait,

        [Parameter(ParameterSetName = 'WaitJob')]
        [switch]
        $AsJob
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

    if ($Wait.IsPresent)
    {
        while ((Get-PrismStatus).Status -in 'Leveling','Printing')
        {
            Start-Sleep -Seconds 30
            Write-PSFMessage -String StartPrismPrint.WaitingForGodot -StringValues $ComputerName, $Name
        }

        Show-PrismToast -Message ((Get-PSFLocalizedString -Module PrismShell -Name StartPrismPrint.PrintFinished) -f $ComputerName, $Name)
    }

    if ($AsJob.IsPresent)
    {
        Start-Job -Name ('{0}_{1}' -f $ComputerName, $Name) -ArgumentList $ComputerName,(Get-PrismPrinter).MacAddress -ScriptBlock {
            param($IP, $MAC)

            $printerSession = New-PrismSession -ComputerName $IP -MacAddress $MAC

            while ((Get-PrismStatus -ComputerName $IP -Session $printerSession).Status -in 'Leveling','Printing')
            {
                Start-Sleep -Seconds 30
                Write-PSFMessage -String StartPrismPrint.WaitingForGodot -StringValues $ComputerName, $Name
            }

            Show-PrismToast -Message ((Get-PSFLocalizedString -Module PrismShell -Name StartPrismPrint.PrintFinished) -f $ComputerName, $Name)
        }
    }
}
