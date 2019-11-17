# PrismShell

Get it on the PowerShell gallery or clone it from here. This module allows you to interact with your Prism 3D printer, albeit in a very limited scope.

```powershell
Install-Module PrismShell -Scope CurrentUser
```

Your operating system should not matter. At the moment, I assume that the command ```arp -a``` can be executed. Should you require sudo privileges, start your
pwsh with sudo. May be streamlined in a future release.

## Cmdlets

### Add-PrismProfile

***Not functional yet***

Add a new resin profile

### Get-PrismFile

List files on the currently inserted SD card

### Get-PrismProfile

List resin profiles

### Get-PrismStatus

Get the printer status

### New-PrismProfile

Create a new profile object to use with Add-PrismProfile

### New-PrismSession

Create a new WebSession that can be used with the other cmdlets

### Remove-PrismFile

Remove a file from the Prism's SD card

### Start-PrismPrint

Start a print

### Stop-PrismPrint

Cancel a print

### Pause-PrismPrint

Pause a print

### Resume-PrismPrint

Resume a paused print