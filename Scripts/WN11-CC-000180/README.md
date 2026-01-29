## [WN11-CC-000180 — Autoplay must be turned off for non-volume devices.](https://www.stigaview.com/products/win11/v1r5/WN11-CC-000180/)

### Overview
This STIG ensures **Autoplay is turned off for non-volume devices** (such as Media Transfer Protocol (MTP) devices). Disabling Autoplay helps prevent untrusted media from automatically triggering software execution when connected to the system.

---

### Why this matters
Autoplay can automatically start reading and launching content when a device is inserted or connected. While convenient, this behavior can be abused:

- A malicious device can trigger **automatic execution paths**
- Users may unintentionally run **malware** just by plugging in a device
- Attackers commonly use removable media or connected devices to **deliver payloads** or prompt unsafe execution

This control specifically targets **non-volume devices** (e.g., MTP devices), which can still present content to the system even though they don’t behave like traditional drive letters.

Because this increases the risk of malware introduction through connected devices, DISA classifies this as a **CAT I (High Severity)** finding.

---

### What the STIG checks
The system is considered **non-compliant** if the following registry value is missing or incorrectly configured:

- **Registry Hive:** `HKEY_LOCAL_MACHINE`
- **Registry Path:**

