<#
.SYNOPSIS
    Display toast message
.DESCRIPTION
    Display toast message
.PARAMETER Message
    The message to display
.EXAMPLE
    Show-PrismToast -Message ((Get-PSFLocalizedString -Module PrismShell -Name StartPrismPrint.PrintFinished) -f $ComputerName, $Name)

    Displays a toast message if the printer is done
#>
function Show-PrismToast
{
    param
    (
        [Parameter(Mandatory)]
        [string]
        $Message
    )

    if ($IsLinux -or $IsMacOS) {return}
    
    if ([environment]::OSVersion.Version -lt 6.3) { return }

    $toastProvider = "{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe"
    $template = "<toast><visual><binding template=`"ToastText02`"><text id=`"1`">PrismShell</text><text id=`"2`">{0}</text></binding></visual></toast>" -f $Message


    try
    {
        [void]([Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime])
        [void]([Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime])
        [void]([Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime])
        $xml = New-Object Windows.Data.Xml.Dom.XmlDocument

        $xml.LoadXml($template)
        $toast = New-Object Windows.UI.Notifications.ToastNotification $xml
        [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($toastProvider).Show($toast)
    }
    catch
    {
        Write-PSFMessage "Error sending toast notification: $($_.Exception.Message)"
    }
}