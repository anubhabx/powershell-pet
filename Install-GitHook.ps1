#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Installs a git post-commit hook to automatically invoke PowerShellPet on commits
.DESCRIPTION
    This script creates a post-commit hook in your git repository that automatically
    calls Invoke-PetCommit after each successful commit, ensuring your cat companion
    always tracks your commits without manual intervention.
.PARAMETER Global
    Install the hook globally for all git repositories (uses git template directory)
.PARAMETER Repository
    Path to a specific repository to install the hook in. Defaults to current directory.
.EXAMPLE
    .\Install-GitHook.ps1
    Installs the hook in the current repository
.EXAMPLE
    .\Install-GitHook.ps1 -Global
    Installs the hook globally for all new repositories
.EXAMPLE
    .\Install-GitHook.ps1 -Repository "C:\Projects\MyProject"
    Installs the hook in a specific repository
#>

[CmdletBinding()]
param(
    [switch]$Global,
    [string]$Repository = $PWD
)

Write-Host "🐈 PowerShellPet Git Hook Installer" -ForegroundColor Cyan
Write-Host ""

# The hook script content
$hookContent = @'
#!/usr/bin/env pwsh
# PowerShellPet post-commit hook
# This hook automatically invokes Invoke-PetCommit after each commit

# Check if PowerShellPet is available
if (Get-Command Invoke-PetCommit -ErrorAction SilentlyContinue) {
    # Call Invoke-PetCommit
    Invoke-PetCommit
} else {
    # If module not loaded, try to import it
    if (Get-Module -ListAvailable PowerShellPet) {
        Import-Module PowerShellPet
        if (Get-Command Invoke-PetCommit -ErrorAction SilentlyContinue) {
            Invoke-PetCommit
        }
    }
}

exit 0
'@

function Install-HookInRepository {
    param($RepoPath)
    
    # Check if it's a git repository
    $gitDir = Join-Path $RepoPath ".git"
    if (-not (Test-Path $gitDir)) {
        Write-Host "✗ Not a git repository: $RepoPath" -ForegroundColor Red
        return $false
    }
    
    # Create hooks directory if it doesn't exist
    $hooksDir = Join-Path $gitDir "hooks"
    if (-not (Test-Path $hooksDir)) {
        New-Item -ItemType Directory -Path $hooksDir -Force | Out-Null
    }
    
    # Install post-commit hook
    $hookPath = Join-Path $hooksDir "post-commit"
    
    # Check if hook already exists
    if (Test-Path $hookPath) {
        $existing = Get-Content $hookPath -Raw -ErrorAction SilentlyContinue
        if ($existing -match "Invoke-PetCommit") {
            Write-Host "! Hook already exists and contains Invoke-PetCommit" -ForegroundColor Yellow
            Write-Host "  Do you want to overwrite it? (Y/N): " -NoNewline -ForegroundColor Yellow
            $response = Read-Host
            if ($response -ne 'Y' -and $response -ne 'y') {
                Write-Host "  Skipped" -ForegroundColor Gray
                return $true
            }
        }
    }
    
    # Write the hook
    $hookContent | Set-Content $hookPath -NoNewline
    
    # On Unix-like systems, make it executable (this is handled by git on Windows)
    if ($PSVersionTable.Platform -eq 'Unix') {
        chmod +x $hookPath
    }
    
    Write-Host "✓ Installed post-commit hook in: $RepoPath" -ForegroundColor Green
    return $true
}

function Install-GlobalHook {
    Write-Host "Installing global git hook template..." -ForegroundColor Yellow
    Write-Host ""
    
    # Get or create git template directory
    $templateDir = git config --global init.templatedir
    
    if (-not $templateDir) {
        # Create default template directory
        if ($IsWindows -or $PSVersionTable.Platform -eq 'Win32NT' -or -not $PSVersionTable.Platform) {
            $templateDir = Join-Path $env:USERPROFILE ".git-templates"
        } else {
            $templateDir = Join-Path $env:HOME ".git-templates"
        }
        
        Write-Host "Setting git template directory to: $templateDir" -ForegroundColor Gray
        git config --global init.templatedir $templateDir
    }
    
    # Create template hooks directory
    $hooksDir = Join-Path $templateDir "hooks"
    if (-not (Test-Path $hooksDir)) {
        New-Item -ItemType Directory -Path $hooksDir -Force | Out-Null
    }
    
    # Install the hook in template
    $hookPath = Join-Path $hooksDir "post-commit"
    $hookContent | Set-Content $hookPath -NoNewline
    
    # Make executable on Unix
    if ($PSVersionTable.Platform -eq 'Unix') {
        chmod +x $hookPath
    }
    
    Write-Host "✓ Installed global hook template" -ForegroundColor Green
    Write-Host ""
    Write-Host "Note: This will apply to all NEW repositories created with 'git init'" -ForegroundColor Yellow
    Write-Host "      For existing repositories, run this script in each repo directory" -ForegroundColor Yellow
    Write-Host ""
    
    # Offer to install in current repository too
    if (Test-Path ".git") {
        Write-Host "Current directory is a git repository." -ForegroundColor Cyan
        Write-Host "Install hook in current repository too? (Y/N): " -NoNewline -ForegroundColor Cyan
        $response = Read-Host
        if ($response -eq 'Y' -or $response -eq 'y') {
            Install-HookInRepository -RepoPath $PWD
        }
    }
    
    return $true
}

# Main installation logic
if ($Global) {
    $success = Install-GlobalHook
} else {
    Write-Host "Installing hook in repository: $Repository" -ForegroundColor Yellow
    Write-Host ""
    $success = Install-HookInRepository -RepoPath $Repository
}

Write-Host ""

if ($success) {
    Write-Host "✨ Installation complete!" -ForegroundColor Green
    Write-Host ""
    Write-Host "What happens now:" -ForegroundColor Cyan
    Write-Host "  ✓ Every git commit will automatically call Invoke-PetCommit" -ForegroundColor White
    Write-Host "  ✓ Your cat will track commits without manual intervention" -ForegroundColor White
    Write-Host "  ✓ No more skipped commits!" -ForegroundColor White
    Write-Host ""
    Write-Host "Test it:" -ForegroundColor Cyan
    Write-Host "  1. Make a change to a file" -ForegroundColor White
    Write-Host "  2. git add <file>" -ForegroundColor White
    Write-Host "  3. git commit -m 'Test commit'" -ForegroundColor White
    Write-Host "  4. You should see Lord Whiskers respond!" -ForegroundColor White
    Write-Host ""
    Write-Host "😼 Lord Whiskers will now watch your every commit..." -ForegroundColor Magenta
} else {
    Write-Host "✗ Installation failed" -ForegroundColor Red
    exit 1
}
