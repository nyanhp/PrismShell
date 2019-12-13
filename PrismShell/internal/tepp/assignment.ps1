<#
# Example:
Register-PSFTeppArgumentCompleter -Command Get-Alcohol -Parameter Type -Name PrismShell.alcohol
#>

Register-PSFTeppArgumentCompleter -Command Add-PrismProfile, Get-PrismFile, Get-PrismProfile, Get-PrismStatus, New-PrismSession, Remove-PrismFile, Resume-PrismPrint, Stop-PrismPrint, Suspend-PrismPrint -Parameter ComputerName -Name 'PrismShell.Printers'
Register-PSFTeppArgumentCompleter -Command Start-PrismPrint -Parameter ResinProfileName -Name 'PrismShell.ResinName'