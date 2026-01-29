# Windows 11 DISA STIG Automated Remediations

## Overview

This repository contains programmatic remediation scripts aligned with [Defense Information Systems Agency (DISA) Security Technical Implementation Guides (STIG)](https://public.cyber.mil/stigs/) for Windows 11 systems.

DISA publishes STIGs as authoritative security configuration standards for systems supporting U.S. Department of Defense operations. Each STIG defines specific, testable technical requirements used to harden systems, reduce attack surface, and support compliance audits.

The remediations in this repository implement those requirements through safe, auditable PowerShell scripts. Each script validates the current system state, applies changes only when necessary, and produces clear logging suitable for security review and compliance evidence.

## Windows 11 Remediation Table

| STIG ID | Severity | Description | STIG Link | Link |
|---------|----------|-------------|-----------|------|
| WN11-CC-000315 | 🔴 CAT I | Always install with elevated privileges must be disabled. | [View STIG Summary](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-CC-000315/README.md) | [View Remediation](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-CC-000315/WN11-CC-000315.ps1) |
| WN11-CC-000180 | 🔴 CAT I | Autoplay must be disabled for non-volume devices. | [View STIG Summary](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-CC-000180/README.md) | [View Remediation](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-CC-000180/WN11-CC-000180.ps1) |
| WN11-CC-000185 | 🔴 CAT I | Default AutoRun behavior must prevent AutoRun commands. | [View STIG Summary](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-CC-000185/README.md) | [View Remediation](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-CC-000185/WN11-CC-000185.ps1) |
| WN11-CC-000190 | 🔴 CAT I | Autoplay must be disabled for all drive types. | [View STIG Summary](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-CC-000190/README.md) | [View Remediation](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-CC-000190/WN11-CC-000190.ps1) |
| WN11-SO-000150 | 🔴 CAT I | Anonymous enumeration of SAM accounts and shares must be restricted. | [View STIG Summary](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-SO-000150/README.md) | [View Remediation](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-SO-000150/WN11-SO-000150.ps1) |
| WN11-SO-000205 | 🔴 CAT I | LAN Manager authentication level must enforce NTLMv2 only. | [View STIG Summary](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-SO-000205/README.md) | [View Remediation](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-SO-000205/WN11-SO-000205.ps1) |
| WN11-CC-000330 | 🔴 CAT I | WinRM client must not allow Basic authentication. | [View STIG Summary](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-CC-000330/README.md) | [View Remediation](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-CC-000330/WN11-CC-000330.ps1) |
| WN11-CC-000345 | 🔴 CAT I | WinRM service must not allow Basic authentication. | [View STIG Summary](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-CC-000345/README.md) | [View Remediation](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-CC-000345/WN11-CC-000345.ps1) |
| WN11-AU-000500 | 🟠 CAT II | Application event log size must be configured to 32768 KB or greater. | [View STIG Summary](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-AU-000500/README.md) | [View Remediation](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-AU-000500/WN11-AU-000500.ps1) |
| WN11-AU-000510 | 🟠 CAT II | System event log size must be configured to 32768 KB or greater. | [View STIG Summary](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-AU-000510/README.md) | [View Remediation](https://github.com/lerenah/stig-implementations/blob/main/Scripts/WN11-AU-000510/WN11-AU-000510.ps1) |


### What this demonstrates
- Safe registry remediation with type validation and pre-checks
- Branching outcomes based on registry state:
  - Creates the registry value if missing and logs the action
  - Confirms compliance if the value is already set correctly (no change made)
  - Remediates non-compliant values to the desired state and logs the change
  - Corrects misconfigured or unexpected values to the desired state and logs the remediation
- Per-STIG logging, verification, and evidence generation
- Human-approved remediation workflow with user confirmation before changes
- Clear post-remediation guidance, including restart reminders and re-scan recommendations

### Test Environment

Date(s) Tested  : 20260123  
Tested By       : Rena Holloway 
Systems Tested  : Windows 11 Pro, Build 25H2  
PowerShell Ver. : 5.1.26100.7462
