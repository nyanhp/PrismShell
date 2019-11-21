Install-PackageProvider -Name NuGet -Force

$modules = @("Pester", "PSFramework", "PSScriptAnalyzer", "PowerShellGet")

foreach ($module in $modules) {
    Write-Host "Installing $module" -ForegroundColor Cyan
    Install-Module $module -Force -SkipPublisherCheck -AllowClobber
    Import-Module $module -Force -PassThru
}
