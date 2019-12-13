<#
# Example:
Register-PSFTeppScriptblock -Name "PrismShell.alcohol" -ScriptBlock { 'Beer','Mead','Whiskey','Wine','Vodka','Rum (3y)', 'Rum (5y)', 'Rum (7y)' }
#>

Register-PSFTeppScriptblock -Name 'PrismShell.Printers' -ScriptBlock { (Get-PrismPrinter).IpAddress }
Register-PSFTeppScriptblock -Name 'PrismShell.ResinName' -ScriptBlock { (Get-PrismProfile).Name}
