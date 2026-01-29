<#
.SYNOPSIS
    Remediates WN11-CC-000345 by disabling Basic authentication
    for the WinRM service.

.DESCRIPTION
    STIG requires the following registry value:

      HKLM\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service
        AllowBasic (REG_DWORD) = 0

    If the value is missing or not set to 0, this is a finding.

.NOTES
    STIG-ID : WN11-CC-000345
    Author  : Rena Holloway
    Version : 1.0

.USAGE
    PS C:\> .\WN11-CC-000345.ps1
    PS C:\> .\WN11-CC-000345.ps1 | Tee-Object -FilePath .\WN11-CC-000345_evidence.txt
#>

# --- Ensure script is running as Administrator ---
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (-not $IsAdmin) {
    throw "Please run PowerShell as Administrator (required to write HKLM)."
}

$regPath   = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service"
$valueName = "AllowBasic"
$desired   = 0

function Get-DwordValueOrNull {
    param([string]$Path, [string]$Name)
    try {
        return (Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop).$Name
    } catch {
        return $null
    }
}

Write-Host "`n=== WN11-CC-000345 Remediation: Disable WinRM Service Basic Authentication ===`n"

# BEFORE
$current = Get-DwordValueOrNull -Path $regPath -Name $valueName
if ($null -eq $current) {
    Write-Host "BEFORE: $valueName is <not set> (this is a finding per STIG)"
} else {
    Write-Host "BEFORE: $valueName = $current"
}

# Ensure key exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
    Write-Host "Created missing key: $regPath"
}

# Set the required value explicitly
New-ItemProperty -Path $regPath -Name $valueName -PropertyType DWord -Value $desired -Force | Out-Null
Write-Host "SET: $regPath\$valueName = $desired (DWORD)"

# AFTER
$final = Get-DwordValueOrNull -Path $regPath -Name $valueName
Write-Host "AFTER: $valueName = $final"

if ($final -eq $desired) {
    Write-Host "`nRESULT: COMPLIANT (Expected $desired, got $final). Re-run Tenable to confirm it passes.`n"
    exit 0
} else {
    Write-Host "`nRESULT: NON-COMPLIANT (Expected $desired, got $final).`n"
    exit 1
}
