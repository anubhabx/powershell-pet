# PowerShellPet - Quick Troubleshooting Guide

## "Commits are being skipped!" 

### The Problem
You mentioned that PowerShellPet "sometimes works and sometimes skips actions like pushes and stuff."

### Why This Happens
**PowerShellPet does NOT automatically track git commits by default!**

When you run `git commit`, the module doesn't know about it unless you:
1. Manually call `Invoke-PetCommit` after each commit, OR
2. Set up automatic integration (see solutions below)

### Quick Fix - Choose One:

#### ✅ Solution 1: Git Hooks (Best for most users)
```powershell
.\Install-GitHook.ps1
```
After this, every `git commit` automatically invokes your cat!

#### ✅ Solution 2: Git Wrapper (Alternative)
Add to your `$PROFILE`:
```powershell
. "C:\dev\powershell\PowerShellPet\GitWrapper.ps1"
```

#### ⚠️ Solution 3: Manual (Current behavior)
Remember to run after each commit:
```powershell
git commit -m "message"
Invoke-PetCommit
```

## Other Common Issues

### "Module not found"
```powershell
Import-Module PowerShellPet -Force
```

### "Functions not available"
Check if module is loaded:
```powershell
Get-Module PowerShellPet
```

### "State file corrupted"
Reset the state:
```powershell
Remove-Item (Join-Path $env:USERPROFILE ".dragonpet_state.json")
```
It will be recreated automatically.

### "Hook not working"
Make sure PowerShellPet is in your profile:
```powershell
notepad $PROFILE
```
Should contain:
```powershell
Import-Module PowerShellPet
```

## Testing

Run the manual test suite:
```powershell
.\Tests\ManualTests.ps1
```

This will diagnose issues and show you exactly what's wrong!

## Full Documentation

See `Tests\TESTING_GUIDE.md` for complete testing and troubleshooting information.
