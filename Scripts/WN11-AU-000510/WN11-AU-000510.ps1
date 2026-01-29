<#
.SYNOPSIS
    Remediates WN11-AU-000510 by configuring the System event log
    maximum size to 32768 KB or greater.

.DESCRIPTION
    STIG requires the following registry value:

      HKLM\SOFTWARE\Policies\Microsoft\Windows\EventLog\System
        MaxSize (REG_DWORD) >= 32768

    If the value is missing or less than 32768, this is a finding.

.NOTES
    STIG-ID : WN11-AU-000510
    Author  : Rena Holloway
    Version : 1.0

.USAGE
    PS C:\> .\WN11-AU-000510.ps1
    PS C:\> .\WN11-AU-000510.ps1 | Tee-Object -FilePath .\WN11-AU-000510_evidence.txt
#>

# --- Ensure script is running as Administrator ---
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (-not $IsAdmin) {
    throw "Please run PowerShell as Administrator (required to write HKLM)."
}

$regPath   = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System"
$valueName = "MaxSize"
$minimum   = 32768  # KB

function Get-DwordValueOrNull {
    param([string]$Path, [string]$Name)
    try {
        return (Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop).$Name
    } catch {
        return $null
    }
}

Write-Host "`n=== WN11-AU-000510 Remediation: System Event Log Size ===`n"

# BEFORE
$current = Get-DwordValueOrNull -Path $regPath -Name $valueName
if ($null -eq $current) {
    Write-Host "BEFORE: $valueName is <not set> (this is a finding per STIG)"
} else {
    Write-Host "BEFORE: $valueName = $current KB"
}

# Ensure key exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
    Write-Host "Created missing key: $regPath"
}

# Remediate only if missing or below minimum
if ($null -eq $current -or $current -lt $minimum) {
    New-ItemProperty -Path $regPath -Name $valueName -PropertyType DWord -Value $minimum -Force | Out-Null
    Write-Host "SET: $regPath\$valueName = $minimum KB"
} else {
    Write-Host "NO CHANGE: Existing value already meets or exceeds requirement"
}

# AFTER
$final = Get-DwordValueOrNull -Path $regPath -Name $valueName
Write-Host "AFTER: $valueName = $final KB"

if ($final -ge $minimum) {
    Write-Host "`nRESULT: COMPLIANT (Minimum $minimum KB met). Re-run Tenable to confirm it passes.`n"
    exit 0
} else {
    Write-Host "`nRESULT: NON-COMPLIANT (Minimum $minimum KB not met).`n"
    exit 1
}
