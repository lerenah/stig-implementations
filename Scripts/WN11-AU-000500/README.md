## [WN11-AU-000500 — Application Event Log Size Configured](https://www.stigaview.com/products/win11/v1r5/WN11-AU-000500/)

### Overview
This STIG ensures that the **Windows Application event log is configured with sufficient capacity** to retain audit records. Proper log sizing prevents important security and application events from being overwritten too quickly.

---

### Why this matters
The Application event log records events related to applications and services running on the system. If the log size is too small:

- Logs may fill up rapidly
- Older events may be overwritten before review
- Important audit and troubleshooting data may be lost
- Security investigations may lack sufficient historical evidence

Ensuring an adequate log size helps support **incident response, forensic analysis, and operational troubleshooting**.

Because insufficient logging can hinder detection and response, DISA classifies this as a **CAT II (Medium Severity)** finding.

---

### What the STIG checks
The system is considered **non-compliant** if the following registry value is missing or incorrectly configured (unless logs are sent directly to an external audit server and documented as NA):

- **Registry Hive:** `HKEY_LOCAL_MACHINE`
- **Registry Path:**
