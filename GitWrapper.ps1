# Git Wrapper Functions for PowerShellPet
# Add these to your PowerShell profile to automatically invoke pet on git operations

# Store the original git command
if (-not (Get-Command git-original -ErrorAction SilentlyContinue)) {
    # Only create alias if it doesn't exist
    $gitPath = (Get-Command git).Source
    Set-Alias -Name git-original -Value $gitPath -Scope Global
}

function git {
    <#
    .SYNOPSIS
        Wrapper around git that automatically invokes PowerShellPet on commits
    .DESCRIPTION
        This function wraps the git command and automatically calls Invoke-PetCommit
        when you successfully commit code, ensuring your cat companion always tracks
        your commits without manual intervention.
    #>
    
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Arguments
    )
    
    # Call the original git command
    & git-original @Arguments
    
    # Check if this was a commit command and if it succeeded
    if ($Arguments.Count -gt 0 -and $Arguments[0] -eq 'commit' -and $LASTEXITCODE -eq 0) {
        # Check if PowerShellPet is loaded
        if (Get-Command Invoke-PetCommit -ErrorAction SilentlyContinue) {
            Write-Host "" # Add a blank line for better formatting
            Invoke-PetCommit
        } else {
            # Try to import the module
            if (Get-Module -ListAvailable PowerShellPet) {
                Import-Module PowerShellPet
                if (Get-Command Invoke-PetCommit -ErrorAction SilentlyContinue) {
                    Write-Host ""
                    Invoke-PetCommit
                }
            }
        }
    }
}

# Alternative: Specific git-commit function
function git-commit {
    <#
    .SYNOPSIS
        Git commit with automatic PowerShellPet integration
    .DESCRIPTION
        A convenience function that commits and automatically invokes your cat companion
    .EXAMPLE
        git-commit -m "Fixed the bug"
    #>
    
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Arguments
    )
    
    & git-original commit @Arguments
    
    if ($LASTEXITCODE -eq 0) {
        if (Get-Command Invoke-PetCommit -ErrorAction SilentlyContinue) {
            Write-Host ""
            Invoke-PetCommit
        }
    }
}

Write-Host "✓ PowerShellPet git wrapper loaded" -ForegroundColor Green
Write-Host "  Git commits will now automatically invoke your cat companion!" -ForegroundColor Gray
