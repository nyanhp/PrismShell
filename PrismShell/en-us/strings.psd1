# This is where the strings go, that are written by
# Write-PSFMessage, Stop-PSFFunction or the PSFramework validation scriptblocks
@{
	'AddPrismProfile.ProfileExistsError'     = 'Profile ID {0} already exists on {1}. Use -Force to overwrite.'
	'AddPrismProfile.NotImplemented'         = "Currently cannot add new profiles. Try to find out how it works and create a PR for github.com/nyanhp/prismshell"
	'FindPrismPrinter.AutoDiscoDisabled'     = 'Auto-discovery not enabled. Returning default printer'
	'FindPrismPrinter.AutoDiscoEnabled'      = 'Using auto-discovery - reading ARP cache'
	'FindPrismPrinter.HashtagSad'            = 'No printer found - try pinging it first'
	'FindPrismPrinter.MultiplePrintersFound' = 'More than one possible printer has been discovered. Carefully review the discovered printers.'
	'GetPrismFile.DiscoveryStarted'          = 'Discovering files on {0}'
	'GetPrismFile.FilterName'                = 'Filtering files on {0} by Name with filter {1}.'
	'GetPrismProfile.FilterIndex'            = 'Index {2} does not match filter profiles on {0} by Index {1}'
	'NewPrismSession.CreateAuthCookie'       = 'Creating auth cookie for {0} with value {1}'
	'NewPrismSession.NoMacAddress'           = 'No MAC address found belonging to {0}. Cannot create a cookie.'
	'RemovePrismFile.Removing'               = 'Attempting to remove {1} on {0}'
	'ResumePrismPrint.NotResuming'           = 'Not executing Resume. Printer {0} is currently idle'
	'StartPrismPrint.ProfileMissing'         = 'Printer profile {1} does not exist on {0}. Try "Get-PrismProfile -ComputerName {0}" to see which profiles are available'
	'StartPrismPrint.FileNotFound'           = 'File {1} does not exist on SD card in {0}. The following files were found: {2}'
	'StartPrismPrint.Starting'               = 'Printing {1} on {0} with profile ID {2}'
	'StartPrismPrint.WaitingForGodot'        = 'Waiting for {1} to finish printing on {0}'
	'StartPrismPrint.PrintFinished'          = '{1} successfully printed on {0}!'
	'StopPrismPrint.NotStopping'             = 'Not executing cancellation. Printer {0} is currently idle'
	'StopPrismPrint.AttemptStop'             = 'Attempting to cancel active print on {0}'
	'SuspendPrismPrint.NotSuspending'        = 'Not executing pause. Printer {0} is currently idle'
	'SuspendPrismPrint.AttemptPause'         = 'Attempting to pause print on {0}'

	'GetArpCache.DnsLookupFailed'            = 'DNS lookup of {0} failed. Cannot reliably filter ARP table for Auth cookie.'
	'GetArpCache.AddingEntry'                = 'Adding entry {0} to ARP cache result set'
	'GetArpCache.Filtering'                  = 'Filtering cache result by {0}'
	'GetArpCache.MalformedMac'               = 'Malformed MAC in entry {0}, {1}'
}