## [WN11-CC-000330 — WinRM Client Basic Authentication Disabled](https://www.stigaview.com/products/win11/v1r5/WN11-CC-000330/)

### Overview
This STIG ensures that the **Windows Remote Management (WinRM) client does not allow Basic authentication**. Disabling Basic authentication prevents credentials from being transmitted in plain text during remote management sessions.

---

### Why this matters
WinRM is used for remote management and automation of Windows systems. When **Basic authentication** is enabled, credentials are sent in **plain text** (even if wrapped in HTTP), which creates serious security risk:

- Credentials can be intercepted by attackers on the network
- Plain text passwords can be reused to access other systems
- Remote management channels become an easy target for credential theft

Modern Windows environments should rely on stronger authentication mechanisms such as **Kerberos or certificate-based authentication**, not Basic authentication.

Because compromised administrative credentials can lead directly to full system compromise, DISA classifies this as a **CAT I (High Severity)** finding.

---

### What the STIG checks
The system is considered **non-compliant** if the following registry value is missing or incorrectly configured:

- **Registry Hive:** `HKEY_LOCAL_MACHINE`
- **Registry Path:**
