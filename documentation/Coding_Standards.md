# Wols CA Coding Standards & Engineering Philosophy

## 1. Core Philosophy: Beginner Readability & KISS
Code in the Wols CA ecosystem must be readable, maintainable, and understandable by beginner programmers.
- **Compiler Optimization vs. Code Complexity**: Modern optimizing compilers (Intel oneAPI, MSVC, GCC, Clang) generate highly efficient machine code from simple, straightforward constructs. Never write overly complex, terse, or obscure code under the premise of manual optimization.
- **Clarity Over Cleverness**: Prefer explicit, clean, step-by-step logic over nested ternary operators, overly abstract template metaprogramming, or obscure language features.

---

## 2. Naming Conventions & Variable Rules
- **No Single-Letter Variables**:
  - Strictly **NO single-letter variable names** (such as `i`, `j`, `k`, `n`, `x`, `p`).
  - Always use descriptive, meaningful names (e.g., `packetIndex`, `retryCount`, `bufferOffset`, `clientIndex`).
- **Explicit Initialization**:
  - Every variable (local variables, class members, pointers, loop indices) must be explicitly initialized upon declaration.
  - In `for` and `while` loops, explicitly initialize the counter (e.g., `for (std::size_t elementIndex = 0; elementIndex < totalCount; ++elementIndex)`).

---

## 3. Explicit Memory Management
- **No Reliance on Hidden Magic**:
  - We understand resource lifecycles and avoid uncontrolled dynamic memory allocations.
  - Every allocated resource or memory buffer must have a deterministic, explicitly verified deallocation path.
  - Prevent memory leaks, dangling pointers, and double frees.

---

## 4. Control Flow & Switch-Case Rules
- **Mandatory `break;` in `switch` Statements**:
  - In every `switch` statement, **every `case` block MUST terminate with `break;`**, even if a `return;` statement immediately precedes it.
  - *Rationale*: Some compiler optimization passes and future code refactoring can inadvertently introduce fall-through bugs if `break;` is omitted.
- **Explicit Braces**:
  - All control statements (`if`, `else`, `for`, `while`, `do`) must use explicit curly braces (`{ ... }`) formatted in Allman style.

---

## 5. Library Selection: Supported Enterprise vs. Open-Source
- **Enterprise-Supported Libraries Preferred**:
  - Always prefer stable, supported, enterprise-grade libraries with active vendor support (e.g., wolfSSL, OpenSSL, libfido2, Qt).
- **Open-Source Exception Policy**:
  - Community open-source libraries are often unstable and may only be used when no enterprise alternative exists (e.g., specific reverse-engineered protocols in Home Assistant `Wols_CA_HA_Eufy`).

---

## 6. Language & Localization Standard
- **Strictly English**:
  - 100% English for all code, variable and class names, comments, commit messages, logging, error messages, and reports.
- **Multilingual UI (I18n)**:
  - User-facing text, button labels, tooltips, and dialogs are loaded from external JSON localization dictionaries.
  - Language switching is performed at runtime by selecting the language and triggering a screen refresh.
