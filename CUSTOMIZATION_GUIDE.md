# PowerShellPet Customization Guide

Welcome to the customization guide! Your pet is now fully customizable to match your personality and preferences.

## Quick Start

```powershell
# View current settings
Get-PetConfig

# Change your pet's name
Set-PetName "Princess Mittens"

# Adjust sass level
Set-PetSassLevel Low    # Gentle and encouraging
Set-PetSassLevel Medium # Balanced (default)
Set-PetSassLevel High   # Maximum sass!

# Control message frequency (0-100%)
Set-PetMessageFrequency 30  # More chatty
Set-PetMessageFrequency 5   # Quieter

# Use a different emoji
Set-PetEmoji "😺"
Set-PetEmoji "🐱"
Set-PetEmoji "😸"

# Hide from prompt (but still track commits)
Set-PetPromptVisibility $false
```

## Configuration File

Your settings are stored in `~/.powershellpet_config.json`. You can edit this file directly:

```json
{
  "PetName": "Lord Whiskers",
  "SassLevel": "Medium",
  "MessageFrequency": 15,
  "ShowInPrompt": true,
  "CustomEmoji": "🐈"
}
```

## Sass Levels Explained

### Low
- Gentler, more encouraging messages
- Filters out the harshest sass
- Perfect if you want a supportive companion

### Medium (Default)
- Balanced mix of sass and encouragement
- The classic PowerShellPet experience
- Sassy but not overwhelming

### High
- Maximum sass engaged
- Prefers the sassiest quotes
- For those who can handle the heat

## Message Frequency

Controls how often your pet shows messages in the prompt:

- **0%**: Silent mode (still tracks commits)
- **15%**: Default, occasional messages
- **30-50%**: Chatty cat
- **100%**: Every single prompt (brave choice!)

## Reset Options

```powershell
# Reset just the configuration
Reset-PetConfig

# Reset everything (config + progress)
Reset-Pet
```

## Tips & Tricks

1. **Multiple Personalities**: Create different config files and swap them:
   ```powershell
   Copy-Item ~/.powershellpet_config.json ~/.powershellpet_config_work.json
   Copy-Item ~/.powershellpet_config_fun.json ~/.powershellpet_config.json
   ```

2. **Team Fun**: Share your pet's name and settings with your team for consistency

3. **Quiet Hours**: Lower message frequency during focus time:
   ```powershell
   Set-PetMessageFrequency 5
   ```

4. **Emoji Collection**: Try different emojis to match your mood:
   - 🐈 Classic cat
   - 😺 Happy cat
   - 😸 Grinning cat
   - 😹 Laughing cat
   - 😻 Heart eyes cat
   - 🐱 Simple cat face
   - 🦁 Lion (for the bold)
   - 🐯 Tiger (for the fierce)

## Examples

### The Supportive Companion
```powershell
Set-PetName "Buddy"
Set-PetSassLevel Low
Set-PetMessageFrequency 20
Set-PetEmoji "😺"
```

### The Sassy Overlord (Default)
```powershell
Set-PetName "Lord Whiskers"
Set-PetSassLevel High
Set-PetMessageFrequency 15
Set-PetEmoji "🐈"
```

### The Silent Observer
```powershell
Set-PetName "Shadow"
Set-PetSassLevel Medium
Set-PetMessageFrequency 0
Set-PetPromptVisibility $false
```

## Troubleshooting

**Q: My emoji doesn't display correctly**
A: This depends on your terminal's font and encoding. Try using Windows Terminal or a terminal with good Unicode support.

**Q: Changes don't appear immediately**
A: The prompt updates on the next command. Just press Enter to see the changes.

**Q: I want to go back to defaults**
A: Run `Reset-PetConfig` to restore default settings.

**Q: Can I have different settings per project?**
A: Currently, settings are global per user. Project-specific settings may come in a future version!

## Contributing Ideas

Have ideas for new customization options? We'd love to hear them:
- Custom ASCII art
- Time-based personality changes
- Achievement badges
- Custom quote collections
- And more!

---

*"Customization is just another way for you to serve me better." - Lord Whiskers*
