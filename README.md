# PrismShell

## Current status

[![Build status](https://dev.azure.com/japete/PrismShell/_apis/build/status/PrismShell-CI)](https://dev.azure.com/japete/PrismShell/_build/latest?definitionId=12)

## Installation

Get it on the PowerShell gallery or clone it from here. This module allows you to interact with your Prism 3D printer.

```powershell
Install-Module PrismShell -Scope CurrentUser
```

Your operating system should not matter. At the moment, I assume that the command ```arp -a``` can be executed. Should you require sudo privileges, start your
pwsh with sudo. May be streamlined in a future release.

## Getting started

To get started, boot your printer. Ping it at least once for autodiscovery.

### With auto-discovery

```powershell
# With auto-discovery working, this returns your current printer
Get-PrismPrinter

# See the files and resin profiles
Get-PrismFile
Get-PrismProfile

# View and change settings
Get-PrismSetting
Set-PrismSetting -PrinterName copycat

# Start a print
# Filename is MAD5A.cddlp, resin profile index is 2
Start-PrismPrint -Index 2 -Name MAD5A.cddlp

# Pause, resume or cancel a print
Suspend-PrismPrint
Resume-PrismPrint
Stop-PrismPrint
```

### Without auto-discovery

```powershell
# Everything else stays the same after this cmdlet
# Settings are persisted.
Set-PrismDefaultPrinter -ComputerName 192.168.2.12 -MacAddress 'aa:bb:cc:dd:ee:ff'

# Want to try auto-discovery again? This removes the default printer
Enable-PrismAutodiscovery
```

## Cmdlets

### Add-PrismProfile

***Not functional yet***

Add a new resin profile

### Clear-PrismDefaultPrinter

Remove the default printer you configured

### Disable-PrismAutodiscovery

Disable auto-discovery via ARP cache

### Enable-PrismAutodiscovery

Enable auto-discovery via ARP cache

### Get-PrismFile

List files on the currently inserted SD card

### Get-PrismPrinter

Return the currently discovered/set prism printer

### Get-PrismProfile

List resin profiles

### Get-PrismSetting

Get the printer settings like name, travel speed, LED intensity, ...

### Get-PrismStatus

Get the printer status

### New-PrismProfile

Create a new profile object to use with Add-PrismProfile

### New-PrismSession

Create a new WebSession that can be used with the other cmdlets

### Remove-PrismFile

Remove a file from the Prism's SD card

### Resume-PrismPrint

Resume a paused print

### Set-PrismDefaultPrinter

Configure a default printer by its DNS entry or IP and its MAC address. Will disable auto-discovery (duh!).

### Set-PrismSetting

Configure individual printer settings, e.g. the internal name of the device or the Z offset.

### Start-PrismPrint

Start a print

### Stop-PrismPrint

Cancel a print

### Suspend-PrismPrint

Pause a print
