#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Installs the PowerShellPet module
.DESCRIPTION
    This script installs PowerShellPet by copying it to your PowerShell modules directory
    and adding it to your PowerShell profile for automatic loading.
.EXAMPLE
    .\Install-PowerShellPet.ps1
#>

[CmdletBinding()]
param()

Write-Host "🐈 Installing PowerShellPet - Your Terminal's New Overlord" -ForegroundColor Cyan
Write-Host ""

# Determine the correct modules path based on PowerShell edition
if ($PSVersionTable.PSEdition -eq 'Core') {
    $modulesPath = "$env:USERPROFILE\Documents\PowerShell\Modules"
} else {
    $modulesPath = "$env:USERPROFILE\Documents\WindowsPowerShell\Modules"
}

$moduleName = "PowerShellPet"
$moduleDestination = Join-Path $modulesPath $moduleName

# Create module directory if it doesn't exist
Write-Host "📁 Creating module directory..." -ForegroundColor Yellow
if (-not (Test-Path $moduleDestination)) {
    New-Item -ItemType Directory -Path $moduleDestination -Force | Out-Null
    Write-Host "   ✓ Created: $moduleDestination" -ForegroundColor Green
} else {
    Write-Host "   ✓ Directory exists: $moduleDestination" -ForegroundColor Green
}

# Copy module file
Write-Host "📦 Copying module files..." -ForegroundColor Yellow
$sourceFile = Join-Path $PSScriptRoot "PowerShellPet.psm1"
if (Test-Path $sourceFile) {
    Copy-Item $sourceFile -Destination $moduleDestination -Force
    Write-Host "   ✓ Copied PowerShellPet.psm1" -ForegroundColor Green
} else {
    Write-Host "   ✗ Error: PowerShellPet.psm1 not found in current directory" -ForegroundColor Red
    exit 1
}

# Check if profile exists, create if not
Write-Host "📝 Configuring PowerShell profile..." -ForegroundColor Yellow
if (-not (Test-Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null
    Write-Host "   ✓ Created profile: $PROFILE" -ForegroundColor Green
}

# Check if module is already in profile
$profileContent = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue
$importStatement = "Import-Module PowerShellPet"

if ($profileContent -notmatch [regex]::Escape($importStatement)) {
    # Add import statement to profile
    Add-Content -Path $PROFILE -Value "`n# PowerShellPet - Your Feline Overlord"
    Add-Content -Path $PROFILE -Value $importStatement
    Write-Host "   ✓ Added to profile" -ForegroundColor Green
} else {
    Write-Host "   ✓ Already in profile" -ForegroundColor Green
}

Write-Host ""
Write-Host "✨ Installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "To start using PowerShellPet, either:" -ForegroundColor White
Write-Host "  1. Restart your PowerShell session, or" -ForegroundColor White
Write-Host "  2. Run: " -NoNewline -ForegroundColor White
Write-Host "Import-Module PowerShellPet -Force" -ForegroundColor Yellow
Write-Host ""
Write-Host "Features:" -ForegroundColor Cyan
Write-Host "  ✓ Sassy cat in your prompt" -ForegroundColor White
Write-Host "  ✓ Automatic git commit tracking (just use 'git commit' normally!)" -ForegroundColor White
Write-Host "  ✓ Level up system" -ForegroundColor White
Write-Host ""
Write-Host "Commands:" -ForegroundColor Cyan
Write-Host "  Show-PetStatus      - View your cat's status" -ForegroundColor White
Write-Host "  git commit -m '...' - Commits are tracked automatically!" -ForegroundColor White
Write-Host ""
Write-Host "😼 Lord Whiskers awaits your service..." -ForegroundColor Magenta
