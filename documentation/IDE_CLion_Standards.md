# JetBrains CLion IDE Standards & Code Quality Configuration

## 1. Mandatory Standard IDE
**JetBrains CLion** is the **mandatory primary IDE standard** across all Wols CA C and C++ software engineering projects.

### Why JetBrains CLion is Mandatory:
1. **First-Class CMake & Toolchain Integration**: Seamless switching between Intel oneAPI (`icx`), MSVC (`cl.exe`), GCC, and Clang toolchains.
2. **Deep Static Analysis Engine**: Integrated Clangd, Clang-Tidy, and JetBrains inspections executing in real-time.
3. **Strict Formatting Enforcement**: Native integration with `.clang-format` ensures 100% style consistency across all developer workstations and OS environments.
4. **Memory Profiling & Sanitizers**: Built-in integration with Valgrind, AddressSanitizer (ASan), and LeakSanitizer for explicit memory management validation.

---

## 2. CLion Code Quality & Inspection Settings

To guarantee beginner-readable, highly maintainable, and defect-free code, all CLion workspaces must configure the following inspection profiles:

### 2.1 Clang-Format Integration
* **Path**: `Settings / Preferences` $\rightarrow$ `Editor` $\rightarrow$ `Code Style` $\rightarrow$ `C/C++`
* **Setting**: Check **`Enable ClangFormat`**.
* **Source**: Choose **`Use .clang-format file from project root`**.
* **Actions on Save**:
  * Check **`Reformat code`** (`Settings` $\rightarrow$ `Tools` $\rightarrow$ `Actions on Save`).
  * Check **`Optimize imports` / clean trailing whitespace**.

### 2.2 Clang-Tidy Inspections
* **Path**: `Settings / Preferences` $\rightarrow$ `Editor` $\rightarrow$ `Inspections` $\rightarrow$ `C/C++` $\rightarrow$ `Clang-Tidy`
* **Setting**: Enabled with project `.clang-tidy` config.
* **Key Checks Enforced**:
  * `readability-identifier-naming`: Prohibits single-letter variables (`i`, `j`, `k`).
  * `cppcoreguidelines-init-variables`: Forces explicit initialization of all local and loop variables.
  * `bugprone-switch-missing-default-case`: Ensures thorough switch-case completeness.
  * `misc-redundant-expression`: Catches logic bugs early.

### 2.3 Clangd Language Engine
* **Path**: `Settings / Preferences` $\rightarrow$ `Languages & Frameworks` $\rightarrow$ `C/C++` $\rightarrow$ `Clangd`
* **Setting**: Keep **`Use Clangd server`** enabled.
* **Benefits**: Accurate semantic completion, type deduction, and instant cross-reference indexing.

### 2.4 Case-Insensitive Project Tree Consistency
* In CLion, file explorer trees are listed in **case-insensitive alphabetical order**.
* All `CMakeLists.txt` files must maintain their `*_HEADERS` and `*_SOURCES` lists in matching case-insensitive alphabetical order (A–Z) so that visual inspection in CLion matches CMake build definitions exactly.

---

## 3. Recommended CLion Toolchain Configurations

### Profile 1: Windows x64 Desktop / SecureLaptop (Intel oneAPI or MSVC)
* **CMake Generator**: Ninja / Visual Studio
* **C++ Compiler**: Intel oneAPI `icx` / `icpx` or MSVC `cl.exe`
* **CMake Options**: `-DWOLS_TARGET_PLATFORM=DESKTOP_WIN_X64 -DWOLS_BUILD_PROFILE=DEV`

### Profile 2: Alpine Linux / Home Assistant Container (GCC / Clang)
* **C++ Compiler**: `gcc` / `g++` 13+ or `clang++` 17+
* **CMake Options**: `-DWOLS_TARGET_PLATFORM=HOME_ASSISTANT_ALPINE -DWOLS_BUILD_PROFILE=DEV -DENABLE_WOLFSSL=OFF`

### Profile 3: Embedded ARM Microcontrollers (ESP32-S3 / Cortex-M)
* **Toolchain**: `arm-none-eabi-gcc` or ESP-IDF toolchain.
* **CMake Options**: `-DWOLS_TARGET_PLATFORM=EMBEDDED_ARM`
