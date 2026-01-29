<#
.SYNOPSIS
    Remediates WN11-SO-000205 by enforcing NTLMv2-only authentication
    and refusing LM and NTLM.

.DESCRIPTION
    STIG requires the following registry value:

      HKLM\SYSTEM\CurrentControlSet\Control\Lsa
        LmCompatibilityLevel (REG_DWORD) = 5

    A value of 5 enforces:
      "Send NTLMv2 response only. Refuse LM & NTLM"

.NOTES
    STIG-ID : WN11-SO-000205
    Author  : Rena Holloway
    Version : 1.0

.USAGE
    PS C:\> .\WN11-SO-000205.ps1
    PS C:\> .\WN11-SO-000205.ps1 | Tee-Object -FilePath .\WN11-SO-000205_evidence.txt
#>

# --- Ensure script is running as Administrator ---
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (-not $IsAdmin) {
    throw "Please run PowerShell as Administrator (required to write HKLM)."
}

$regPath   = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$valueName = "LmCompatibilityLevel"
$desired   = 5

function Get-DwordValueOrNull {
    param([string]$Path, [string]$Name)
    try {
        return (Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop).$Name
    } catch {
        return $null
    }
}

Write-Host "`n=== WN11-SO-000205 Remediation: Enforce NTLMv2 Only ===`n"

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
