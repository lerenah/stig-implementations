## [WN11-SO-000205 — LAN Manager Authentication Level Enforced (NTLMv2 Only)](https://www.stigaview.com/products/win11/v1r5/WN11-SO-000205/)

### Overview
This STIG ensures the system is configured to **use NTLMv2 authentication only and to refuse older, weaker authentication protocols (LM and NTLM)**. Enforcing NTLMv2 reduces the risk of credential compromise and strengthens authentication security.

---

### Why this matters
Windows systems support multiple authentication protocols for compatibility reasons. Older protocols such as **LAN Manager (LM)** and **NTLM** are significantly weaker and vulnerable to credential interception and offline password cracking.

Risks of allowing LM or NTLM include:
- Weaker cryptographic protection of credentials
- Increased exposure to **credential harvesting and replay attacks**
- Easier lateral movement once credentials are captured

By enforcing NTLMv2 only, the system ensures modern authentication protections are used and legacy protocols are explicitly refused.

Because authentication weaknesses can lead directly to system compromise, DISA classifies this as a **CAT I (High Severity)** finding.

---

### What the STIG checks
The system is considered **non-compliant** if the following registry value is missing or incorrectly configured:

- **Registry Hive:** `HKEY_LOCAL_MACHINE`
- **Registry Path:**
