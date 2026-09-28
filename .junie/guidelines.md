# Junie Guidelines & Standards for Wols CA Projects

## 1. Language Standards (English-Only Core)
- **Code & Identifiers**: All C++, Python, Shell, and configuration code MUST be written entirely in English (variable names, function/method names, class names, constants, enums, filenames, etc.).
- **Comments & Docstrings**: All comments, Doxygen blocks, and documentation within source files MUST strictly be in English.
- **Documentation**: All Markdown files (`README.md`, architectural designs, roadmaps, specs, guides) across all projects MUST be written in English.
- **Logging, Diagnostics & Reports**:
  - All log outputs (`LOG_INFO`, `LOG_ERROR`, console streams, debug prints, syslog, journald) MUST strictly be in English.
  - All system diagnostic reports, error codes, exceptions, and trace summaries MUST strictly be in English.

## 2. User Interface Localization (I18n via JSON Dictionary)
- **Separation of Concerns**: User-facing UI elements (labels, tooltips, dialogs, button texts, on-screen messages) MUST NOT be hardcoded in application logic.
- **JSON Language Database**:
  - UI text, labels, words, and tooltips are stored in a centralized/modular JSON dictionary (e.g. `i18n/en.json`, `i18n/nl.json`, `i18n/de.json`).
  - Switching languages is achieved by selecting the desired language identifier, loading the corresponding JSON string database, and triggering a UI screen/view refresh.
- **Distinction from System Logs**: While the UI adapts to any user-selected language dynamically via JSON, all internal logging, diagnostic dumps, and technical reports remain strictly in English.

## 3. Code Formatting & Clang Style
- **Formatting Standard**: All C/C++ source and header files MUST adhere to the project's `.clang-format` configuration.
- **Core Rules**:
  - Indentation: 4 spaces (no tabs).
  - Braces: Allman style / explicit braces for all control statements (`if`, `else`, `for`, `while`).
  - Line breaks: Consistent brace wrapping for classes, functions, namespaces, and control blocks.
  - Pointers: Consistent alignment.
  - No single-line shortcuts without braces.

## 4. Programming Principles & Readability (Beginner-Accessible & Explicit Style)
- **Extreme Readability & Maintainability ("Beginner-Clear Code")**:
  - Write clean, straightforward, self-explanatory code that can be easily understood and maintained by any developer or beginner.
  - Modern compilers optimize clean, direct code just as well as complex/obscure constructs. Avoid overly clever, esoteric, or nested modern C++ idioms.
- **Meaningful Identifiers**:
  - Always use descriptive, meaningful variable and parameter names (e.g. `packetIndex`, `retryCount`, `bufferOffset`).
  - **Forbidden**: Single-letter loop variables like `i`, `j`, `k`.
- **Explicit Variable & Loop Initialization**:
  - All variables, especially loop control and index variables, MUST be explicitly initialized before use to guarantee deterministic starting values (e.g. `for (size_t elementIndex = 0; ...)`).
- **Explicit Memory Management**:
  - Any memory allocated must be explicitly paired and released. No memory leaks, loose allocations, or hidden garbage collection assumptions.
- **Switch-Case Safety Requirement**:
  - In `switch` blocks, EVERY `case` label MUST explicitly terminate with a `break;` statement, **even if preceded by a `return;` statement** (to protect against compiler edge cases and structural oversights).
- **Library Selection & External Dependencies**:
  - Preferred to use established, robust libraries with enterprise/vendor support (like wolfSSL).
  - Avoid unstable or unvetted open-source libraries unless strictly necessary (as in community-driven bridges like `Wols_CA_HA_Eufy`).

## 5. CMake & Build Configuration Standards
- **Case-Insensitive Alphabetical File Lists**:
  - In all `CMakeLists.txt` files (and any build scripts), lists of header files (`*_HEADERS`) and source files (`*_SOURCES`) MUST be sorted in **case-insensitive alphabetical order** (A–Z, ignoring character casing, so e.g. `hs_...` is positioned alongside `H...` / `Hs...`).
  - **Purpose**: This directly matches the display order in IDE project trees (CLion, Visual Studio), making it fast and effortless to verify whether any given file is included or missing.

## 6. Hardware Architectures & Compiler Toolchain Standards (Wols CA Standard)
- **Intel & AMD (x86_64 Desktop & Cloud / Secure Cell)**:
  - **Primary Compilers**: **Intel oneAPI C/C++ Compiler (`icx` / `icpx`)** or **Microsoft Visual C++ (MSVC `cl.exe`)**.
  - **Cross-Vendor Optimization**: The modern Intel oneAPI compiler (`icx`) is built on LLVM/Clang and delivers optimal, vendor-neutral performance and vectorization (AVX2/AVX-512, AES-NI) across both Intel Core/Xeon and AMD Ryzen/EPYC processors.
  - **Optimization Flags**: `-O3 -march=x86-64-v3` / `-QxHost` (Intel LLVM) or `/O2 /arch:AVX2 /permissive-` (MSVC).
- **ARM & ARM64 (Linux / Alpine Home Assistant Containers)**:
  - **Primary Compilers**: **Native GNU GCC (`gcc` / `g++`)** or **LLVM Clang**.
  - **Profile**: Native vector extensions (NEON, SVE), ultra-compact binaries for Alpine Linux, paired with OpenSSL 3.x (Apache 2.0 license) for 100% closed-source protection.
- **ARM Cortex-M & Microcontrollers (ESP32-S3 / Embedded Nodes)**:
  - **Primary Toolchain**: **ARM GNU Toolchain (`arm-none-eabi-gcc`)** / ESP-IDF with deterministic memory budgeting.
- **Platform Tags & License Guardrails in CMake**:
  - All Wols CA projects MUST implement `WOLS_TARGET_PLATFORM` (`DESKTOP_WIN_X64`, `SECURE_LAPTOP_X64`, `HOME_ASSISTANT_ALPINE`, `CLOUD_SECURE_CELL`, `EMBEDDED_ARM`) and `WOLS_BUILD_PROFILE` (`DEV`, `TEST`, `PRODUCTION`).
  - Strict guardrails MUST be enforced in CMake:
    1. wolfSSL is strictly forbidden on `HOME_ASSISTANT_ALPINE` (preventing GPLv2 copyleft risk).
    2. wolfSSL in `PRODUCTION` requires explicit commercial license confirmation (`-DWOLS_WOLFSSL_COMMERCIAL_APPROVED=ON`).
- **Toolchain & Version Monitoring**:
  - Use `scripts/Check-ComponentVersions.ps1` to verify local compilers and libraries against upstream releases.

## 7. IDE Standards & Code Quality (JetBrains CLion Mandatory)
- **Mandatory Primary IDE**: **JetBrains CLion** is the required standard IDE for all C/C++ development.
- **Integrated Quality Tools**:
  - Enable ClangFormat using the project root `.clang-format`.
  - Enable Clang-Tidy inspections to enforce explicit variable initialization (`cppcoreguidelines-init-variables`) and descriptive identifier names (`readability-identifier-naming`).
  - Enable Clangd language engine for accurate code analysis and cross-referencing.
  - Case-insensitive project explorer tree matching `CMakeLists.txt` file sorting.

## 8. Home Assistant Real-World Testbed & Multi-Threading
- **Home Assistant Real-World Testing**:
  - All self-developed libraries MUST be tested in Home Assistant by delivering real, meaningful added value to users (e.g. `Wols_CA_HA_Eufy` for security cameras/alarms, `Wols_CA_ElectricPowerConsumption` for smart energy).
- **Strictly Event-Driven (Zero OS Timers)**:
  - Focus strictly on event-driven software architectures reacting to messages, hardware triggers, and state changes.
  - Strictly DO NOT use OS system timers; all scheduled events are evaluated deterministically via second-accurate event loops comparing timestamps and persisting state.
- **Mandatory Multi-Threading**:
  - Always execute background tasks, uploaders, watchers, and event generators in dedicated OS worker threads with safe synchronization (lock-free queues, condition variables, atomic types).

## 9. Compliance with European IT Security & Privacy Regulations
- **Regulatory Framework Alignment**:
  - All Wols CA projects strictly adhere to European cybersecurity and privacy directives: **GDPR / AVG**, **NIS2 Directive**, **EU Cyber Resilience Act (CRA)**, and **eIDAS 2.0 (IAM NextGen)**.
- **Privacy by Design & Zero Centralized PII**:
  - Zero storage of centralized Personally Identifiable Information (PII).
  - Adopt **Bring Your Own Personal Data (BYOPD)** principles where identity is verified via hardware tokens (FIDO2 / Windows Hello) and cryptographic assertions rather than storing personal accounts.
  - Ephemeral processing with aggressive data retention purging and zero residual footprint on endpoint storage.

## 10. Openness to Constructive Feedback & Continuous Improvement
- **Critique Drives Quality**:
  - We embrace and actively encourage constructive criticism, architectural scrutiny, and peer review from the developer and cybersecurity community.
  - Criticism and rigorous analysis are recognized as essential catalysts for continuous improvement, algorithmic robustness, and security maturity.
