@{
	# Script module or binary module file associated with this manifest
	RootModule           = 'PrismShell.psm1'

	# Version number of this module.
	ModuleVersion        = '1.5.1'

	# ID used to uniquely identify this module
	GUID                 = '591c2651-a50b-4d31-9398-7031bf9ae7da'

	# Author of this module
	Author               = 'Jan-Hendrik Peters'

	# Company or vendor of this module
	CompanyName          = 'Jan-Hendrik Peters'

	# Copyright statement for this module
	Copyright            = 'Copyright (c) 2019 Jan-Hendrik Peters'

	# Description of the functionality provided by this module
	Description          = 'Cmdlets to interact with your Prism 3D printer'

	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion    = '5.1'

	CompatiblePSEditions = @('Core', 'Desktop')

	# Functions to export from this module
	FunctionsToExport    = @(
		'Add-PrismProfile',
		'Clear-PrismDefaultPrinter',
		'Disable-PrismAutodiscovery',
		'Enable-PrismAutodiscovery',
		'Get-PrismFile',
		'Get-PrismPrinter',
		'Get-PrismProfile',
		'Get-PrismStatus',
		'New-PrismProfile',
		'New-PrismSession',
		'Remove-PrismFile',
		'Resume-PrismPrint',
		'Set-PrismDefaultPrinter',
		'Start-PrismPrint',
		'Stop-PrismPrint',
		'Suspend-PrismPrint'
	)

	RequiredModules      = @(
		@{ ModuleName = 'PSFramework'; ModuleVersion = '1.1.59' }
	)

	# Cmdlets to export from this module
	CmdletsToExport      = ''

	# Variables to export from this module
	VariablesToExport    = ''

	# Aliases to export from this module
	AliasesToExport      = ''

	# List of all files packaged with this module
	FileList             = @()

	# Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData          = @{

		#Support for PowerShellGet galleries.
		PSData = @{

			# Tags applied to this module. These help with module discovery in online galleries.
			Tags       = @('3DPrinting', 'Prism', 'Beam3D')

			# A URL to the license for this module.
			LicenseUri = 'https://github.com/nyanhp/PrismShell/blob/master/LICENSE'

			# A URL to the main website for this project.
			ProjectUri = 'https://github.com/nyanhp/PrismShell'

			# A URL to an icon representing this module.
			# IconUri = ''

			# ReleaseNotes of this module
			# ReleaseNotes = ''

		} # End of PSData hashtable

	} # End of PrivateData hashtable
}