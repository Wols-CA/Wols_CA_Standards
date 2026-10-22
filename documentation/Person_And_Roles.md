# Wols CA Identity Governance: The Natural Person, Privacy-Preserving Mundus ID Matching & Role Delegation

> **Authoritative Ecosystem Reference**: See `Wols_CA_Standards/Documentation/Person_And_Roles.md` for the single source of truth standard.

## 1. Executive Summary & Core Identity Philosophy
In traditional enterprise Identity and Access Management (IAM), user identity is tightly coupled to corporate Active Directory / Entra ID accounts, leading to credential sprawl, shared account abuse, and weak identity verification.

Wols CA enforces a fundamental paradigm shift: **Decoupling the Verified Natural Person from Enterprise Roles and Ephemeral Workspaces**. 

Identity assurance is established through out-of-band sovereign digital identities, a privacy-preserving **Mundus ID** matching service that never discloses personal attributes to organisations (one MatchQuery per organisation and person, organisation-scoped unlinkable IDs — see §2.3–§2.7), person-only role discovery, statutory employer liability assumption for contractors, and hardware-bound **FIDO2 WorkPermits**.

### 1.1 Institutional Governance & Separation of Concerns: EU and European Banking Stewardship
Because Mundus ID operates as a sovereign matching and privacy-preservation framework for Natural Persons (interfacing with national eIDAS 2.0 digital identity wallets, banking KYC/AML infrastructure, and civil registries), its governance is structurally decoupled from commercial software operations and device fleet management:
* **Public-Private Institutional Stewardship**: Mundus ID is designed to be governed and operated by an independent, trusted public-private authority owned and steered collaboratively by the **European Union and European Banks** (the authoritative anchors of trusted digital identity and continuous KYC compliance).
* **Decoupling from Device & Fleet Management**: The matching service for Natural Persons operates entirely independently from hardware device registries (which manage physical endpoints and enterprise asset ownership).

---

## 2. The Two Classes of Electronic Identity (eID)

When a user initiates authentication on their smartphone, Wols CA supports two primary classes of identity providers via **Wols CA Mundus ID**:

```
+---------------------------------------------------------------------------------------------------+
|                                     WOLS CA MUNDUS ID GATEWAY                                     |
+---------------------------------------------------------------------------------------------------+
|                                                                                                   |
|  [ CLASS 1: BANK-BACKED IDENTITIES ]              [ CLASS 2: EUROPEAN eID / eIDAS 2.0 ]           |
|  • iDIN (The Netherlands)                         • National eID (e.g., DigiD, Itsme, BankID)     |
|  • Itsme (Belgium / Enterprise Banking)           • Qualified eIDAS 2.0 Digital Wallets           |
|  • Strict ongoing KYC / AML Banking Validation    • Government Identity Assurance                 |
|                                                                                                   |
|  ==> MANDATORY / STRONGLY PREFERRED FOR           ==> ACCEPTED FOR INTERNAL / CONFIDENTIAL        |
|      LEVEL 5 (TOP SECRET) WORKLOADS                   WORKLOADS (LEVEL 2 - 4)                     |
+---------------------------------------------------------------------------------------------------+
```

### 2.1 Class 1: Bank-Backed Identities (iDIN / Itsme)
* **High-Assurance Banking KYC**: Bank-verified identities are subject to rigorous, continuous Anti-Money Laundering (AML) and Know-Your-Customer (KYC) regulatory compliance, in-person passport verification, and daily active bank account monitoring.
* **Mandatory for Top Secret (Level 5)**: Because of continuous financial institution attestation, Wols CA **mandates or strongly prioritizes bank-backed identities for all Top Secret and mission-critical governance workloads**.

### 2.2 Class 2: European eID & eIDAS 2.0 Wallets
* **Governmental Assurance**: National eID systems (e.g., Belgian Itsme government tier, Nordic BankID, Dutch DigiD, and emerging eIDAS 2.0 EU Digital Identity Wallets).
* **Usage**: Permitted for Internal (Level 2), Confidential (Level 3), and Sensitive (Level 4) operational profiles based on organizational policy.

> **Governance marker (§2.3 – §2.7)**: Owner decision 2026-10-21, recorded as `ADR-075` (Status Open) in `Wols_CA_LifeCycleManagementLandscape/Documentation/decision-log.md`; wording pending Architect / SME confirmation. Statements about legal prohibitions and certification schemes in these sections are **Owner requirements**, not assertions that such law or scheme already exists.

### 2.3 Three Identifiers: Statutory NPI, Internal Mundus Person Anchor & Organisation-Scoped Mundus ID
* **The Legal EU Natural Person Identifier (NPI)**:
  * The **Natural Person Identifier (NPI)** is a statutory identifier legally regulated and defined by the European Union (e.g. under eIDAS / EU digital identity regulations) and national legislations.
  * The European Union and national authorities have the statutory power to change, evolve, or restructure the syntax, length, and format of the Natural Person Identifier over time (as demonstrated by historical European and national identity transformations).
  * The NPI strictly retains whatever format, structure, or encoding is legally mandated by the EU or national governments. Mundus ID **never discloses an NPI** to an organisation.
* **Mundus Person Anchor (Internal, Never Disclosed)**:
  * Inside Mundus ID, one natural person is represented by one lifelong internal **Mundus Person Anchor**. The anchor is a database-compliant, collision-resistant hexadecimal primary key (canonical primary keys, B-tree/LSM indexing efficiency, strict normalization, immutability, zero external syntactic dependencies).
  * The anchor **never leaves Mundus ID**: it is not returned by any query, not written to any WorkPermit, and not shared with any organisation, relying party or identity provider.
  * **1-to-Many / Multi-NPI Binding (The Person Remains the Exact Same Person)**: the anchor links **multiple different NPIs to one person**: (1) multiple national NPIs for dual or multiple European nationalities; (2) changing or evolving NPI formats when the EU or national authorities update their statutory identity schema; (3) document and credential renewals at national identity registers. The human person remains the exact same unified person throughout their entire lifetime, regardless of divergent, evolving, or restructured NPIs. When a person holds multiple nationalities, they choose which one is used for the initial registration; the others are bound to the same anchor afterwards.
  * **Escrow-Protected Bindings**: the binding table *anchor ↔ organisation-scoped Mundus ID* is encrypted under the judicially gated 3-of-3 key escrow described in `Wols_CA_LifeCycleManagementLandscape/Documentation/Knowledge_Base.md` §3.1 and `Internet IDs/Architecture_Internet_IDs.md` §4. A judicial order is the **only** route by which an organisation-scoped ID can be resolved to a person; such a procedure is never started by, and never reports to, an organisation.
* **Organisation-Scoped Mundus ID (The Only Identifier an Organisation Receives)**:
  * An organisation that successfully registers a natural person (§2.5) receives a **Mundus ID that is specific to that organisation** (`mundus_id`, collision-resistant hexadecimal string, e.g. `4A8F9C1E2B3D4F5A6B7C8D9E0F1A2B3C`).
  * The value is **random and table-bound**: Mundus ID stores `(anchor, organisation) → mundus_id` in the escrow-protected binding table. It is **not derived** from the anchor, the NPI or the organisation, so no party can recompute it, and a fresh value can be issued after a certified deletion (§2.6).
  * **Different per organisation, unlinkable by design**: the same person has a different, unrelated Mundus ID at every organisation (and at their private persona). Organisations **must not** exchange, join or correlate Mundus IDs with each other; the Owner requires this to be prohibited by law and contract (legal basis to be confirmed by the SME). The EUDI ARF requirement of a distinct, unlinkable pseudonym per relying party (cited in `Architecture_Internet_IDs.md`) is the supporting principle.
  * **Stable across identity providers**: whether the person later authenticates through eID, iDIN or itsme, Mundus ID resolves the login to the same anchor and therefore to the same organisation-scoped Mundus ID. No new MatchQuery is needed or allowed for this.
* **Immutable Provenance Ledger**: All NPI bindings, nationality records, MatchQuery events (§2.5), deletion attestations (§2.6) and merger migrations (§2.7) are recorded in an append-only Merkle-tree audit ledger with qualified QTSP timestamps. The ledger is **designed for certification** against eIDAS 2.0, GDPR/AVG and ISO/IEC 27001/27701; certification itself is pending and is not claimed in this standard.
* **Transparent Identifier Format Evolution & Resilient Data Model**: Should the internal format, schema, encoding, or representation of the anchor or of `mundus_id` evolve over time, this transition remains **100% transparent** to organisations and private individuals; the Mundus ID data model accommodates format evolutions without breaking changes, database re-indexing, or migration downtime at organisations.

### 2.4 Data Minimisation: No Personal Attribute Disclosure, Ever
> **Architectural Key Decision (ADR-075 Invariant)**: *This section formalizes the core architectural paradigm shift from traditional "attribute-releasing identity brokers" to a "zero-attribute confirmation engine". Explicitly specifying zero attribute release is essential because it guarantees that no downstream enterprise application or Wols CA component can ever depend on centralized PII exchange.*

* **Zero Attribute Release to Organisations**: Mundus ID **does not share any sensitive personal data of a natural person with an organisation** — no name, no date of birth, no NPI / national number, no address, no nationality, no identity-document data. The only outputs an organisation ever receives are the MatchQuery result (`true` / `false` / `NULL`, §2.5), its organisation-scoped Mundus ID on `true`, and — as metadata — the identity-provider class and assurance level used.
* **Why attribute queries are rejected**: an identity broker that returns "any field you want to see" lets an organisation collect more personal data than the process requires or the person wants to share. Mundus ID therefore inverts the model: **the organisation supplies the data it already holds, and Mundus ID only confirms or denies the match**.
* **Condition Based Authentication (CBA) is not a MatchQuery**: a natural person may, from their own wallet / smartphone app, present a boolean condition proof such as `age >= 18 = true` to a merchant or venue (see `Wols_CA_LifeCycleManagementLandscape/Documentation/Role Based Access/Role Based Access (Final) 08-10-2026.md`, section "Condition Based Authentication"). A CBA proof is **initiated and decided by the person only**, is **boolean only**, is **fetched at the authoritative source** (iDIN / itsme / eID) and **never cached**, issues **no** organisation-scoped Mundus ID, and does **not** count against the single MatchQuery of §2.5. Whether a merchant must hold a statutory licence before it may *request* a CBA proof is an open governance item (`ADR-075`).
* **Source ID Change Management & Organisation Shielding**:
  * When a citizen's underlying credentials, passport numbers, civil records, or banking authentication identifiers change at the authoritative source, the Mundus ID source adapter layer ingests and reconciles these updates on the anchor.
  * Organisations remain **completely shielded** from external ID numbering changes, document renewals, or source credential migrations: their organisation-scoped Mundus ID does not change.

### 2.5 One-Time Registration: The MatchQuery Protocol
> **Architectural Key Decision (ADR-075 Invariant)**: *The protocol mechanics below (single-query consumption, indistinguishable `NULL`/`false` responses, and keyed HMAC enforcement) represent foundational security invariants designed to prevent database probing, credential dictionary attacks, and persistent attribute accumulation under European privacy law (GDPR/AVG).*

* **Who may query**: only an organisation that is **certified** for the correct handling of the personal data of its population of identities. Certification is a precondition of Mundus ID; the certifying body and scheme are to be decided (`ADR-075`). Certification is **not inherited**: a broker, IAM vendor or platform being certified does **not** make its customer organisations certified; every organisation that stores the result is certified in its own right.
* **What the organisation supplies**: the data it already holds for the person it wants to register — the **national number / NPI (required)** and optionally **date of birth, given name and surname**. The organisation decides which optional fields it wants confirmed; Mundus ID compares **all supplied fields** against the authoritative source bound to the anchor.
* **What the organisation receives**:

  | Result | Meaning | Returned with |
  |---|---|---|
  | `true` | every supplied field matches one natural person | the **organisation-scoped Mundus ID**, the identity-provider class (Class 1 bank-backed / Class 2 eID) and the assurance level |
  | `false` | the supplied fields do not all match | nothing else |
  | `NULL` | treated **identically to `false`** by the organisation: person unknown to Mundus ID, organisation not certified, **or the single query for this person was already consumed** | nothing else |

  The organisation **cannot distinguish** "unknown", "no match" and "already consumed". This prevents probing.
* **Exactly one MatchQuery per (organisation, natural person)**: the query is consumed by **any** outcome — `true`, `false` or `NULL`. After `true`, the organisation holds the Mundus ID and needs nothing else. After `false` or `NULL`, no retry is possible; the only way to obtain a new query is a Certified Deletion Attestation (§2.6). Any exception to this rule is an open governance item in `ADR-075`; none is granted by this standard.
* **How the single query is enforced without keeping personal data**:
  * On `true`, the enforcement fact is the binding `(anchor, organisation) → mundus_id` itself.
  * On `false` / `NULL` no anchor was resolved, so Mundus ID keeps a **per-organisation keyed digest** of the supplied national number (an HMAC under a Mundus-ID-internal key unique to that organisation), together with the outcome and timestamp. The digest is not reversible, is not comparable across organisations, and is the only comparison-derived data retained; the plaintext national number, date of birth and names are discarded immediately after evaluation. The retention period of the digest is a governance parameter (`ADR-075`). The digest is treated as personal data under GDPR/AVG for the purpose of records of processing.
* **No persistent attribute storage, heavy audit**: the comparison runs in volatile memory on a dedicated, isolated confirmation service that stores no attributes. Every MatchQuery (organisation, timestamp, outcome, identity-provider class) is written to the append-only audit ledger of §2.3.
* **Worked example**: a hospital holds the national number and date of birth of a new employee. It submits both. Mundus ID answers `true` and returns `7C1E...` as the hospital's Mundus ID for that person. A second submission for the same person by the hospital returns `NULL`. The same person's employer-of-record, a consulting agency, runs its own MatchQuery and receives an unrelated value `B2D9...`; neither party can tell that both values belong to the same person.

### 2.6 Certified Deletion & Re-Registration
* **Deletion must be certified**: when an organisation removes a person from its systems, the removal must be carried out through a **certified deletion process** that guarantees no data of that person remains in the organisation's live systems, backups or archives. Without such a process there is no renewed verification for that person at that organisation.
* **Certified Deletion Attestation**: the certified process delivers a `CertifiedDeletionAttestation(organisation, mundus_id, certifier, timestamp)` to Mundus ID. Mundus ID then (1) **revokes** the organisation-scoped Mundus ID, (2) clears the enforcement record for that (organisation, person) pair, and (3) allows **one** new MatchQuery.
* **Fresh, unlinkable ID on re-registration**: if the new MatchQuery returns `true`, Mundus ID issues a **new random Mundus ID**; the revoked value is never re-issued. Any data the organisation might have failed to delete therefore cannot be re-linked to the person.
* **No attestation → no re-registration**: `NULL` is returned for every attempt.
* **De-anonymisation only under judicial escrow**: resolving a Mundus ID to a person, or linking two organisations' Mundus IDs, is possible only through the 3-of-3 judicial key escrow of `Knowledge_Base.md` §3.1; never on request of an organisation, and the procedure never returns another organisation's Mundus ID to an organisation.

### 2.7 Organisation Mergers: Surviving ID Set & Migration ID Table
* **Problem**: when two or more organisations merge their personnel systems, the same natural person may exist in several of them, each under a different organisation-scoped Mundus ID. The merged organisation needs **one** Mundus ID per person, but the merging organisations are **not allowed** to join their tables themselves (§2.3).
* **Mundus ID performs the migration**, triggered only by a `CertifiedMergerAttestation(merging organisations, surviving legal entity, certifier, timestamp)` from the certified process; every merging organisation and the surviving legal entity must be certified. Without the attestation no migration takes place.
* **Surviving ID set**: the ID set of the merging organisation that holds the **largest number of active (non-revoked) Mundus IDs** at attestation time remains unchanged. Tie-break: the organisation whose scope was certified earliest.
* **Migration ID Table** for every other merging organisation: Mundus ID looks up, inside its own binding table, the anchor behind every active Mundus ID of the non-surviving organisation and checks whether that anchor already holds an ID in the surviving set (Owner decision 2026-10-21):
  * **found in the surviving set** (the person is present in both organisations): the old ID maps to that existing surviving ID (one person, one ID) and is written to the table as a row `old Mundus ID → surviving Mundus ID`;
  * **not found in the surviving set** (the person exists only in the non-surviving organisation): the **existing Mundus ID remains the same** for the merged organisation. Mundus ID imports the value **as is** into the surviving set — the single version of the truth — by re-binding `(anchor, surviving scope) → existing mundus_id`. No new ID is issued and no row is needed in the table; the merged organisation keeps using the value it already holds. Because every Mundus ID is a collision-resistant random value, an imported ID cannot clash with an existing surviving ID; Mundus ID verifies this on import.
  * The table therefore contains **only the duplicate persons**, as **ID pairs only** — no attributes, no anchor, no identity-provider information — and is delivered to the merged legal entity solely for application on the non-surviving organisation's personnel system. It is never delivered to a third party.
* **No MatchQuery is consumed** by a merger migration; the single-query enforcement records of all merging scopes are **unioned** into the surviving scope, so a person already matched by any predecessor organisation counts as consumed for the merged organisation.
* **Closure**: after a governance-defined migration window the **remapped** old IDs (the left-hand values of the Migration ID Table) are revoked and the non-surviving scopes are closed; the imported IDs stay active as members of the surviving set. Migration ID Tables fall under the Certified Deletion obligation of the surviving entity.
* **Worked example**: organisation A holds 12 000 active Mundus IDs, organisation B holds 3 000; 1 000 persons are present in both. A's ID set survives. B's Migration ID Table has 1 000 rows, mapping those persons' B IDs to their existing A IDs; the other 2 000 B IDs are not found in A's set and are imported unchanged into the surviving set, so those persons keep the Mundus ID B already used. The merged organisation ends with 14 000 Mundus IDs (12 000 + 2 000 imported); a later MatchQuery by the merged organisation for any of these persons returns `NULL`.
* **Open items** (`ADR-075`): length of the migration window; handling of de-mergers and divestitures (proposal: Certified Deletion of the divested population followed by fresh registration by the new entity); whether the surviving entity must re-certify.

### 2.8 Endpoint Device Governance: Device & Organisation Registry Service, Mundus Device ID, NXP MCX N947 Vault & Dual Device Roles
While Mundus ID is primary for the sovereign identification and privacy-preserving matching of **Natural Persons**, hardware endpoints (Secure Laptops, Mini-PCs, and Servers) and legal entities are governed by an integrated device identity and governance model anchored in the **Device & Organisation Registry Service**, the **Mundus Device ID**, and the **Mundus Organisation ID**:

* **Central Device & Organisation Registry Service**:
  * Endpoint devices and participating legal entities are registered in an authoritative **Device & Organisation Registry Service** within the Wols CA Trust Framework.
  * The registry provisions and validates unique, immutable **Mundus Device IDs** (`device_mundus_id`) and binds each physical machine to the legal **Mundus Organisation ID** (`owner_organization_id`) of its owning enterprise or contracting agency.
  * **Ingress Validation**: During network admission, the Wols CA ingress gateway cross-references the endpoint's cryptographic identity against the registry to ensure the hardware is genuine, unrevoked, and authorized for use by the designated organisation.

* **NXP MCX N947 Hardware Vault & Local Audit Logging**:
  * Every physical endpoint houses a dedicated, radio-less **NXP MCX N947 Hardware Security Vault** installed in the internal M.2 Wi-Fi slot (Key-E form factor, communicating with the motherboard chipset over internal USB 2.0 lines).
  * The vault (equipped with an EdgeLock® secure enclave, Physical Unclonable Function [PUF], and isolated secure flash) permanently stores the `device_mundus_id`, `owner_organization_id`, and `KeyShareA` (for RAM-disk split-key unlock).
  * It operates as an append-only, tamper-resistant **Hardware Lifecycle & Audit Register**, recording pre-boot and runtime hardware events: firmware measured hashes (PCRs), WorkPermit injections, boot timestamps, active operational mode, and hardware health metrics.
  * **Proxmox Central Office Synchronization**: Upon boot and establishment of the secure WireGuard tunnel, the Proxmox micro-hypervisor automatically reads the audit records from the MCX N947 vault and **synchronizes them back to the Owner Organisation's central office / SIEM**, giving the legal hardware owner comprehensive visibility over hardware deployment, maintenance status, and compliance attestations.

* **Strict Privacy Boundary: Zero Person ID Logging in Hardware Vault / Device Logs**:
  * **Strict Prohibition of Person Identifiers in Device Logs**: The NXP MCX N947 Hardware Vault audit log, and the telemetry synchronized back to the Device Owner Organisation, **MUST NEVER record, store, or transmit the Mundus Person ID, Person Anchor, NPI, or any personal identity attributes**.
  * **Privacy Rationale & GDPR Compliance**: In contractor and multi-organisation SBYOD scenarios, the owning organisation (e.g. consulting agency or fleet leasing entity) has zero legal entitlement or operational need to track which specific individual is performing which specific client tasks or correlate client workspace activities.
  * **Dual-Ledger Governance Model**:
    1. *Hardware Lifecycle & Device Telemetry Ledger* (synced to Device Owner Org): records hardware telemetry, boot events, PCR measurements, active operating mode (e.g., Client Organisation ID), and tamper events. Contains **zero personal data**.
    2. *Workload Session & User Audit Ledger* (managed strictly by Workload / Client Org): the user identity, person authentication events, role allocations, and session audit trails are **registered and retained solely by the Organisation for which the laptop is currently running the image (the Workload/Client Organisation)** inside that organization's own sovereign IAM/SIEM and private audit boundary.

* **The Two Distinct Device Roles & Image Execution Matrix**:
  * An endpoint is classified under one of two operational roles governed by the owner organisation's authorization engine:

  | Device Role | Operational Scope & Image Execution | Security Measurements & Presence Thresholds | Authorization & Liability Prerequisite |
  |---|---|---|---|
  | **1. Dedicated Secure Device** | **Internal Use Only**: Executes strictly the sealed Golden Image provided by the owner organization for internal confidential / Top Secret workloads. | **Maximum Strictness**: Full continuous 60/77 GHz mmWave respiration tracking, strict shoulder-surfing blanking, locked RAM overlay, zero persistent SSD writes. | Direct natural person authentication + internal role authorization. |
  | **2. Contractor Laptop / Device** | **Tri-Mode Flexibility (Governed by Owner)**:<br>• *Private Use*: Runs owner-authorized private image.<br>• *Internal Agency Use*: Runs employer corporate image.<br>• *External Client Use*: Runs client-provided workspace image. | **Graduated / Tunable**: Physical measurements and presence detection thresholds can be tuned or relaxed for contractor and private modes according to owner policy, while meeting client baseline requirements. | **Mandatory 3-Point Ingress Gateway for Client Work**:<br>1. Contractor natural person authenticated via Mundus ID.<br>2. Owning agency verifies contract validity and active terms.<br>3. Owning agency signs **100% statutory liability** (`EmployerLiabilityToken`). *If rejected, federation/boot is blocked.* |

---

## 3. The 6-Step End-to-End Authentication & WorkPermit Workflow

The complete journey from human intent to secure workstation execution follows a deterministic 6-step lifecycle:

```mermaid
sequenceDiagram
    autonumber
    actor Person as Natural Person (Smartphone)
    participant Mundus as Wols CA Mundus ID
    participant IdP as Bank (iDIN/Itsme) or eID
    participant Employer as Contractor Agency / Employer
    participant ClientIAM as Hiring Organization IAM
    participant FIDO as FIDO2 Hardware Key
    participant Laptop as Secure Laptop / Mini-PC (M2M)
    participant Hello as Hello Uploader

    Note over Person,IdP: Step 1: Sovereign Identity Attestation
    Person->>Mundus: Authenticate on Smartphone
    Mundus->>IdP: Verify Natural Person (iDIN / Itsme / eID)
    IdP-->>Mundus: Assurance Result (resolved to the internal Person Anchor; nothing forwarded to any organisation)

    Note over Person,ClientIAM: Step 2 & 3: Organization & Role Selection
    Mundus-->>Person: Present Multi-Organization & Role Catalog (visible to the person only)
    Person->>Mundus: Select Organization -> Select Role (resolves the organisation-scoped Mundus ID)

    Note over Mundus,Employer: Step 4: Contractor Employer Liability Transfer
    opt User is External Contractor / Non-Staff
        Mundus->>Employer: Request Session Pre-Authorization
        Employer->>Employer: Validate Contracts, Clearances, Certifications
        Employer-->>Mundus: Cryptographic Liability Sign-Off (100% Legal Assumption)
    end

    Note over Mundus,ClientIAM: Step 5: Hiring Org Policy & Environmental Check
    Mundus->>ClientIAM: Forward Role Request + Employer Attestation
    ClientIAM->>ClientIAM: Evaluate Context (Geofencing, Time Window, Health)
    ClientIAM-->>Mundus: Authorize Role & Generate WorkPermit

    Note over Person,FIDO: Step 6: FIDO2 WorkPermit Issuance
    Person->>Person: Connect FIDO2 Key to Smartphone (USB-C / NFC)
    Mundus->>FIDO: Write Encrypted, Short-Lived WorkPermit<br/>(Organisation-Scoped Mundus ID + M2M Hello Ingress Data)

    Note over FIDO,Laptop: Step 7: Physical Handoff & Bootstrapping
    Person->>Laptop: Insert FIDO2 Key into arbitrary USB port & Power On
    Laptop->>Hello: Direct M2M Handshake to Hello Uploader<br/>(Reads Target Host & Public Key from WorkPermit)
```

---

## 4. Key Governance Pillars

### 4.1 Multi-Organization Role Discovery & SBYOD
* A single verified natural person (e.g., a board member serving across multiple corporations, or a specialist consultant) sees a consolidated catalogue of their organisations and roles in Mundus ID. The catalogue is shown to the **person only**; no organisation can see that the person is registered elsewhere, and each organisation knows the person only under its own organisation-scoped Mundus ID (§2.3).
* The user selects **Organization First**, then **Role Second**.
* Only **one Golden Image / workspace** executes on the physical hardware at any given time (single-tenant execution). Switching roles or organizations mandates a full session termination, power cycle, and fresh out-of-band attestation.

### 4.2 Contractor Governance & Statutory Employer Liability Transfer
* **The Legal Challenge**: When an organization hires external contractors, verifying in real-time whether the individual maintains valid certifications, active background checks, valid insurance, and unrevoked employment status creates immense compliance overhead.
* **The Wols CA Solution**:
  * Before a contractor can obtain a client WorkPermit, authentication routes through their **primary employer / consulting agency**.
  * The employer's automated IAM system signs a cryptographic assertion that **contractually and legally assumes 100% statutory liability** for the contractor's credentials and compliance at that exact second.
  * The hiring client can legally rely on this guarantee without audit friction or third-party liability exposure.
  * **Separate IDs, matched inside Mundus ID**: the agency references the contractor by the agency's own Mundus ID; the hiring organisation knows the contractor only under its own Mundus ID. Mundus ID matches the liability attestation to the role request on the internal Person Anchor; the two organisation-scoped IDs are never exchanged between the parties (§2.3).

### 4.3 Person-Bound FIDO2 WorkPermit & M2M Bootstrapping
* **Person-Bound Enforcement**: The WorkPermit written to the FIDO2 hardware key is cryptographically bound to the specific natural person verified in Step 1 and carries the **organisation-scoped Mundus ID** of the selected organisation (never the internal Person Anchor or an NPI). When the laptop boots, the user at the keyboard must match this identity via facial recognition and vital-sign presence.
* **M2M Bootstrapping Parameters**: The WorkPermit contains the target **Hello Uploader network address, session nonce, and Hello public key**. For the Secure Laptop, the physical FIDO2 Key is the sole and mandatory path (completely excluding FirstContact discovery), enabling the endpoint firmware to connect directly and securely to the high-assurance `Hello Uploader`.
* **Pre-Boot Exclusivity**: The FIDO2 WorkPermit is valid strictly during the pre-boot admission sequence. It cannot be used to elevate privileges or execute commands on an already-running computer.
