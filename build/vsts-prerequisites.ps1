Install-PackageProvider -Name NuGet -Force

$modules = @("Pester", "PSFramework", "PSScriptAnalyzer", "PowerShellGet")

foreach ($module in $modules) {
    "Installing $module"
    Install-Module $module -Force -SkipPublisherCheck -AllowClobber
    Import-Module $module -Force -PassThru
}