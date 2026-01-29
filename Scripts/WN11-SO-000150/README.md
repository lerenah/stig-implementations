## [WN11-SO-000150 — Anonymous Enumeration of Shares Restricted](https://www.stigaview.com/products/win11/v1r5/WN11-SO-000150/)

### Overview
This STIG ensures that **anonymous (unauthenticated) users are not allowed to enumerate shared resources or account information** on the system. Restricting anonymous enumeration helps prevent attackers from gathering information about system resources without valid credentials.

---

### Why this matters
Windows supports anonymous (null session) connections, which—if not properly restricted—can allow unauthenticated users to:

- List shared folders
- Discover system resources
- Map potential attack paths without logging in

This type of information disclosure is often used during **reconnaissance**, allowing attackers to identify targets for further exploitation.

By restricting anonymous enumeration, the system enforces proper authentication before revealing sensitive information about accounts or shared resources.

Because this directly reduces the system’s exposure to unauthenticated reconnaissance, DISA classifies this as a **CAT I (High Severity)** finding.

---

### What the STIG checks
The system is considered **non-compliant** if the following registry value is missing or incorrectly configured:

- **Registry Hive:** `HKEY_LOCAL_MACHINE`
- **Registry Path:**
