## [WN11-CC-000190 — Autoplay Disabled for All Drives](https://www.stigaview.com/products/win11/v1r5/WN11-CC-000190/)

### Overview
This STIG ensures **Autoplay is disabled for all drive types**, including removable, optical, and network drives. Disabling Autoplay prevents Windows from automatically reading or executing content when media is inserted or accessed.

---

### Why this matters
Autoplay can automatically start reading from a drive as soon as media is inserted. While convenient, this behavior creates security risk:

- Malicious media can trigger **automatic execution paths**
- Setup files or scripts may launch without user intent
- Attackers often leverage removable or network drives to introduce malware

Although Windows disables Autoplay for some drive types by default, this STIG requires it to be **explicitly disabled for all drives** to eliminate ambiguity and reduce attack surface.

Because this directly mitigates a common malware delivery mechanism, DISA classifies this as a **CAT I (High Severity)** finding.

---

### What the STIG checks
The system is considered **non-compliant** if the following registry value is missing or incorrectly configured:

- **Registry Hive:** `HKEY_LOCAL_MACHINE`
- **Registry Path:**
