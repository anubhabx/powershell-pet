# PowerShellPet 🐈

Your terminal's new feline overlord. A PowerShell module that adds a sassy cat companion to your command line who thinks they're a deity (and honestly, they might be right).

## Features

- **Sassy Cat Companion**: Lord Whiskers appears in your prompt with attitude
- **Multiple Moods**: Your cat changes moods based on time of day and context (Happy, Sleepy, Coding, Grumpy, Excited, Fire)
- **Witty Commentary**: Random sarcastic messages to keep you entertained (or humbled)
- **Level System**: Your cat gains experience and levels up as you make commits
- **Automatic Git Integration**: Automatically tracks your commits - no extra setup needed!
- **Persistent State**: Your cat remembers everything (yes, everything)

## Installation

### Quick Install

Run the install script:

```powershell
.\Install.ps1
```

This will:
1. Copy the module to your PowerShell modules directory
2. Add the module to your PowerShell profile
3. **Enable automatic git commit tracking** (commits are tracked automatically!)

After installation, restart PowerShell or run:
```powershell
. $PROFILE
```

That's it! Your cat companion is ready to judge your commits! 🐈

### Manual Installation

1. Copy `PowerShellPet.psm1` to your PowerShell modules directory:
   ```powershell
   $modulePath = "$env:USERPROFILE\Documents\PowerShell\Modules\PowerShellPet"
   New-Item -ItemType Directory -Path $modulePath -Force
   Copy-Item PowerShellPet.psm1 -Destination $modulePath
   ```

2. Add to your PowerShell profile:
   ```powershell
   notepad $PROFILE
   ```
   
   Add this line:
   ```powershell
   Import-Module PowerShellPet
   ```

3. Reload your profile:
   ```powershell
   . $PROFILE
   ```

## Usage

Once installed, Lord Whiskers will automatically appear in your prompt with occasional commentary.

### Automatic Git Tracking

Just use git normally - Lord Whiskers will automatically celebrate your commits! 🐈

```powershell
git commit -m "Fixed the bug"
# Lord Whiskers appears automatically!
```

### Commands

#### Status & Info
- **Show-PetStatus**: Display your cat's full status and stats
  ```powershell
  Show-PetStatus
  ```

- **Get-PetConfig**: View current configuration
  ```powershell
  Get-PetConfig
  ```

#### Customization
- **Set-PetName**: Change your pet's name
  ```powershell
  Set-PetName "Sir Fluffington"
  ```

- **Set-PetSassLevel**: Adjust sass level (Low, Medium, High)
  ```powershell
  Set-PetSassLevel High
  ```

- **Set-PetMessageFrequency**: Control how often messages appear (0-100%)
  ```powershell
  Set-PetMessageFrequency 25
  ```

- **Set-PetEmoji**: Use a custom emoji
  ```powershell
  Set-PetEmoji "🐱"
  ```

- **Set-PetPromptVisibility**: Show or hide pet in prompt
  ```powershell
  Set-PetPromptVisibility $false
  ```

#### Reset Options
- **Reset-PetConfig**: Reset configuration to defaults
  ```powershell
  Reset-PetConfig
  ```

- **Reset-Pet**: Complete reset (state and config)
  ```powershell
  Reset-Pet
  ```

- **Invoke-PetCommit**: Manually trigger a commit celebration (usually automatic)
  ```powershell
  Invoke-PetCommit
  ```

## Examples

### Default Prompt
```
🐈 ☕ Finally awake? I've been judging you for hours.
PS C:\Projects\MyProject>

🐈 💎 I suppose your code doesn't make me want to vomit. Congrats.
PS C:\Projects\MyProject>
```

### Customization Examples
```powershell
# Make your pet less sassy
Set-PetSassLevel Low

# Rename your pet
Set-PetName "Princess Mittens"

# Make them chattier
Set-PetMessageFrequency 30

# Use a different emoji
Set-PetEmoji "😺"

# Check your settings
Get-PetConfig
```

## Configuration & Customization

PowerShellPet is fully customizable! Change your pet's name, sass level, message frequency, and more.

**Quick customization:**
```powershell
Set-PetName "Princess Mittens"
Set-PetSassLevel High
Set-PetMessageFrequency 25
```

For detailed customization options, see the [Customization Guide](CUSTOMIZATION_GUIDE.md).

### Config File

Settings are stored in `~/.powershellpet_config.json`. You can edit this file directly or use the provided commands.

**Config Options:**
- **PetName**: Your pet's name (default: "Lord Whiskers")
- **SassLevel**: How sassy your pet is - "Low", "Medium", or "High" (default: "Medium")
- **MessageFrequency**: Percentage chance (0-100) to show messages in prompt (default: 15)
- **ShowInPrompt**: Whether to show the pet emoji in your prompt (default: true)
- **CustomEmoji**: The emoji to display (default: "🐈")

See `example_config.json` for a reference configuration.

## Uninstallation

To remove PowerShellPet:

1. Remove the import line from your profile:
   ```powershell
   notepad $PROFILE
   ```

2. Delete the module folder:
   ```powershell
   Remove-Item "$env:USERPROFILE\Documents\PowerShell\Modules\PowerShellPet" -Recurse -Force
   ```

## Requirements

- PowerShell 5.1 or later
- Windows, macOS, or Linux

## License

MIT License - Feel free to use, modify, and share. Lord Whiskers approves.

## Contributing

Contributions welcome! Lord Whiskers is always looking for new ways to sass their humans.

---

*"Remember: I own you, not the other way around." - Lord Whiskers*
