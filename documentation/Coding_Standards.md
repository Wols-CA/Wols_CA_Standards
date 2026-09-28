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
- **Explicit Initialization (Zero Indeterminate State)**:
  - Every variable (local variables, class members, pointers, loop indices) must be explicitly initialized upon declaration. A bare declaration such as `bool isReady;` or `uint32_t count;` is forbidden.
  - **Struct and class members** must carry a default member initializer in the header: `bool isActive = false;`, `uint16_t port = 0U;`, `Policy policy = Policy::DENY;`, `Foo* next = nullptr;`. For security-relevant enums choose the deny-by-default / most restrictive value. Plain data carriers remain `struct` with public members; classes that own behaviour keep their invariants private and hand out such structs by value.
  - **Loops**: declare and initialize the loop counter and every helper variable used inside the loop body on their own line immediately *before* the loop; the `for` header only re-assigns:
    ```cpp
    std::size_t elementIndex = 0U;
    for (elementIndex = 0U; elementIndex < totalCount; ++elementIndex)
    {
        ...
    }
    ```
    Range-based loops (`for (const auto& item : list)`) are allowed as-is.
  - Fixed-size C arrays used as output buffers must be zero-initialized (`uint8_t hashBuffer[32] = {0};`).
  - *Rationale (Wols_CA_M2M_Lib, 2026-09-19)*: an uninitialized `bool` member read as `true` under the MSVC Debug `0xCC` fill pattern and silently changed a security routing decision; Release builds masked the defect. Deterministic defaults make behaviour identical across Debug, Release and compilers.

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
