# Wols CA Standards & Engineering Guidelines

Welcome to the central **Wols CA Standards** repository. This public repository serves as the authoritative *Single Source of Truth* for architecture, coding conventions, compiler toolchains, licensing guardrails, UI internationalization, and testing methodologies across all software engineering projects within the Wols CA ecosystem.

---

## 📑 Standards Overview

| Document | Description |
| :--- | :--- |
| **[`IDE_CLion_Standards.md`](documentation/IDE_CLion_Standards.md)** | **JetBrains CLion mandatory standard IDE**, Clang-Tidy code inspection profiles, Clangd language engine, and memory analysis settings. |
| **[`Coding_Standards.md`](documentation/Coding_Standards.md)** | Core beginner-friendly coding philosophy, meaningful variable naming (strictly NO `i`, `j`, `k`), explicit initialization, explicit memory management, mandatory `break;` in `switch` statements, and English-only policy. |
| **[`HomeAssistant_Testbed_Standards.md`](documentation/HomeAssistant_Testbed_Standards.md)** | Mandatory Home Assistant real-world testing policy (providing authentic utility such as `Wols_CA_HA_Eufy`), event-driven architecture with **zero OS timers**, and dedicated multi-threading. |
| **[`Hardware_Compilers_Matrix.md`](documentation/Hardware_Compilers_Matrix.md)** | Target compiler and optimization matrix: Intel oneAPI (`icx` / `icpx`) & MSVC for Intel/AMD x86_64; native GCC & Clang for ARM / Alpine Linux; ARM GNU Toolchain for microcontrollers. |
| **[`Architecture_ZeroTrust.md`](documentation/Architecture_ZeroTrust.md)** | 5-Tier Uploader Model, fail-fast non-retained MQTT handshakes, Admin in-memory queue governance, and Cloud Secure Cell tri-block isolation. |
| **[`UI_I18n_Standards.md`](documentation/UI_I18n_Standards.md)** | Multilingual UI internationalization standards using external JSON localization dictionaries with dynamic screen refresh. |

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
