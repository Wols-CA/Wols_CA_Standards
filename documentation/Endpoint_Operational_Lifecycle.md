# Wols CA Endpoint Governance: The 14-Step Operational Lifecycle & Profile Model

## 1. Executive Summary & Purpose
The **Wols CA Secure Endpoint Architecture** (`SecureLaptop`, `Mini-PC`, `Secure Desktop`) establishes a zero-trust workplace by strictly decoupling the verified natural person from corporate enterprise accounts and local persistent hardware.

A **Profile** represents the deterministic binding between *one authorized role of one verified natural person* and the complete operating environment: the dedicated single-tenant OS desktop image, software licensing layers, security controls, and network policies.

---

## 2. The Master 14-Step Sequential Human-to-Machine Workflow

The end-to-end journey from human identity to secure in-memory execution executes in 14 strictly chronological steps:

```
+---------------------------------------------------------------------------------------------------+
|                                MASTER 14-STEP OPERATIONAL LIFECYCLE                               |
+---------------------------------------------------------------------------------------------------+
|                                                                                                   |
|  [PHASE A: OUT-OF-BAND PHONE AUTHENTICATION & ROLE AUTHORIZATION]                                 |
|  1. Personal Authentication: Sovereign eID (Bank-backed iDIN/Itsme vs. European eIDAS 2.0).       |
|  2. Multi-Organization Role Discovery: Mundus ID directory maps person to available roles.       |
|  3. Two Scenarios: Own Staff (direct) vs. Contractor (Mandatory Employer Liability Transfer).     |
|  4. Organization Policy Authorization: Hiring party validates geofence, time window, and context.  |
|  5. Profile Resolution: Resolves OS desktop image, software rights, and hardware limitations.     |
|  6. FIDO2 Key Loading: Smartphone app writes encrypted WorkPermit with M2M bootstrap data.       |
|                                                                                                   |
|  [PHASE B: HARDWARE PRE-BOOT & SECURE NETWORK INGRESS]                                            |
|  7. Custom BIOS + Proxmox Boot: Key inserted in arbitrary USB port of powered-off machine.       |
|  8. WireGuard Fixed-IP Tunnel: Isolated RFC 1918 tunnel (no public DNS; org-DNS inside tunnel).  |
|  9. Hello Uploader with wolfSSL: Connects directly to Hello Uploader behind WireGuard shield.     |
|  10. M2M Handshake Completion: 5-Tier Zero-Trust convergence (Hello -> Logon -> Production).      |
|                                                                                                   |
|  [PHASE C: IN-MEMORY WORKSPACE EXECUTION & CONTINUOUS GOVERNANCE]                                 |
|  11. Production Uploader Delivery: Validates/streams OS into RAM and triggers start command.      |
|  12. In-OS User Logon: Exact same natural person logs in; immediate shutdown on mismatch.        |
|  13. Presence Sensing & Lockdown: Camera, mmWave (respiration), ring; certified USB keyboard/mouse.|
|  14. Contractor Economics & App Attach: Single-tenant; shared Read-Only App Layer (per-person).   |
|                                                                                                   |
+---------------------------------------------------------------------------------------------------+
```

---

### Step 1: Personal Authentication & Sovereign Digital Identity
* User authenticates out-of-band on their smartphone.
* **Bank-Backed eID (iDIN / Itsme)** is mandatory/prioritized for Level 5 (Top Secret) due to continuous financial KYC/AML attestation; **European eIDAS 2.0** accepted for Level 2–4.

### Step 2: Multi-Organization Directory & Role Association
* Wols CA Mundus ID directory displays all corporate organizations where the verified individual holds active assignments.
* User selects **Organization First**, then **Role Second**.

### Step 3: Staff vs. Contractor Statutory Employer Liability Transfer
* **Own Staff**: Direct corporate IAM entitlement validation.
* **Non-Staff / Contractors**: Routed to the contractor's primary employer/agency, which cryptographically signs a legally binding assertion assuming **100% statutory liability** that all screening, certifications, and compliance mandates are active.

### Step 4: Hiring Organization Policy Engine & Contextual Authorization
* Target organization validates operational constraints: geofencing coordinates, permitted working hours, and mobile device hygiene.

### Step 5: Profile Resolution (Desktop OS Image & Capabilities)
* Authorization resolves the specific Profile, determining the single-tenant OS Golden Image, application entitlements, and hardware policies.

### Step 6: FIDO2 Key Population (WorkPermit & M2M Bootstrap Data)
* User connects registered FIDO2 key to phone (USB-C/NFC).
* Production Uploader writes encrypted, short-lived WorkPermit containing identity tuple and **M2M bootstrap parameters** (Hello Uploader fixed IP, public key, session nonce).

### Step 7: Custom BIOS + Proxmox Micro-Hypervisor Bootstrapping
* User inserts FIDO2 key into an arbitrary USB port of the **powered-off machine** and switches on power.
* Custom open-source firmware (Coreboot / SBL) and Proxmox initialize essential hardware in locked single-tenant mode.

### Step 8: WireGuard Fixed-IP Tunneling & Isolated Organizational DNS
* WireGuard establishes a tunnel to a **fixed IP address** without relying on public DNS.
* Laptop communicates strictly inside the WireGuard tunnel on private RFC 1918 subnets using organizational DNS, completely isolated from the public Internet (`INTERNET_PROHIBITED`).

### Step 9: Hello Uploader Ingress with wolfSSL TLS 1.3 Shield
* Behind WireGuard, endpoint connects directly to the `Hello Uploader` shielded with wolfSSL TLS 1.3 transport encryption.

### Step 10: M2M Handshake Completion Across 5-Tier Pipeline
* High-assurance Zero-Trust handshake converges across Hello → Logon → Production uploaders, supported by Post-Quantum Cryptography (ML-KEM / Kyber-1024, LMS / XMSS).

### Step 11: Production Uploader OS Delivery & Execution Command
* Production Uploader validates or streams the OS image (always dynamically streamed into volatile RAM for Top Secret).
* Production Uploader issues the command to execute the loaded OS image in RAM.

### Step 12: In-OS Natural Person Verification & Fail-Closed Teardown
* User logs into the operating system. If a different person attempts to log in, the system executes an **immediate, silent shutdown** and wipes RAM.

### Step 13: Continuous Presence Monitoring & Peripheral Lockdown
* Continuous presence attestation via Camera recognition, mmWave radar (vital signs / respiration), and optional heartbeat ring.
* Strict USB peripheral lockdown: all ports disabled except certified keyboard and/or mouse if authorized by central policy.

### Step 14: SBYOD Contractor Economics & Shared App Attach Licensing
* Strictly single-tenant execution (no concurrent images).
* Shared Read-Only App Attach layer (VHDX / OverlayFS) for enterprise software suites (Adobe, JetBrains, Microsoft 365) eliminates redundant licensing costs, licensed per natural person and paid once.
