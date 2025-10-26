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

# State and config file paths
$script:StatePath = Join-Path $env:USERPROFILE ".powershellpet_state.json"
$script:ConfigPath = Join-Path $env:USERPROFILE ".powershellpet_config.json"

# Initialize or load config
function Initialize-PetConfig {
    if (Test-Path $script:ConfigPath) {
        try {
            $config = Get-Content $script:ConfigPath | ConvertFrom-Json
            return $config
        }
        catch {
            # If config file is corrupted, create new one
            return New-PetConfig
        }
    }
    else {
        return New-PetConfig
    }
}

function New-PetConfig {
    return [PSCustomObject]@{
        PetName = "Lord Whiskers"
        SassLevel = "Medium"  # Low, Medium, High
        MessageFrequency = 15  # Percentage chance to show messages
        ShowInPrompt = $true
        CustomEmoji = "🐈"
    }
}

function Save-PetConfig {
    param($Config)
    $Config | ConvertTo-Json | Set-Content $script:ConfigPath
}

# Initialize or load pet state
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
    $config = Initialize-PetConfig
    return [PSCustomObject]@{
        Name = $config.PetName
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

# Get a random quote based on context and sass level
function Get-PetQuote {
    param(
        [string]$Context = "Idle",
        [string]$SassLevel = "Medium"
    )

    if ($script:PetQuotes.ContainsKey($Context)) {
        $quotes = $script:PetQuotes[$Context]
        $selectedQuote = $quotes | Get-Random
        
        # Filter based on sass level
        switch ($SassLevel) {
            "Low" {
                # Remove quotes with certain sass indicators
                if ($selectedQuote -match "pathetic|vomit|peasant|disappointing") {
                    # Try to get a gentler one
                    $gentleQuotes = $quotes | Where-Object { $_ -notmatch "pathetic|vomit|peasant|disappointing" }
                    if ($gentleQuotes) {
                        return $gentleQuotes | Get-Random
                    }
                }
            }
            "High" {
                # Prefer sassier quotes
                $sassyQuotes = $quotes | Where-Object { $_ -match "pathetic|vomit|peasant|disappointing|AHAHAHA" }
                if ($sassyQuotes) {
                    return $sassyQuotes | Get-Random
                }
            }
        }
        
        return $selectedQuote
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
    $config = Initialize-PetConfig
    $state = Initialize-PetState

    # Update last seen
    $state.LastSeen = Get-Date

    # Determine mood
    $mood = Get-PetMood
    $state.Mood = $mood

    # Occasionally show a message based on configured frequency
    $message = ""
    $randomChance = Get-Random -Minimum 1 -Maximum 100

    if ($randomChance -le $config.MessageFrequency) {
        $hour = (Get-Date).Hour
        if ($hour -ge 6 -and $hour -lt 12) {
            $message = Get-PetQuote "Morning" $config.SassLevel
        }
        elseif ($randomChance -le ($config.MessageFrequency / 3)) {
            # Extra sassy random comments
            $message = Get-PetQuote "Random" $config.SassLevel
        }
        else {
            $message = Get-PetQuote "Encouragement" $config.SassLevel
        }
    }

    # Save state
    Save-PetState $state

    # Only show in prompt if configured
    if ($config.ShowInPrompt) {
        # Show pet (inline, small)
        $color = switch ($mood) {
            "Happy" { "Green" }
            "Excited" { "Yellow" }
            "Sleepy" { "DarkGray" }
            "Grumpy" { "Red" }
            "Coding" { "Cyan" }
            "Fire" { "DarkYellow" }
            default { "White" }
        }

        # Use custom emoji from config
        $compactPet = $config.CustomEmoji
        Write-Host "$compactPet " -ForegroundColor $color -NoNewline

        if ($message) {
            Write-Host "$message " -ForegroundColor DarkGray
        }
    }

    # Return the actual prompt
    $location = Get-Location
    Write-Host "PS " -NoNewline -ForegroundColor Cyan
    Write-Host "$location" -ForegroundColor Yellow -NoNewline
    return "> "
}

# Command to show full pet status
function Show-PetStatus {
    $state = Initialize-PetState
    $config = Initialize-PetConfig
    
    Write-Host "`n=== Your Feline Overlord's Status ===" -ForegroundColor Cyan
    Write-Host "Name: $($state.Name) (Yes, you must use the title)" -ForegroundColor White
    Write-Host "Level: $($state.Level) (Still leagues above you)" -ForegroundColor Yellow
    Write-Host "Commits Witnessed: $($state.Commits) (I was watching. Always watching.)" -ForegroundColor Green
    Write-Host "Experience: $($state.Experience) / $($state.Level * 100)" -ForegroundColor Blue
    Write-Host "Current Mood: $($state.Mood)" -ForegroundColor Magenta
    Write-Host "Sass Level: $($config.SassLevel)" -ForegroundColor DarkYellow
    Write-Host ""
    Show-Pet -Mood $state.Mood -Message (Get-PetQuote "Random" $config.SassLevel)
}

# Command to celebrate a commit
function Invoke-PetCommit {
    $config = Initialize-PetConfig
    $state = Initialize-PetState
    $state.Commits++
    $state.Experience += 10

    # Level up every 10 commits
    if ($state.Experience -ge ($state.Level * 100)) {
        $state.Level++
        Write-Host "`n✨ " -NoNewline -ForegroundColor Yellow
        Write-Host "$($state.Name) has ascended to Level $($state.Level)!" -ForegroundColor Green
        Write-Host "   (You're welcome for tolerating your presence)" -ForegroundColor DarkGray
    }

    Save-PetState $state
    Show-Pet -Mood "Excited" -Message (Get-PetQuote "Commit" $config.SassLevel)
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

# Configuration commands
function Set-PetName {
    <#
    .SYNOPSIS
        Set your pet's name
    .PARAMETER Name
        The new name for your pet
    .EXAMPLE
        Set-PetName "Sir Fluffington"
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$Name
    )
    
    $config = Initialize-PetConfig
    $config.PetName = $Name
    Save-PetConfig $config
    
    # Update state with new name
    $state = Initialize-PetState
    $state.Name = $Name
    Save-PetState $state
    
    Write-Host "✓ Your pet's name has been changed to: " -NoNewline -ForegroundColor Green
    Write-Host $Name -ForegroundColor Cyan
    Write-Host "  (They'll pretend they don't care, but they noticed)" -ForegroundColor DarkGray
}

function Set-PetSassLevel {
    <#
    .SYNOPSIS
        Set your pet's sass level
    .PARAMETER Level
        The sass level: Low, Medium, or High
    .EXAMPLE
        Set-PetSassLevel High
    #>
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("Low", "Medium", "High")]
        [string]$Level
    )
    
    $config = Initialize-PetConfig
    $config.SassLevel = $Level
    Save-PetConfig $config
    
    $response = switch ($Level) {
        "Low" { "Your pet will be... gentler. (But still judging you)" }
        "Medium" { "A balanced level of sass. Classic." }
        "High" { "Maximum sass engaged. You asked for this." }
    }
    
    Write-Host "✓ Sass level set to: " -NoNewline -ForegroundColor Green
    Write-Host $Level -ForegroundColor Yellow
    Write-Host "  $response" -ForegroundColor DarkGray
}

function Set-PetMessageFrequency {
    <#
    .SYNOPSIS
        Set how often your pet shows messages
    .PARAMETER Frequency
        Percentage chance (1-100) to show messages in prompt
    .EXAMPLE
        Set-PetMessageFrequency 25
    #>
    param(
        [Parameter(Mandatory=$true)]
        [ValidateRange(0, 100)]
        [int]$Frequency
    )
    
    $config = Initialize-PetConfig
    $config.MessageFrequency = $Frequency
    Save-PetConfig $config
    
    Write-Host "✓ Message frequency set to: " -NoNewline -ForegroundColor Green
    Write-Host "$Frequency%" -ForegroundColor Yellow
    
    if ($Frequency -eq 0) {
        Write-Host "  (Your pet will be silent. They're plotting something...)" -ForegroundColor DarkGray
    }
    elseif ($Frequency -gt 50) {
        Write-Host "  (Your pet will be VERY chatty. Hope you're ready!)" -ForegroundColor DarkGray
    }
}

function Set-PetEmoji {
    <#
    .SYNOPSIS
        Set a custom emoji for your pet
    .PARAMETER Emoji
        The emoji to use in the prompt
    .EXAMPLE
        Set-PetEmoji "🐱"
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$Emoji
    )
    
    $config = Initialize-PetConfig
    $config.CustomEmoji = $Emoji
    Save-PetConfig $config
    
    Write-Host "✓ Pet emoji changed to: $Emoji" -ForegroundColor Green
    Write-Host "  (Looking good!)" -ForegroundColor DarkGray
}

function Set-PetPromptVisibility {
    <#
    .SYNOPSIS
        Toggle whether the pet appears in your prompt
    .PARAMETER Show
        $true to show in prompt, $false to hide
    .EXAMPLE
        Set-PetPromptVisibility $false
    #>
    param(
        [Parameter(Mandatory=$true)]
        [bool]$Show
    )
    
    $config = Initialize-PetConfig
    $config.ShowInPrompt = $Show
    Save-PetConfig $config
    
    if ($Show) {
        Write-Host "✓ Your pet will appear in the prompt" -ForegroundColor Green
    }
    else {
        Write-Host "✓ Your pet will be hidden from the prompt" -ForegroundColor Yellow
        Write-Host "  (They're still watching though...)" -ForegroundColor DarkGray
    }
}

function Get-PetConfig {
    <#
    .SYNOPSIS
        Display current pet configuration
    .EXAMPLE
        Get-PetConfig
    #>
    $config = Initialize-PetConfig
    
    Write-Host "`n=== Pet Configuration ===" -ForegroundColor Cyan
    Write-Host "Pet Name: " -NoNewline -ForegroundColor White
    Write-Host $config.PetName -ForegroundColor Yellow
    Write-Host "Sass Level: " -NoNewline -ForegroundColor White
    Write-Host $config.SassLevel -ForegroundColor Yellow
    Write-Host "Message Frequency: " -NoNewline -ForegroundColor White
    Write-Host "$($config.MessageFrequency)%" -ForegroundColor Yellow
    Write-Host "Show in Prompt: " -NoNewline -ForegroundColor White
    Write-Host $config.ShowInPrompt -ForegroundColor Yellow
    Write-Host "Custom Emoji: " -NoNewline -ForegroundColor White
    Write-Host $config.CustomEmoji -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Config file: $script:ConfigPath" -ForegroundColor DarkGray
}

function Reset-PetConfig {
    <#
    .SYNOPSIS
        Reset pet configuration to defaults
    .EXAMPLE
        Reset-PetConfig
    #>
    param(
        [switch]$Force
    )
    
    if (-not $Force) {
        $confirm = Read-Host "Are you sure you want to reset all pet configuration? (y/n)"
        if ($confirm -ne 'y') {
            Write-Host "Reset cancelled." -ForegroundColor Yellow
            return
        }
    }
    
    $config = New-PetConfig
    Save-PetConfig $config
    
    Write-Host "✓ Pet configuration reset to defaults" -ForegroundColor Green
    Write-Host "  (Fresh start! Your pet is back to being Lord Whiskers)" -ForegroundColor DarkGray
}

function Reset-Pet {
    <#
    .SYNOPSIS
        Reset your pet completely (state and config)
    .EXAMPLE
        Reset-Pet
    #>
    param(
        [switch]$Force
    )
    
    if (-not $Force) {
        $confirm = Read-Host "Are you sure you want to completely reset your pet? This will erase all progress! (y/n)"
        if ($confirm -ne 'y') {
            Write-Host "Reset cancelled." -ForegroundColor Yellow
            return
        }
    }
    
    # Reset config
    $config = New-PetConfig
    Save-PetConfig $config
    
    # Reset state
    $state = New-PetState
    Save-PetState $state
    
    Write-Host "✓ Your pet has been completely reset" -ForegroundColor Green
    Write-Host "  (It's like you just met. They're judging you all over again!)" -ForegroundColor DarkGray
}

# Export functions
Export-ModuleMember -Function prompt, Show-PetStatus, Invoke-PetCommit, Enable-PetGitTracking, git, `
    Set-PetName, Set-PetSassLevel, Set-PetMessageFrequency, Set-PetEmoji, Set-PetPromptVisibility, `
    Get-PetConfig, Reset-PetConfig, Reset-Pet

# Module initialization - set up git alias to use our wrapper function
$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    # Clean up the git alias when module is removed
    Remove-Item Alias:\git -ErrorAction SilentlyContinue -Force
}

# After module loads, the user needs to either:
# 1. Use Import-Module PowerShellPet -Function git (to get the function in global scope)
# 2. Or have this in their profile: Set-Alias git ((Get-Command git -Module PowerShellPet).Name) -Force
# The Install script will handle this automatically
