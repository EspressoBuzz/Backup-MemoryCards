<#
.SYNOPSIS
    Robocopy memory cards to an external drive.
.DESCRIPTION
    Each memory card will have a file called CardID.txt which has a single string in it which defines that card.
    This program will robocopy the card to a folder named for that card on an external drive under <drive>:\MemoryCards\<cardID>.
    The drive letters for the card and the hard drive will be optional arguments, but will have defaults.
        For example:  RemovableDisk = H,   Archive = F.
    Changelist:
        04/04/2023:  Added ValidatePattern to restrict input to single drive letters, and added code to pass -WhatIf preference to robocopy.
.EXAMPLE
    Backup-MemoryCards.ps1       (No arguments. You will be prompted for arguments, but miss out on using -WhatIf.)
.EXAMPLE
    Backup-MemoryCards.ps1 -RemovableDrive H -ArchiveDrive F
#>
[CmdletBinding(SupportsShouldProcess)]    # This is for implementing -WhatIf, which can be passed to robocopy as the '/L' flag.   (List only, don't copy.)
param(
    [Parameter(Mandatory=$true)]
    [ValidatePattern("^[d-zD-Z]$")]    # Parameter validation restricts the future use of that variable to the confines of the validation pattern.
    [string]$RemovableDrive,

    [Parameter(Mandatory=$true)]
    [ValidatePattern("^[d-zD-Z]$")]
    [string]$ArchiveDrive
)

# Check that they didn't enter the same letter 2x.
if($RemovableDrive.ToLower() -eq $ArchiveDrive.ToLower()){
    Write-Host "Please enter different drive letters."
    break
}

# $RemovableDrive+=":"     # You can't modify variables beyond their validate patterns, so this isn't possible.
# $ArchiveDrive+=":"

# Verify these are legit drives.
if (-not(Test-Path $RemovableDrive":")){
    Write-Host "Memory card not found at: $RemovableDrive"
    break
}

if (-not(Test-Path $ArchiveDrive":")){
    Write-Host "Archive drive not found at: $ArchiveDrive"
    break
}

# Get CardID
if(Test-Path -Path $RemovableDrive":"\CardID.txt){
    $CardID = Get-Content -Path $RemovableDrive":"\CardID.txt
}
else{
    Write-Host "CardID.txt not found."
    break
}

# Create destination folder
if (-not (Test-Path -Path $ArchiveDrive":"\MemoryCards\$CardID)){
    mkdir $ArchiveDrive":"\MemoryCards\$CardID
}

$WhatIf = ''     # Initialize to empty string
if($WhatIfPreference){       # If script was called with -WhatIf, $WhatIfPreference will be true.
    $WhatIf= "/L"
}

# Robocopy the files.  Robocopy defaults to skipping empty folders.
robocopy $RemovableDrive":"\   $ArchiveDrive":"\MemoryCards\$CardID\ /s  $WhatIf      # /s == recursive
