## [WN11-CC-000185 — Default AutoRun Behavior Prevents AutoRun Commands](https://www.stigaview.com/products/win11/v2r1/WN11-CC-000315/)

### Overview
This STIG ensures Windows is configured to **block AutoRun commands by default**. AutoRun can execute commands automatically when media (like USB drives or installers) is inserted, which attackers can abuse to run malicious code without the user intending to execute anything.

---

### Why this matters
AutoRun is a feature that can automatically launch commands when removable media is connected. That convenience creates risk:

- A malicious USB/device can attempt to run code automatically
- Users may trigger malware just by inserting media
- Attackers often use removable media as an initial infection vector

This control forces the system’s default behavior to **not execute any AutoRun commands**, reducing the risk of malware introduction through connected media.

Because this is a direct malware execution risk, DISA classifies this as a **CAT I (High Severity)** finding.

---

### What the STIG checks
The system is considered **non-compliant** if the following registry value is missing or incorrectly configured:

- **Registry Hive:** `HKEY_LOCAL_MACHINE`
- **Registry Path:**
