## [WN11-CC-000315 — Always Install with Elevated Privileges (Disabled)](https://www.stigaview.com/products/win11/v2r1/WN11-CC-000315/)

### Overview
This STIG ensures that **standard (non-administrator) users cannot install software with elevated (administrator) privileges**. If this setting is misconfigured, a regular user could install a malicious application that runs with full system permissions, leading to **privilege escalation and full system compromise**.

---

### Why this matters
Windows includes a feature called **“Always install with elevated privileges.”**  
When enabled, it allows applications installed via Windows Installer (MSI files) to automatically run with administrator rights — **even if the user installing them is not an admin**.

This is dangerous because:
- A malicious MSI can be used to gain **full control of the system**
- Malware can bypass user privilege boundaries
- Attackers can escalate privileges without exploiting a software vulnerability

Because this directly enables privilege escalation, DISA classifies this as a **CAT I (High Severity)** finding.

---

### What the STIG checks
The system is considered **non-compliant** if the following registry value is missing or incorrectly configured:

- **Registry Hive:** `HKEY_LOCAL_MACHINE`
- **Registry Path:**
