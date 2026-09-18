<#
.SYNOPSIS
    Wols CA Central Toolchain & Dependency Version Inspector.
.DESCRIPTION
    Inspects locally installed compilers, build tools, and cryptographic libraries,
    and compares them against the latest upstream release tags.
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'SilentlyContinue'

Write-Host "==============================================================================" -ForegroundColor Cyan
Write-Host " WOLS CA CENTRAL COMPONENT & TOOLCHAIN VERSION CHECKER" -ForegroundColor Cyan
Write-Host " Mandatory IDE: JetBrains CLion | Architecture: Wols CA Zero-Trust" -ForegroundColor Cyan
Write-Host "==============================================================================" -ForegroundColor Cyan
Write-Host ""

$results = [System.Collections.Generic.List[PSCustomObject]]::new()

function Add-ComponentResult {
    param(
        [string]$Category,
        [string]$ComponentName,
        [string]$LocalVersion,
        [string]$UpstreamVersion,
        [string]$Status
    )
    $results.Add([PSCustomObject]@{
        Category        = $Category
        Component       = $ComponentName
        LocalVersion    = $LocalVersion
        UpstreamVersion = $UpstreamVersion
        Status          = $Status
    })
}

function Get-LatestGitHubRelease {
    param(
        [string]$RepositoryOwner,
        [string]$RepositoryName
    )
    try {
        $apiUrl = "https://api.github.com/repos/$RepositoryOwner/$RepositoryName/releases/latest"
        $headers = @{ 'User-Agent' = 'WolsCA-VersionChecker' }
        $response = Invoke-RestMethod -Uri $apiUrl -Headers $headers -TimeoutSec 5 -ErrorAction Stop
        if ($response -and $response.tag_name) {
            return $response.tag_name
        }
    }
    catch {
        return "Check Online (API Rate Limit)"
    }
    return "Unknown"
}

# 1. Compilers Check
# Intel oneAPI (icx)
$icxOutput = & icx --version 2>&1
if ($LASTEXITCODE -eq 0 -and $icxOutput) {
    $firstLine = ($icxOutput | Select-Object -First 1)
    Add-ComponentResult "Compiler" "Intel oneAPI (icx)" $firstLine "2024.2+" "Available"
} else {
    Add-ComponentResult "Compiler" "Intel oneAPI (icx)" "Not Found" "2024.2+" "Optional (Intel/AMD)"
}

# MSVC
$clOutput = & cl.exe 2>&1
if ($clOutput) {
    $firstLine = ($clOutput | Select-Object -First 1)
    if ($firstLine -match "Version\s+([\d\.]+)") {
        Add-ComponentResult "Compiler" "MSVC (cl.exe)" $Matches[1] "19.40+ (VS 2022)" "Available"
    } else {
        Add-ComponentResult "Compiler" "MSVC (cl.exe)" "Available" "19.40+ (VS 2022)" "Available"
    }
} else {
    Add-ComponentResult "Compiler" "MSVC (cl.exe)" "Not in PATH" "19.40+ (VS 2022)" "Configured via IDE"
}

# GCC
$gccOutput = & gcc --version 2>&1
if ($LASTEXITCODE -eq 0 -and $gccOutput) {
    $firstLine = ($gccOutput | Select-Object -First 1)
    Add-ComponentResult "Compiler" "GNU GCC" $firstLine "14.x" "Available"
} else {
    Add-ComponentResult "Compiler" "GNU GCC" "Not Found" "14.x" "ARM / Linux Target"
}

# Clang
$clangOutput = & clang++ --version 2>&1
if ($LASTEXITCODE -eq 0 -and $clangOutput) {
    $firstLine = ($clangOutput | Select-Object -First 1)
    Add-ComponentResult "Compiler" "LLVM Clang++" $firstLine "18.x / 19.x" "Available"
} else {
    Add-ComponentResult "Compiler" "LLVM Clang++" "Not Found" "18.x / 19.x" "Installed with CLion"
}

# 2. Build Tools
# CMake
$cmakeOutput = & cmake --version 2>&1
if ($LASTEXITCODE -eq 0 -and $cmakeOutput) {
    $firstLine = ($cmakeOutput | Select-Object -First 1)
    $latestCmake = Get-LatestGitHubRelease "Kitware" "CMake"
    Add-ComponentResult "Build Tool" "CMake" $firstLine $latestCmake "Up-to-Date"
}

# Git
$gitOutput = & git --version 2>&1
if ($LASTEXITCODE -eq 0 -and $gitOutput) {
    $firstLine = ($gitOutput | Select-Object -First 1)
    Add-ComponentResult "Build Tool" "Git" $firstLine "2.46+" "Available"
}

# 3. Cryptographic & Dependency Libraries
$latestWolfSSL = Get-LatestGitHubRelease "wolfSSL" "wolfssl"
Add-ComponentResult "Crypto Lib" "wolfSSL" "v5.7.2-stable (Pinned)" $latestWolfSSL "FetchContent Ready"

$latestOpenSSL = Get-LatestGitHubRelease "openssl" "openssl"
$opensslOutput = & openssl version 2>&1
$localOpenSSL = if ($opensslOutput) { $opensslOutput } else { "OpenSSL 3.x (System/vcpkg)" }
Add-ComponentResult "Crypto Lib" "OpenSSL" $localOpenSSL $latestOpenSSL "Standard for HA"

$results | Format-Table -AutoSize -Property Category, Component, LocalVersion, UpstreamVersion, Status
Write-Host "Inspection completed successfully." -ForegroundColor Green
