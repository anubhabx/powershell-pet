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
.\Install-PowerShellPet.ps1
```

This will:
1. Copy the module to your PowerShell modules directory
2. Add the module to your PowerShell profile
3. Reload your profile

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

- **Show-PetStatus**: Display your cat's full status and stats
  ```powershell
  Show-PetStatus
  ```

- **Invoke-PetCommit**: Manually trigger a commit celebration (usually automatic)
  ```powershell
  Invoke-PetCommit
  ```

## Examples

```
🐈 ☕ Finally awake? I've been judging you for hours.
PS C:\Projects\MyProject>

🐈 💎 I suppose your code doesn't make me want to vomit. Congrats.
PS C:\Projects\MyProject>
```

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
