<#
This script publishes the module to the gallery.
It expects as input an ApiKey authorized to publish the module.

Insert any build steps you may need to take before publishing it here.
#>
param
(
	$WorkingDirectory = (Resolve-Path "$PSScriptRoot\..").Path
)

# Prepare publish folder
Write-PSFMessage -Level Important -Message "Creating and populating publishing directory $WorkingDirectory"
$publishDir = New-Item (Join-Path -Path $env:TEMP -ChildPath publish) -ItemType Directory -Force
Copy-Item -Path "$($WorkingDirectory)" -Destination $publishDir.FullName -Recurse -Force -Exclude .git

#region Gather text data to compile
$text = @()
$processed = @()

# Gather Stuff to run before
Write-PSFMessage -Level Important -Message "Processing filebefore"
foreach ($line in (Get-Content "$($PSScriptRoot)\filesBefore.txt" | Where-Object { $_ -notlike "#*" }))
{
	if ([string]::IsNullOrWhiteSpace($line)) { continue }
	
	$basePath = Join-Path "$($publishDir.FullName)\PrismShell" $line
	foreach ($entry in (Resolve-PSFPath -Path $basePath))
	{
		$item = Get-Item $entry
		if ($item.PSIsContainer) { continue }
		if ($item.FullName -in $processed) { continue }
		$text += [System.IO.File]::ReadAllText($item.FullName)
		$processed += $item.FullName
	}
}

# Gather commands
Write-PSFMessage -Level Important -Message "Finding functions"
Get-ChildItem -Path "$($publishDir.FullName)\PrismShell\internal\functions\" -Recurse -File -Filter "*.ps1" | ForEach-Object {
	$text += [System.IO.File]::ReadAllText($_.FullName)
}
Get-ChildItem -Path "$($publishDir.FullName)\PrismShell\functions\" -Recurse -File -Filter "*.ps1" | ForEach-Object {
	$text += [System.IO.File]::ReadAllText($_.FullName)
}

# Gather stuff to run afterwards
Write-PSFMessage -Level Important -Message "Processing fileAfter"
foreach ($line in (Get-Content "$($PSScriptRoot)\filesAfter.txt" | Where-Object { $_ -notlike "#*" }))
{
	if ([string]::IsNullOrWhiteSpace($line)) { continue }
	
	$basePath = Join-Path "$($publishDir.FullName)\PrismShell" $line
	foreach ($entry in (Resolve-PSFPath -Path $basePath))
	{
		$item = Get-Item $entry
		if ($item.PSIsContainer) { continue }
		if ($item.FullName -in $processed) { continue }
		$text += [System.IO.File]::ReadAllText($item.FullName)
		$processed += $item.FullName
	}
}
#endregion Gather text data to compile

#region Update the psm1 file
Write-PSFMessage -Level Important -Message "Update PSM1"
$fileData = Get-Content -Path "$($publishDir.FullName)\PrismShell\PrismShell.psm1" -Raw
$fileData = $fileData.Replace('"<was not compiled>"', '"<was compiled>"')
$fileData = $fileData.Replace('"<compile code into here>"', ($text -join "`n`n"))
[System.IO.File]::WriteAllText("$($publishDir.FullName)\PrismShell\PrismShell.psm1", $fileData, [System.Text.Encoding]::UTF8)
#endregion Update the psm1 file

# Publish to Gallery
$ApiKey = $env:ApiKey

if ([string]::IsNullOrWhiteSpace($ApiKey))
{
	throw "Why is there no API Key, boy?"
}

Write-PSFMessage -Level Important -Message "Publishing, $($publishDir.FullName)\PrismShell, API: $(-join $ApiKey[0,1])...$(-join $ApiKey[-2,-1])"
Publish-Module -Path "$($publishDir.FullName)\PrismShell" -NuGetApiKey $ApiKey -Force -Confirm:$false -Verbose
