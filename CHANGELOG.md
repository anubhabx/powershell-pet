# Changelog

All notable changes to PowerShellPet will be documented in this file.

## [1.2.0] - 2025-10-26

### Added
- **Full Customization Support**: Users can now customize their pet!
  - `Set-PetName`: Change your pet's name
  - `Set-PetSassLevel`: Adjust sass level (Low, Medium, High)
  - `Set-PetMessageFrequency`: Control message frequency (0-100%)
  - `Set-PetEmoji`: Use custom emojis
  - `Set-PetPromptVisibility`: Toggle prompt visibility
  - `Get-PetConfig`: View current configuration
  - `Reset-PetConfig`: Reset configuration to defaults
  - `Reset-Pet`: Complete reset of pet state and config
- Configuration file support at `~/.powershellpet_config.json`
- Sass level filtering for quotes (gentler or sassier based on preference)
- Example configuration file (`example_config.json`)

### Changed
- Pet name now respects configuration in all messages
- Message frequency is now configurable (was hardcoded at 15%)
- Improved status display to show experience progress and sass level

### Fixed
- **State file naming bug**: Changed from `.dragonpet_state.json` to `.powershellpet_config.json` (leftover from earlier naming)
- Config file path: Now uses `.powershellpet_config.json`

## [1.1.0] - 2025-10-25

### Added
- Automatic git commit tracking
- Git wrapper function for seamless integration
- `Enable-PetGitTracking` command

### Changed
- Simplified installation process
- No manual commit tracking needed

## [1.0.0] - 2025-10-24

### Added
- Initial release
- Sassy cat companion in terminal
- Multiple moods (Happy, Sleepy, Coding, Grumpy, Excited, Fire)
- Witty commentary and quotes
- Level system based on commits
- Persistent state
- `Show-PetStatus` command
- `Invoke-PetCommit` command
