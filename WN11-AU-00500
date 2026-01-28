<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Lerena Hollloway
    LinkedIn        : linkedin.com/in/lerenah/
    GitHub          : github.com/lerenah
    Date Created    : 2026-01-28
    Last Modified   : 2026-01-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000500

.TESTED ON
    Date(s) Tested  : 2026-01-28
    Tested By       : Lerena Holloway
    Systems Tested  : Windows 11 (Azure VM)
    PowerShell Ver. : 5.1+

.USAGE
    1) Save as: Remediate-WN11-AU-000500.ps1
    2) Open PowerShell as Administrator
    3) (Optional) Allow script execution for this session:
       PS C:\> Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
    4) Run:
       PS C:\> .\Remediate-WN11-AU-000500.ps1
       PS C:\> .\Remediate-WN11-AU-000500.ps1 -MinimumKB 65536 -ForceGpUpdate
#>

# WN11-AU-000500 - Ensure Application Event Log MaxSize >= 32768 KB

$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$valueName    = "MaxSize"
$minKB        = 32768

# Admin check
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Error "Run PowerShell as Administrator."
    exit 2
}

# Ensure key exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set only if missing or too small
$current = (Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue).$valueName
if ($null -eq $current -or $current -lt $minKB) {
    New-ItemProperty -Path $registryPath -Name $valueName -Value $minKB -PropertyType DWord -Force | Out-Null
}

# Verify
$final = (Get-ItemProperty -Path $registryPath -Name $valueName).$valueName
Write-Host "Final: $registryPath\$valueName = $final KB"

if ($final -ge $minKB) { exit 0 } else { exit 1 }