## [WN11-CC-000345 — WinRM Service Basic Authentication Disabled](https://www.stigaview.com/products/win11/v1r5/WN11-CC-000345/)

### Overview
This STIG ensures that the **Windows Remote Management (WinRM) service does not allow Basic authentication**. Disabling Basic authentication on the WinRM service prevents credentials from being accepted in plain text during remote management operations.

---

### Why this matters
The WinRM **service** listens for and processes remote management requests. If **Basic authentication** is enabled on the service:

- Credentials may be transmitted or accepted in **plain text**
- Attackers on the network could intercept administrative credentials
- Compromised credentials can be reused for lateral movement or full system access

Although Basic authentication may be temporarily required for specific provisioning scenarios (such as initial tenant setup), it must be **explicitly disabled once administration tasks are complete**.

Because this setting directly impacts the security of remote administrative access, DISA classifies this as a **CAT I (High Severity)** finding.

---

### What the STIG checks
The system is considered **non-compliant** if the following registry value is missing or incorrectly configured:

- **Registry Hive:** `HKEY_LOCAL_MACHINE`
- **Registry Path:**
