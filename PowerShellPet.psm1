# PetPet - Your Terminal Cat Overlord
# A fun PowerShell module that adds a cat who thinks they're a deity to your terminal

# Pet ASCII art for different moods
$script:PetMoods = @{
    Happy = @"
  /\_/\
 ( o.o )
  > ^ <  ~
"@
    Excited = @"
  /\_/\
 ( ^.^ )
  > ∆ <  ~~
"@
    Sleepy = @"
  /\_/\
 ( -.- )
  > ~ <
"@
    Grumpy = @"
  /\_/\
 ( >.< )
  > v <  !
"@
    Coding = @"
  /\_/\
 ( O.O )
  > □ <  ⌨
"@
    Fire = @"
  /\_/\
 ( ◉.◉ )
  > △ <  🔥
"@
}

# Pet quotes and messages
$script:PetQuotes = @{
    Morning = @(
        "☕ Finally awake? I've been judging you for hours.",
        "🌅 Another day for you to serve me... I mean, 'code'.",
        "😼 Good morning, peasant. Your offerings of bugs please me not.",
        "⚔️ Arise, mortal. These repositories won't worship themselves."
    )
    Commit = @(
        "🔥 Acceptable. I suppose you deserve a slow blink.",
        "✨ Hmm. Not terrible. I've seen worse from dogs.",
        "🚀 Oh, you pushed code? How brave. Want a treat?",
        "💪 FINALLY. Was beginning to think you'd forgotten how.",
        "⚡ Your tribute has been received. You may continue breathing.",
        "😼 I'll allow it. This time."
    )
    Error = @(
        "😅 AHAHAHA! *ahem* I mean... there, there.",
        "🤔 Even I, a divine being, cannot fix your syntax.",
        "💭 Perhaps consulting the sacred texts (Stack Overflow)?",
        "🐛 You've displeased me. Fix this. NOW.",
        "🔥 Did you TEST this? No? Shocking.",
        "😹 I'm not mad. Just... deeply disappointed."
    )
    Idle = @(
        "💤 Don't disturb me. I'm doing important cat things.",
        "🎮 Still staring at the screen? Pathetic.",
        "🍕 You should be feeding me right now.",
        "👀 I know what you did. Don't think I've forgotten.",
        "💎 Contemplating why I tolerate your presence...",
        "😼 Yes, I'm judging you. Obviously."
    )
    Encouragement = @(
        "💎 I suppose your code doesn't make me want to vomit. Congrats.",
        "⭐ You're doing... fine. For a human.",
        "🌟 Wow. You pressed keys. Revolutionary.",
        "🦸 Keep going. The sooner you finish, the sooner you pet me.",
        "🔥 Not bad. I've trained you well.",
        "😼 I'll pretend to be impressed if it helps your fragile ego."
    )
    Random = @(
        "🐾 Remember: I own you, not the other way around.",
        "😾 Your mouse cursor disturbs my meditation.",
        "🎯 Fun fact: I could knock your coffee over right now.",
        "💅 Some of us are born superior. Deal with it.",
        "🎭 Yes, I'm a cat. Yes, I'm better than you. Questions?",
        "👑 In ancient times, humans worshipped me. Now look at you."
    )
}

# State file path
$script:StatePath = Join-Path $env:USERPROFILE ".dragonpet_state.json"

# Initialize or load dragon state
function Initialize-PetState {
    if (Test-Path $script:StatePath) {
        try {
            $state = Get-Content $script:StatePath | ConvertFrom-Json
            return $state
        }
        catch {
            # If state file is corrupted, create new one
            return New-PetState
        }
    }
    else {
        return New-PetState
    }
}

function New-PetState {
    return [PSCustomObject]@{
        Name = "Lord Whiskers"
        Level = 1
        Commits = 0
        LastSeen = Get-Date
        Mood = "Happy"
        Experience = 0
    }
}

function Save-PetState {
    param($State)
    $State | ConvertTo-Json | Set-Content $script:StatePath
}

# Get dragon's current mood based on context
function Get-PetMood {
    $hour = (Get-Date).Hour

    # Check if in a git repo and get last commit time
    $isGitRepo = Test-Path ".git"

    if ($hour -lt 6) {
        return "Sleepy"
    }
    elseif ($hour -lt 9) {
        return "Happy"
    }
    elseif ($isGitRepo) {
        return "Coding"
    }
    else {
        return "Happy"
    }
}

# Get a random quote based on context
function Get-PetQuote {
    param($Context = "Idle")

    if ($script:PetQuotes.ContainsKey($Context)) {
        $quotes = $script:PetQuotes[$Context]
        return $quotes | Get-Random
    }
    return ""
}

# Main function to display the dragon
function Show-Pet {
    param(
        [string]$Mood,
        [string]$Message = ""
    )

    $dragonArt = $script:PetMoods[$Mood]
    $color = switch ($Mood) {
        "Happy" { "Green" }
        "Excited" { "Yellow" }
        "Sleepy" { "DarkGray" }
        "Grumpy" { "Red" }
        "Coding" { "Cyan" }
        "Fire" { "DarkYellow" }
        default { "White" }
    }

    Write-Host $dragonArt -ForegroundColor $color -NoNewline
    if ($Message) {
        Write-Host " $Message" -ForegroundColor $color
    }
    else {
        Write-Host ""
    }
}

# Hook into the prompt
function prompt {
    $state = Initialize-PetState

    # Update last seen
    $state.LastSeen = Get-Date

    # Determine mood
    $mood = Get-PetMood
    $state.Mood = $mood

    # Occasionally show a message (15% chance for more sass)
    $message = ""
    $randomChance = Get-Random -Minimum 1 -Maximum 100

    if ($randomChance -le 15) {
        $hour = (Get-Date).Hour
        if ($hour -ge 6 -and $hour -lt 12) {
            $message = Get-PetQuote "Morning"
        }
        elseif ($randomChance -le 5) {
            # Extra sassy random comments
            $message = Get-PetQuote "Random"
        }
        else {
            $message = Get-PetQuote "Encouragement"
        }
    }

    # Save state
    Save-PetState $state

    # Show dragon (inline, small)
    $dragonArt = $script:PetMoods[$mood]
    $color = switch ($mood) {
        "Happy" { "Green" }
        "Excited" { "Yellow" }
        "Sleepy" { "DarkGray" }
        "Grumpy" { "Red" }
        "Coding" { "Cyan" }
        "Fire" { "DarkYellow" }
        default { "White" }
    }

    # Create a compact single-line dragon
    $compactPet = "🐈"
    Write-Host "$compactPet " -ForegroundColor $color -NoNewline

    if ($message) {
        Write-Host "$message " -ForegroundColor DarkGray
    }

    # Return the actual prompt
    $location = Get-Location
    Write-Host "PS " -NoNewline -ForegroundColor Cyan
    Write-Host "$location" -ForegroundColor Yellow -NoNewline
    return "> "
}

# Command to show full dragon
function Show-PetStatus {
    $state = Initialize-PetState
    Write-Host "`n=== Your Feline Overlord's Status ===" -ForegroundColor Cyan
    Write-Host "Name: $($state.Name) (Yes, you must use the title)" -ForegroundColor White
    Write-Host "Level: $($state.Level) (Still leagues above you)" -ForegroundColor Yellow
    Write-Host "Commits Witnessed: $($state.Commits) (I was watching. Always watching.)" -ForegroundColor Green
    Write-Host "Current Mood: $($state.Mood)" -ForegroundColor Magenta
    Write-Host ""
    Show-Pet -Mood $state.Mood -Message (Get-PetQuote "Random")
}

# Command to celebrate a commit
function Invoke-PetCommit {
    $state = Initialize-PetState
    $state.Commits++
    $state.Experience += 10

    # Level up every 10 commits
    if ($state.Experience -ge ($state.Level * 100)) {
        $state.Level++
        Write-Host "`n✨ " -NoNewline -ForegroundColor Yellow
        Write-Host "Lord Whiskers has ascended to Level $($state.Level)!" -ForegroundColor Green
        Write-Host "   (You're welcome for tolerating your presence)" -ForegroundColor DarkGray
    }

    Save-PetState $state
    Show-Pet -Mood "Excited" -Message (Get-PetQuote "Commit")
}

# Store original git path - find git.exe
$script:OriginalGitPath = $null
$gitExe = Get-Command git -CommandType Application -ErrorAction SilentlyContinue
if ($gitExe) {
    $script:OriginalGitPath = $gitExe.Source
}

# Git wrapper function - always define it, even if git isn't installed
function git {
    <#
    .SYNOPSIS
        Wrapper around git that automatically tracks commits in PowerShellPet
    #>
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Arguments
    )
    
    # Call original git executable
    if ($script:OriginalGitPath) {
        & $script:OriginalGitPath @Arguments
        $gitExitCode = $LASTEXITCODE
        
        # If this was a successful commit, invoke the pet
        if ($Arguments.Count -gt 0 -and $Arguments[0] -eq 'commit' -and $gitExitCode -eq 0) {
            # Check if it was a real commit (not dry-run or amend-no-edit)
            $isDryRun = $Arguments -contains '--dry-run' -or $Arguments -contains '-n'
            $isAmendNoEdit = $Arguments -contains '--amend' -and $Arguments -contains '--no-edit'
            
            if (-not ($isDryRun -or $isAmendNoEdit)) {
                Write-Host ""
                try {
                    Invoke-PetCommit
                } catch {
                    # Silently fail if there's an issue - don't break git workflow
                }
            }
        }
        
        # Preserve the original exit code
        $global:LASTEXITCODE = $gitExitCode
    } else {
        Write-Host "Git is not installed or not in PATH" -ForegroundColor Red
        return 1
    }
}

# Helper function to verify git tracking is enabled
function Enable-PetGitTracking {
    <#
    .SYNOPSIS
        Ensures git command wrapper is active for automatic commit tracking
    .DESCRIPTION
        This function verifies that the git wrapper is working. The wrapper should
        be automatically enabled when the module is imported.
    #>
    
    $gitFunc = Get-Command git -CommandType Function -ErrorAction SilentlyContinue
    if ($gitFunc -and $gitFunc.ModuleName -eq 'PowerShellPet') {
        Write-Host "✓ Git wrapper is active! Commits will be tracked automatically." -ForegroundColor Green
        Write-Host "  Just use: git commit -m 'your message'" -ForegroundColor Gray
    } else {
        Write-Host "! Git wrapper may not be active. Trying to activate..." -ForegroundColor Yellow
        Write-Host "  If this doesn't work, you may need to call Invoke-PetCommit manually after commits." -ForegroundColor Gray
    }
}

# Export functions
Export-ModuleMember -Function prompt, Show-PetStatus, Invoke-PetCommit, Enable-PetGitTracking, git

# Module initialization - set up git alias to use our wrapper function
$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    # Clean up the git alias when module is removed
    Remove-Item Alias:\git -ErrorAction SilentlyContinue -Force
}

# After module loads, the user needs to either:
# 1. Use Import-Module PowerShellPet -Function git (to get the function in global scope)
# 2. Or have this in their profile: Set-Alias git ((Get-Command git -Module PowerShellPet).Name) -Force
# The Install script will handle this automatically
