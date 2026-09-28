# ==============================================================================
# WOLS CA IT SECURITY - UNIVERSAL COMPILER FLAGS & OPTIMIZATION CONFIGURATION
# ==============================================================================

function(wols_apply_compiler_standards TARGET_NAME)
    if(NOT TARGET ${TARGET_NAME})
        message(FATAL_ERROR "[Wols CA CMake] Target '${TARGET_NAME}' does not exist!")
    endif()

    # Enforce C++17 Standard
    set_target_properties(${TARGET_NAME} PROPERTIES
        CXX_STANDARD 17
        CXX_STANDARD_REQUIRED ON
        CXX_EXTENSIONS OFF
    )

    # Apply Hardware & Compiler Optimized Flags.
    # Optimization flags are restricted to non-Debug configurations: CLion's default Debug
    # profile adds /RTC1 (MSVC runtime checks), which is incompatible with /O2 or -O3
    # (cl.exe error D8016). Warnings are always applied.
    if(CMAKE_CXX_COMPILER_ID MATCHES "IntelLLVM" OR CMAKE_CXX_COMPILER_ID MATCHES "Intel")
        message(STATUS "[Wols CA Toolchain] Applying Intel oneAPI (icx) Optimizations to ${TARGET_NAME}")
        if(MSVC)
            target_compile_options(${TARGET_NAME} PRIVATE /W4 /permissive- $<$<NOT:$<CONFIG:Debug>>:-QxHost -O3>)
        else()
            target_compile_options(${TARGET_NAME} PRIVATE -Wall -Wextra -Wpedantic $<$<NOT:$<CONFIG:Debug>>:-march=x86-64-v3 -O3>)
        endif()
    elseif(MSVC)
        message(STATUS "[Wols CA Toolchain] Applying Microsoft Visual C++ (MSVC) Options to ${TARGET_NAME}")
        target_compile_options(${TARGET_NAME} PRIVATE /W4 /permissive- $<$<NOT:$<CONFIG:Debug>>:/O2 /arch:AVX2>)
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        message(STATUS "[Wols CA Toolchain] Applying LLVM Clang Options to ${TARGET_NAME}")
        target_compile_options(${TARGET_NAME} PRIVATE -Wall -Wextra -Wpedantic $<$<NOT:$<CONFIG:Debug>>:-O3>)
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        message(STATUS "[Wols CA Toolchain] Applying GNU GCC Options to ${TARGET_NAME}")
        target_compile_options(${TARGET_NAME} PRIVATE -Wall -Wextra -Wpedantic $<$<NOT:$<CONFIG:Debug>>:-O3>)
    else()
        target_compile_options(${TARGET_NAME} PRIVATE -Wall -Wextra)
    endif()
endfunction()
