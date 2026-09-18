# ==============================================================================
# WOLS CA IT SECURITY - PLATFORM TAGS & LICENSING GUARDRAILS
# ==============================================================================

macro(wols_init_platform_guardrails)
    if(NOT DEFINED WOLS_TARGET_PLATFORM)
        set(WOLS_TARGET_PLATFORM "DESKTOP_WIN_X64" CACHE STRING "Wols CA target platform")
    endif()

    if(NOT DEFINED WOLS_BUILD_PROFILE)
        set(WOLS_BUILD_PROFILE "DEV" CACHE STRING "Wols CA build profile")
    endif()

    message(STATUS "[Wols CA Guardrails] Platform : ${WOLS_TARGET_PLATFORM}")
    message(STATUS "[Wols CA Guardrails] Profile  : ${WOLS_BUILD_PROFILE}")

    # Guardrail 1: Strictly prohibit wolfSSL on Home Assistant to prevent copyleft violation
    if(WOLS_TARGET_PLATFORM STREQUAL "HOME_ASSISTANT_ALPINE" AND ENABLE_WOLFSSL)
        message(FATAL_ERROR
            "[Wols CA SECURITY VIOLATION] wolfSSL is strictly FORBIDDEN on Home Assistant targets (${WOLS_TARGET_PLATFORM})! "
            "Home Assistant add-ons must use OpenSSL (Apache 2.0) to maintain 100% closed-source protection. "
            "Reconfigure with -DENABLE_WOLFSSL=OFF."
        )
    endif()

    # Guardrail 2: Require commercial license validation for production wolfSSL builds
    if(ENABLE_WOLFSSL AND WOLS_BUILD_PROFILE STREQUAL "PRODUCTION")
        if(NOT WOLS_WOLFSSL_COMMERCIAL_APPROVED)
            message(FATAL_ERROR
                "[Wols CA LICENSE GUARDRAIL] Production release with wolfSSL requires commercial license validation! "
                "Specify -DWOLS_WOLFSSL_COMMERCIAL_APPROVED=ON if a commercial license is active, or use OpenSSL."
            )
        else()
            message(STATUS "[Wols CA LICENSE VALIDATED] Commercial wolfSSL license verified for PRODUCTION build.")
            add_compile_definitions(WOLS_WOLFSSL_COMMERCIAL_LICENSED=1)
        endif()
    endif()
endmacro()
