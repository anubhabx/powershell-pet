@{
    # Script module or binary module file associated with this manifest.
    RootModule = 'PowerShellPet.psm1'
    
    # Scripts to run before importing this module
    ScriptsToProcess = @()

    # Version number of this module.
    ModuleVersion = '1.1.0'

    # ID used to uniquely identify this module
    GUID = 'a1b2c3d4-e5f6-4a5b-8c9d-0e1f2a3b4c5d'

    # Author of this module
    Author = 'PowerShellPet Contributors'

    # Company or vendor of this module
    CompanyName = 'Unknown'

    # Copyright statement for this module
    Copyright = '(c) 2025. All rights reserved.'

    # Description of the functionality provided by this module
    Description = 'A sassy cat companion for your PowerShell terminal. Lord Whiskers adds personality to your command line with witty commentary, multiple moods, and a leveling system based on your git commits.'

    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion = '5.1'

    # Functions to export from this module
    FunctionsToExport = @('Show-PetStatus', 'Invoke-PetCommit', 'prompt', 'git', 'Enable-PetGitTracking')

    # Cmdlets to export from this module
    CmdletsToExport = @()

    # Variables to export from this module
    VariablesToExport = @()

    # Aliases to export from this module
    AliasesToExport = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess
    PrivateData = @{
        PSData = @{
            # Tags applied to this module for discoverability
            Tags = @('PowerShell', 'Terminal', 'Fun', 'Cat', 'Prompt', 'Git', 'Productivity', 'Entertainment')

            # A URL to the license for this module.
            LicenseUri = ''

            # A URL to the main website for this project.
            ProjectUri = ''

            # A URL to an icon representing this module.
            IconUri = ''

            # ReleaseNotes of this module
            ReleaseNotes = 'v1.1.0 - Automatic git commit tracking now works out of the box! No extra setup needed - just install and use git normally. Lord Whiskers will automatically celebrate your commits.'
        }
    }
}
