# Architecture General IT Principles

| | |
|---|---|
| **Purpose** | Defines the ten general architectural characteristics that **every** Wols CA architecture, standard and design artefact — computer/hardware architecture, software architecture, security architecture, HSSE/PLACS architecture and process/organisational architecture alike — must be critically checked against, regardless of the specific technical domain. |
| **Audience** | Architect, Subject Matter Expert, Product Owner, Tester/QA-Lead (design review), all Worker Plane roles producing `/docs/arch/*.md`. |
| **Sources** | *Computer Architecture*, A.J. van de Goor & H.A. Spanjersberg (academic source, TU Delft context; owner-provided excerpt, 2026-09-27; no further independent bibliographic record of this specific title/co-authorship was found in public catalogues — see §4). |
| **Related** | [Wols_CA_Core_Architecture.md](Wols_CA_Core_Architecture.md) · [Architecture_ZeroTrust.md](Architecture_ZeroTrust.md) · [Coding_Standards.md](Coding_Standards.md) · `Wols_CA_LifeCycleManagementLandscape/Documentation/Computer Architectuur/General_IT_Architectural_Principals.md` · Glossary: [Glossary.md](Glossary.md) |
| **Last reviewed** | 2026-09-27 |

> **Normative status**: this document is normative for the Architect role. Every architecture artefact produced by the software factory (`/docs/arch/*.md`) must be reviewed against the ten principles in §1 before it is approved by the Tripartite Panel. This is **not** limited to computer/hardware architecture — the source explicitly frames these as *general* characteristics of "any solution or architecture", so they apply equally to security architecture, identity architecture, HSSE/PLACS design and process architecture.

---

## 1. The ten principles

A good solution or architecture must be: **consequent, orthogonal, singular, thrifty, complete, balanced, transparent, general, open, scalable.**

| # | Principle | Definition | Illustrative example (from the source) |
|---|---|---|---|
| P1 | **Consequent** | With limited knowledge of one part of the system, the behaviour of the rest of the system is predictable. | OK/Cancel buttons should look and behave the same throughout an application suite (e.g. printing works the same way in every application of an office suite). |
| P2 | **Orthogonality** | Independent functions are kept separate in their specification (separation of concerns). | A clock's "illuminate display" function and its "alarm" function must be independent; the alarm must not depend on the display being lit. |
| P3 | **Singularity** | Every specified function must trace back to a real requirement of the system; nothing is added merely as a workaround. | A car's manual gearbox is not a requirement of driving — it exists only because of the engine's power limitation. |
| P4 | **Thrift** | Functions that are not typical to the system's purpose are left out, even if they could be added at zero marginal cost. | Adding "multiply character strings" to a computer architecture just because it is technically possible violates thrift. |
| P5 | **Completeness** | When several functions belong to the same logical class, all of them are made available, not an arbitrary subset. | If a computer can multiply two numbers, it should also be able to divide two numbers. |
| P6 | **Balance** | The functionality actually implemented is kept proportionate to real usage; effort is not spent on capability disproportionate to the system's purpose. | Full complex-number arithmetic would be a bridge too far for a system designed purely for word processing. |
| P7 | **Transparent** | The internal working of the architecture is inspectable and understandable rather than opaque, so behaviour can be reasoned about and verified. | *(worked example not yet available from the excerpt received — see §4 open point)* |
| P8 | **Generality** | The architecture solves a class of problems, not one narrow instance, so it remains applicable as requirements evolve. | *(worked example not yet available from the excerpt received — see §4 open point)* |
| P9 | **Openness** | The architecture can be extended, inspected and integrated with by third parties, rather than being a closed, single-vendor construct. | *(worked example not yet available from the excerpt received — see §4 open point)* |
| P10 | **Scalability** | The architecture continues to function correctly, and at acceptable cost/performance, as load, data volume or scope grow. | *(worked example not yet available from the excerpt received — see §4 open point)* |

## 2. Binding review rule

Every `/docs/arch/*.md` artefact, and every revision of `Wols_CA_Core_Architecture.md`, `Architecture_ZeroTrust.md`, `Wols_CA_M2M.md`, `Wols_CA_Security.md` and `Hardware_Compilers_Matrix.md`, must state — explicitly or via the Architect's review notes — how it satisfies or deliberately trades off each of the ten principles in §1. A **deliberate trade-off** (e.g. sacrificing generality for singularity/thrift) is acceptable and expected; an **unexamined** violation is not. The Architect records this check; the SME and Tester/QA-Lead may challenge it during Tripartite Panel review.

## 3. Cross-reference to already-normative Wols CA principles

| Principle (§1) | Already-normative Wols CA equivalent | Relationship |
|---|---|---|
| P3 Singularity, P4 Thrift | **Data Classification / Effort Matrix** ([Wols_CA_Security.md](Wols_CA_Security.md) §3–4): extreme measures are applied strictly where required, avoiding over-engineering. | Direct application: the Effort Matrix is Wols CA's operational instrument for enforcing singularity and thrift. |
| P9 Openness | **Absolute Mutual Trust & Source Code Custody**, **Zero Vendor Lock-In** ([Wols_CA_Core_Architecture.md](Wols_CA_Core_Architecture.md) §1, §2 tenet 4). | Direct application: source-code handover and hardware-agnostic adaptability are Wols CA's concrete implementation of openness. |
| P6 Balance | Multi-Tier Capability & Lifecycle Governance ([Wols_CA_Core_Architecture.md](Wols_CA_Core_Architecture.md) §3): security effort scaled to client tier (public/NGO/enterprise/government). | Related: balance is the general principle behind the tiered, cost-proportional model. |
| P10 Scalability | **x.y Multi-Root CA Matrix**, 5-minute recovery protocol ([Wols_CA_Core_Architecture.md](Wols_CA_Core_Architecture.md) §1); **5-Tier Uploader Mesh** ([Architecture_ZeroTrust.md](Architecture_ZeroTrust.md) §2). | Related: both are concrete scalability/resilience mechanisms; not yet explicitly framed as satisfying "scalability" as a named review criterion. |
| P1 Consequent, P2 Orthogonality, P5 Completeness, P7 Transparent, P8 Generality | Not yet explicitly named as review criteria anywhere in the Standards. | **New** — to be applied going forward under the binding review rule in §2. |

## 4. Open points for the Architect / SME / Product Owner

1. **Source verification**: the excerpt was provided directly by the owner; an independent, citable bibliographic record specifically confirming "A.J. van de Goor & H.A. Spanjersberg" as joint authors of a title named *Computer Architecture* could not be located in public catalogues at review time (a well-known related English-language work is A.J. van de Goor, *Computer Architecture and Design*, Addison-Wesley, 1989, ISBN 0201182416 — TU Delft affiliated — but this does not list a co-author named Spanjersberg). This should be corrected/confirmed by whoever holds the physical source (e.g. exact title, publisher, year, and Spanjersberg's affiliation) so the citation in the header table can be made fully precise.
2. Worked examples for **transparent (P7)**, **generality (P8)**, **openness (P9)** and **scalability (P10)** are still missing and should be added once the relevant pages of the source are available.
3. Whether this document should also be referenced from the **Architect persona prompt** as a mandatory design-review checklist (engine-neutral wording only, per ADR-005).

Per Glossary governance ([Glossary.md](Glossary.md) §1: "no artefact may introduce a term that is not in this Glossary"), the ten terms in §1 have been proposed as **Draft** rows — see [Glossary.md](Glossary.md) §3.
