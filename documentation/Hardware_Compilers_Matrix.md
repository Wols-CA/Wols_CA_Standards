# Wols CA Hardware Compilers & Target Architecture Matrix

## 1. Hardware Architecture Standards
The Wols CA ecosystem defines explicit compiler standards optimized per target CPU architecture:

| Target Architecture & Environment | Primary Compiler Standard | Optimization Flags & Profile | Transport & Crypto Standard |
| :--- | :--- | :--- | :--- |
| **Intel & AMD x86_64 Desktop / Laptops (`SecureLaptop`)** | **Intel oneAPI (`icx` / `icpx`)** or **MSVC (`cl.exe`)** | `-O3 -march=x86-64-v3` (AVX2/FMA) / `/O2 /arch:AVX2 /permissive-` | wolfSSL TLS 1.3 (Commercial in Production) / OpenSSL 3.x |
| **Intel & AMD x86_64 Cloud Secure Cell (Linux / Container)** | **Intel oneAPI (`icx`)** or **LLVM Clang (`clang++`)** | `-O3 -march=x86-64-v3 -fPIE -D_FORTIFY_SOURCE=2` | wolfSSL TLS 1.3 / OpenSSL 3.x |
| **ARM64 & Alpine Linux (Home Assistant Add-ons / Pods)** | **Native GNU GCC (`gcc` / `g++`)** or **Clang** | `-O3 -march=armv8-a+crc+crypto` | **OpenSSL 3.x (Apache 2.0 ONLY)** *(wolfSSL strictly prohibited)* |
| **ARM Cortex-M Embedded Nodes (ESP32-S3 / Microcontrollers)** | **ARM GNU Toolchain (`arm-none-eabi-gcc`)** / ESP-IDF | Bare-metal footprint minimization, explicit RAM budgets | wolfSSL Embedded / mbedTLS / Plain Unshielded |

---

## 2. Why the Modern Intel oneAPI Compiler (`icx`) is Standard for Intel & AMD
* **LLVM-Based Backend**: Modern `icx` is built on the LLVM compiler infrastructure, eliminating obsolete vendor-biases of legacy `icc`.
* **Cross-Vendor Micro-Architecture Parity**: Both Intel Core/Xeon and AMD Ryzen/EPYC share identical modern x86_64 ISA extensions (AVX2, BMI2, AES-NI, SHA-NI).
* **Deterministic Performance**: Advanced auto-vectorization and high-throughput cryptographic pipeline optimization.

---

## 3. Configuration-Aware Optimization Flags (CLion Debug Compatibility)
* Optimization flags from the matrix above apply to **Release / RelWithDebInfo / MinSizeRel** only.
* CLion's default `Debug` CMake profile injects `/RTC1` (MSVC runtime checks) and `/Od`. MSVC rejects `/RTC1` combined with `/O2` (`cl : error D8016`), so an unconditional `/O2` or `-O3` in `target_compile_options` makes the project unbuildable and undebuggable from CLion.
* Always wrap optimization flags in a generator expression, as done in `cmake/WolsCA_CompilerFlags.cmake`:
  ```cmake
  target_compile_options(${TARGET} PRIVATE /W4 /permissive- $<$<NOT:$<CONFIG:Debug>>:/O2 /arch:AVX2>)
  ```
* Warning flags (`/W4`, `-Wall -Wextra -Wpedantic`) are applied to every configuration.

---

## 4. Platform Tags & Build Profiles
All CMake builds must specify the target platform and build profile:
```bash
# Target Platforms
-DWOLS_TARGET_PLATFORM=DESKTOP_WIN_X64
-DWOLS_TARGET_PLATFORM=SECURE_LAPTOP_X64
-DWOLS_TARGET_PLATFORM=HOME_ASSISTANT_ALPINE
-DWOLS_TARGET_PLATFORM=CLOUD_SECURE_CELL
-DWOLS_TARGET_PLATFORM=EMBEDDED_ARM

# Build Profiles
-DWOLS_BUILD_PROFILE=DEV
-DWOLS_BUILD_PROFILE=TEST
-DWOLS_BUILD_PROFILE=PRODUCTION
```
