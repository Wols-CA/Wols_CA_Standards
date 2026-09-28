# Wols CA — Enterprise README

| | |
|---|---|
| **Purpose** | A single-page, enterprise-facing overview of Wols CA for stakeholders, partners, auditors and new enterprise customers who need the "big picture" before diving into the detailed standards documents. It summarises and links; it does not restate or replace any normative document. |
| **Audience** | Enterprise decision-makers, partners, auditors, compliance officers, new team members outside the engineering track. |
| **Sources** | [`README.md`](../README.md) · [`Wols_CA_Core_Architecture.md`](Wols_CA_Core_Architecture.md) · [`Wols_CA_Security.md`](Wols_CA_Security.md) · [`Wols_CA_M2M.md`](Wols_CA_M2M.md) · [`Person_And_Roles.md`](Person_And_Roles.md) · [`EU_Compliance_Security_Privacy.md`](EU_Compliance_Security_Privacy.md) · [`Glossary.md`](Glossary.md). |
| **Related** | `Wols_CA_LifeCycleManagementLandscape/Documentation/Knowledge_Base.md` (single source of truth for the AI software factory that maintains this repository) · `Wols_CA_LifeCycleManagementLandscape/Documentation/decision-log.md` (ADRs). |
| **Last reviewed** | 2026-09-21 |

> **Rule of this document**: it *summarises and links*; when this page and any other Standards document disagree, that other document wins and this page must be corrected.

---

## 1. What Wols CA is

Wols CA is a Zero-Trust software architecture and engineering standard for identity, endpoint and machine-to-machine (M2M) systems. It is built on the principle that **security is designed into the hardware and process DNA from day one** ("Goal Zero"), rather than added afterwards. The standards in this repository are the single normative source for every product and project built on Wols CA — see [`Wols_CA_Core_Architecture.md`](Wols_CA_Core_Architecture.md) for the full architecture philosophy.

## 2. Why an enterprise should care

| Concern | Where Wols CA addresses it |
|---|---|
| Identity fraud / credential theft | Natural-Person-first identity model, FIDO2 WorkPermits, bank-backed and eIDAS 2.0-class identities — [`Person_And_Roles.md`](Person_And_Roles.md). |
| Data breach / lateral movement | Zero-Trust network zoning (5-Tier Uploader Mesh), Cloud Secure Cell Tri-Block isolation, no persistent PII (Zero-Footprint) — [`Architecture_ZeroTrust.md`](Architecture_ZeroTrust.md), [`Wols_CA_Security.md`](Wols_CA_Security.md). |
| Regulatory exposure | GDPR/AVG, NIS2, Cyber Resilience Act and eIDAS 2.0 alignment, plus a documented culture of responsible disclosure — [`EU_Compliance_Security_Privacy.md`](EU_Compliance_Security_Privacy.md). |
| Auditability | Hash-chained, English-only security event logging streamed to SIEM; no personal data in logs — [`Wols_CA_M2M.md`](Wols_CA_M2M.md) §6-§7. |
| Vendor/technology lock-in | Supported-enterprise vs. open-source library guardrails, documented compiler/hardware matrix — [`Coding_Standards.md`](Coding_Standards.md) §5, [`Hardware_Compilers_Matrix.md`](Hardware_Compilers_Matrix.md). |
| Contractor and multi-organisation liability | Statutory employer liability transfer, multi-organisation role discovery, shared App Attach licensing — [`Person_And_Roles.md`](Person_And_Roles.md), [`Endpoint_Operational_Lifecycle.md`](Endpoint_Operational_Lifecycle.md). |

## 3. How the standards are governed

- **Single Source of Truth**: this repository (`Wols_CA_Standards`) is normative; every other Wols CA repository derives from it and, where it keeps a local copy of a document, must carry an *Authoritative Reference* banner back to here.
- **Glossary-first**: no new term is used in any Wols CA document without a row in [`Glossary.md`](Glossary.md) (Term · Definition · Defining document · Synonyms/NL equivalent · Status). Changes go through the `glossary_change_request` Issue template.
- **Decision trail**: architecture and process decisions affecting the engineering pipeline are recorded as ADRs in `Wols_CA_LifeCycleManagementLandscape/Documentation/decision-log.md`, each with Context · Decision · Consequences · Alternatives.
- **Consensus and escalation**: the delivery pipeline requires Product Owner/Subject-Matter-Expert alignment on requirements, and any unresolved disagreement is escalated — treated as a sign of diligence, not friction.

## 4. The ecosystem at a glance

| Repository | What it delivers |
|---|---|
| `Wols_CA_Standards` (this repository) | Normative architecture, security, identity, coding, IDE, hardware/compiler, testbed, i18n and EU-compliance standards, plus the Glossary. |
| `Wols_CA_SecureLaptop` | Enterprise SecureLaptop endpoint client (Windows Hello, FIDO2 WorkPermits, 14-step operational lifecycle). |
| `Wols_CA_M2M_Lib` | High-performance Zero-Trust machine-to-machine communication library implementing the M2M standard. |
| `Wols_CA_HA_Eufy` / `Wols_CA_HA_Utils` | Real-world Home Assistant testbed integrations that validate the standards against physical hardware. |
| `Wols_CA_LifeCycleManagementLandscape` | The AI-assisted software delivery factory (roles, pipeline, infrastructure) that builds and maintains all of the above in line with these standards. |

## 5. Where to start, depending on who you are

| You are | Start here |
|---|---|
| An enterprise decision-maker or partner | This page, then [`Wols_CA_Core_Architecture.md`](Wols_CA_Core_Architecture.md) and [`EU_Compliance_Security_Privacy.md`](EU_Compliance_Security_Privacy.md). |
| A compliance officer or auditor | [`EU_Compliance_Security_Privacy.md`](EU_Compliance_Security_Privacy.md), [`Wols_CA_Security.md`](Wols_CA_Security.md), [`Person_And_Roles.md`](Person_And_Roles.md). |
| A new engineer joining a Wols CA project | The engineering [`README.md`](../README.md) §Standards Overview, then `Wols_CA_LifeCycleManagementLandscape/Documentation/Onboarding.md`. |
| A contributor proposing a new term or standard | [`Glossary.md`](Glossary.md) and its change-request template under `.github/ISSUE_TEMPLATE/`. |

## 6. Open points

- This page is new; the Documentalist and Architect should confirm it stays in sync whenever the Standards Overview table in [`README.md`](../README.md) changes.
- No new Glossary term was required to write this page; if "Enterprise README" itself is later referenced as a defined concept elsewhere, it should get a Glossary row first.
