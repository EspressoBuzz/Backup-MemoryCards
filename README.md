# Backup-MemoryCards

A utility to backup memory cards to an external drive, implemented in both PowerShell and Python.

## Overview

This project provides scripts to automatically backup memory cards to an external drive. Each memory card should contain a `CardID.txt` file that uniquely identifies the card. The contents of the card will be copied to a destination folder named after the card's ID.

## Implementations

### PowerShell Version ([Backup-MemoryCards.ps1](Backup-MemoryCards.ps1))
- Supports command line arguments for source and destination drives
- Includes `-WhatIf` parameter for dry runs
- Validates drive letter inputs
- Uses robocopy with recursive option

Usage:
```powershell
.\Backup-MemoryCards.ps1 -RemovableDrive H: -ArchiveDrive F:
```

### Python Version ([Backup-MemoryCards.py](Backup-MemoryCards.py))
- Uses py-robocopy package
- Simpler implementation with hardcoded drive letters
- Creates destination directories automatically

Usage:
```python
# Install required package first
pip install py-robocopy

# Then run the script
python Backup-MemoryCards.py
```

## Requirements

- PowerShell version requires PowerShell 5.1 or later
- Python version requires:
  - Python 3.x
  - py-robocopy package
  - Windows OS (for robocopy functionality)

## Setup

Each memory card should have a `CardID.txt` file in its root directory containing a unique identifier for that card.

## File Structure
```
destination_drive:\MemoryCards\
    └── {CardID}\
        └── (copied card contents)
```
