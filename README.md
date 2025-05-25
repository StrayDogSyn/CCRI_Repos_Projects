# CCRI Programming Projects

This repository contains programming assignments for the Community College of Rhode Island.

## Projects

### 1. USS Enterprise ASCII Art
Displays ASCII art of the Constitution Class USS Enterprise (NCC-1701) in three different programming languages.

### 2. User Activity Logger
A cybersecurity tool for www.spacetravel.com that logs user activities with detailed, personalized output.

## Project Structure

```
CCRI_Repos_Projects/
├── PowerShell/
│   ├── Enterprise.ps1
│   └── UserLogger.ps1
├── Bash/
│   ├── enterprise.sh
│   └── UserLogger.sh
└── Python/
    ├── enterprise.py
    └── UserLogger.py
```

## How to Run

### USS Enterprise ASCII Art

#### PowerShell Version
```powershell
cd PowerShell
.\Enterprise.ps1
```

#### Bash Version
```bash
cd Bash
bash enterprise.sh
# Or if you have execution permissions:
# chmod +x enterprise.sh
# ./enterprise.sh
```

#### Python Version
```python
cd Python
python enterprise.py
```

### User Activity Logger

#### PowerShell Version
```powershell
cd PowerShell
.\UserLogger.ps1
```

#### Bash Version
```bash
cd Bash
bash UserLogger.sh
# Or if you have execution permissions:
# chmod +x UserLogger.sh
# ./UserLogger.sh
```

#### Python Version
```python
cd Python
python UserLogger.py
```

## Project Details

### USS Enterprise ASCII Art
Displays ASCII art of the Constitution Class USS Enterprise (NCC-1701). The artwork is displayed using monospace font characters, carefully arranged to form the shape of the starship.

For best results in Visual Studio Code:
1. Open VSCode settings: File > Preferences > Settings
2. Search for "terminal integrated font family"
3. Set it to a monospaced font like "Courier New"

This ensures the ASCII art is displayed properly with correct alignment.

### User Activity Logger
A cybersecurity tool designed for www.spacetravel.com that:

- Retrieves the current user's username from system environment variables
- Attempts to get the full name from available environment variables
- Records the current date and time
- Collects system information like hostname and IP address
- Generates a detailed log message and saves it to a log file

This tool is designed to demonstrate security logging practices in different programming languages.

---

Community College of Rhode Island - Programming Assignments (2025)
