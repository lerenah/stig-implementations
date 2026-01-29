<#
.SYNOPSIS
    Remediates WN11-CC-000315 by disabling "Always install with elevated privileges".

.DESCRIPTION
    The "AlwaysInstallElevated" policy must be disabled. STIG checks typically require this
    to be explicitly set (0), not merely absent.

    This script:
      1) Reads current values from HKLM and HKCU (if present)
      2) Creates missing keys as needed
      3) Sets AlwaysInstallElevated to 0 (REG_DWORD) in both locations
      4) Prints before/after for evidence

.NOTES
    STIG-ID         : WN11-CC-000315
    Author          : Rena Holloway
    Date Created    : 2026-01-29
    Version         : 1.0

.USAGE
    Run PowerShell as Administrator, then:
      PS C:\> .\WN11-CC-000315.ps1

    Evidence tip:
      - Save output to a file:
        PS C:\> .\WN11-CC-000315.ps1 | Tee-Object -FilePath .\WN11-CC-000315_evidence.txt
#>

# --- Safety: ensure we can write HKLM (admin required) ---
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (-not $IsAdmin) {
    throw "Please run PowerShell as Administrator. (HKLM writes require elevation.)"
}

$targets = @(
    @{
        Hive = "HKLM"
        Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
    },
    @{
        Hive = "HKCU"
        Path = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer"
    }
)

$valueName   = "AlwaysInstallElevated"
$desiredDword = 0

Write-Host "`n=== WN11-CC-000315 Remediation: Disable AlwaysInstallElevated ===`n"

function Get-DwordValueOrNull {
    param(
        [Parameter(Mandatory=$true)] [string] $Path,
        [Parameter(Mandatory=$true)] [string] $Name
    )
    try {
        $p = Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop
        return $p.$Name
    } catch {
        return $null
    }
}

# --- BEFORE state ---
Write-Host "BEFORE:"
foreach ($t in $targets) {
    $current = Get-DwordValueOrNull -Path $t.Path -Name $valueName
    if ($null -eq $current) {
        Write-Host ("  {0} {1} = <not set>" -f $t.Hive, $valueName)
    } else {
        Write-Host ("  {0} {1} = {2}" -f $t.Hive, $valueName, $current)
    }
}

# --- Remediate ---
foreach ($t in $targets) {
    if (-not (Test-Path $t.Path)) {
        New-Item -Path $t.Path -Force | Out-Null
        Write-Host ("Created missing key: {0}" -f $t.Path)
    }

    # Set the policy value explicitly to 0 (REG_DWORD)
    New-ItemProperty -Path $t.Path -Name $valueName -Value $desiredDword -PropertyType DWord -Force | Out-Null
    Write-Host ("Set {0}:\{1} = {2} (DWORD)" -f $t.Hive, $valueName, $desiredDword)
}

# --- AFTER state ---
Write-Host "`nAFTER:"
foreach ($t in $targets) {
    $current = Get-DwordValueOrNull -Path $t.Path -Name $valueName
    Write-Host ("  {0} {1} = {2}" -f $t.Hive, $valueName, $current)
}

Write-Host "`nDone. Re-run your Tenable compliance scan to confirm the finding is cleared."
