<#
.SYNOPSIS
    Robocopy memory cards to an external drive.
.DESCRIPTION
    Each memory card will have a file called CardID.txt which has a single string in it which defines that card.
    This program will robocopy the card to a folder named for that card on an external drive under <drive>:\MemoryCards\<cardID>.
    The drive letters for the card and the hard drive will be optional arguments, but will have defaults.
        For example:  RemovableDisk = H,   Archive = F.
.EXAMPLE
    Backup-MemoryCards.ps1       (no arguments)
.EXAMPLE
    Backup-MemoryCards.ps1 -RemovableDrive H -ArchiveDrive F
#>

param(
    [string]$RemovableDrive ='H',
    [string]$ArchiveDrive='F'
)

$RemovableDrive+=":"
$ArchiveDrive+=":"

# Verify these are legit drives.
if (-not(Test-Path $RemovableDrive)){
    Write-Host "Memory card not found at: $RemovableDrive"
    break
}

if (-not(Test-Path $ArchiveDrive)){
    Write-Host "Archive drive not found at: $ArchiveDrive"
    break
}

# Get CardID
if(Test-Path -Path $RemovableDrive\CardID.txt){
    $CardID = Get-Content -Path $RemovableDrive\CardID.txt
}
else{
    Write-Host "CardID.txt not found."
    break
}

# Create destination folder
if (-not (Test-Path -Path $ArchiveDrive\MemoryCards\$CardID)){
    mkdir $ArchiveDrive\MemoryCards\$CardID
}

# Robocopy the files.  Robocopy defaults to skipping empty folders.
robocopy $RemovableDrive\   $ArchiveDrive\MemoryCards\$CardID\ /s       # /s == recursive
