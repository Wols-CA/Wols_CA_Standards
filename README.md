# Wols CA Standards & Engineering Guidelines

Welcome to the central **Wols CA Standards** repository. This public repository serves as the authoritative *Single Source of Truth* for architecture, coding conventions, compiler toolchains, licensing guardrails, UI internationalization, and testing methodologies across all software engineering projects within the Wols CA ecosystem.

---

## 📑 Standards Overview

| Document | Description |
| :--- | :--- |
| **[`Wols_CA_Core_Architecture.md`](documentation/Wols_CA_Core_Architecture.md)** | **Wols CA Core Architecture & Ephemeral PKI Philosophy**: Goal Zero & HSSE integration, Hardware DNA, $x.y$ Multi-Root CA Matrix, Phantom Broker, and PLACS unified access. |
| **[`Wols_CA_Security.md`](documentation/Wols_CA_Security.md)** | **Wols CA Security Architecture**: 5-Level Asset Classification, Effort Matrix, Identity Assurance Pyramid, and Cloud Secure Cell (IAM NG). |
| **[`Wols_CA_M2M.md`](documentation/Wols_CA_M2M.md)** | **Machine-to-Machine (M2M) Zero-Trust Standard**: 5-Tier Mesh, Dual-Ingress, in-memory RAM streaming, ephemeral sessions, and continuous in-flight authentication. |
| **[`Person_And_Roles.md`](documentation/Person_And_Roles.md)** | **Identity Governance & Role Delegation**: The Natural Person, bank-backed (iDIN/Itsme) vs. eIDAS identities, the privacy-preserving Mundus ID model (one MatchQuery per organisation and person returning only `true`/`false`/`NULL`, organisation-scoped unlinkable IDs, certified deletion, merger Migration ID Tables), contractor statutory employer liability transfer, and FIDO2 WorkPermits. |
| **[`Endpoint_Operational_Lifecycle.md`](documentation/Endpoint_Operational_Lifecycle.md)** | **14-Step Operational Lifecycle & Profile Model**: Master sequential human-to-workstation execution, WireGuard fixed-IP isolation, wolfSSL Hello ingress, in-memory streaming, and contractor App Attach economics. |
| **[`IDE_CLion_Standards.md`](documentation/IDE_CLion_Standards.md)** | **JetBrains CLion mandatory standard IDE**, Clang-Tidy code inspection profiles, Clangd language engine, and memory analysis settings. |
| **[`Coding_Standards.md`](documentation/Coding_Standards.md)** | Core beginner-friendly coding philosophy, meaningful variable naming (strictly NO `i`, `j`, `k`), explicit initialization, explicit memory management, mandatory `break;` in `switch` statements, and English-only policy. |
| **[`HomeAssistant_Testbed_Standards.md`](documentation/HomeAssistant_Testbed_Standards.md)** | Mandatory Home Assistant real-world testing policy (providing authentic utility such as `Wols_CA_HA_Eufy`), event-driven architecture with **zero OS timers**, and dedicated multi-threading. |
| **[`Hardware_Compilers_Matrix.md`](documentation/Hardware_Compilers_Matrix.md)** | Target compiler and optimization matrix: Intel oneAPI (`icx` / `icpx`) & MSVC for Intel/AMD x86_64; native GCC & Clang for ARM / Alpine Linux; ARM GNU Toolchain for microcontrollers. |
| **[`Architecture_ZeroTrust.md`](documentation/Architecture_ZeroTrust.md)** | 5-Tier Uploader Model, fail-fast non-retained MQTT handshakes, Admin in-memory queue governance, and Cloud Secure Cell tri-block isolation. |
| **[`EU_Compliance_Security_Privacy.md`](documentation/EU_Compliance_Security_Privacy.md)** | Full compliance with European IT Security & Privacy Directives (GDPR/AVG, NIS2, Cyber Resilience Act, eIDAS 2.0 / IAM NG) and a transparent culture open to constructive feedback and peer review. |
| **[`UI_I18n_Standards.md`](documentation/UI_I18n_Standards.md)** | Multilingual UI internationalization standards using external JSON localization dictionaries with dynamic screen refresh. |
| **[`Glossary.md`](documentation/Glossary.md)** | **Wols CA Glossary (master vocabulary)**: A–Z definitions of every Wols CA term with the defining document, Dutch equivalents and status; published read-only on the docs-site; changes via the `glossary-change-request` Issue template. |
| **[`Enterprise_README.md`](documentation/Enterprise_README.md)** | **Enterprise overview**: a one-page, non-normative summary for stakeholders, partners and auditors — why Wols CA matters, how the standards are governed, and where to start per audience. |

---

## 🛠️ Reusable Tooling & CMake Modules

- **`.clang-format`**: Universal C/C++ Allman formatting specification (4 spaces, explicit braces).
- **`.clang-tidy`**: Static analysis rules enforcing explicit initialization and variable name minimum lengths.
- **`cmake/WolsCA_CompilerFlags.cmake`**: Universal compiler optimization macro (`wols_apply_compiler_standards`).
- **`cmake/WolsCA_PlatformGuardrails.cmake`**: Automated licensing guardrails and platform tags (`wols_init_platform_guardrails`).
- **`scripts/Check-ComponentVersions.ps1`**: Automated toolchain and dependency version inspector.
- **`templates/i18n_dictionary_template.json`**: Standard BCP-47 JSON schema for UI translations.

---

## 🌐 Ecosystem Repositories
- **`Wols_CA_M2M_Lib`**: High-performance Zero-Trust M2M & Uploader Communication Library.
- **`Wols_CA_SecureLaptop`**: Enterprise SecureLaptop client with Windows Hello & FIDO2 WorkPermits.
- **`Wols_CA_HA_Eufy`**: Real-world Home Assistant integration for Eufy cameras and security systems.
- **`Wols_CA_HA_Utils`**: Shared utilities for Home Assistant container environments.

---

## 📄 License
This standards repository is published under the **Apache License 2.0**.
