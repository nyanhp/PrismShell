<#
This is an example configuration file

By default, it is enough to have a single one of them,
however if you have enough configuration settings to justify having multiple copies of it,
feel totally free to split them into multiple files.
#>

<#
# Example Configuration
Set-PSFConfig -Module 'PrismShell' -Name 'Example.Setting' -Value 10 -Initialize -Validation 'integer' -Handler { } -Description "Example configuration setting. Your module can then use the setting using 'Get-PSFConfigValue'"
#>

Set-PSFConfig -Module 'PrismShell' -Name 'Import.DoDotSource' -Value $false -Initialize -Validation 'bool' -Description "Whether the module files should be dotsourced on import. By default, the files of this module are read as string value and invoked, which is faster but worse on debugging."
Set-PSFConfig -Module 'PrismShell' -Name 'Import.IndividualFiles' -Value $true -Initialize -Validation 'bool' -Description "Whether the module files should be imported individually. During the module build, all module code is compiled into few files, which are imported instead by default. Loading the compiled versions is faster, using the individual files is easier for debugging and testing out adjustments."

# Printer config
Set-PSFConfig -Module 'PrismShell' -Name 'AutoDiscovery.Enabled' -Value $true -Initialize -Validation 'bool' -Description 'Whether or not AutoDiscovery is enabled'
Set-PSFConfig -Module 'PrismShell' -Name 'AutoDiscovery.UseFirstPrinter' -Value $true -Initialize -Validation 'bool' -Description 'Whether or not the first discovered printer is enabled'

# Default printer
Set-PSFConfig -Module 'PrismShell' -Name 'DefaultPrinter.ComputerName' -Description 'If auto discovery is disabled, use this setting to configure the default IP or DNS Host Name of your printer.'
Set-PSFConfig -Module 'PrismShell' -Name 'DefaultPrinter.MacAddress' -Description 'The MAC address of your printer. If not specified and auto discovery is disabled, the ARP table will be queried for the MAC address' -Validation macaddresscolon
