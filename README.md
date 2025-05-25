# CCRI Programming Projects

This repository contains programming assignments for the Community College of Rhode Island.

## Projects

### 1. USS Enterprise ASCII Art
Displays ASCII art of the Constitution Class USS Enterprise (NCC-1701) in three different programming languages.

### 2. User Activity Logger
A cybersecurity tool for www.spacetravel.com that logs user activities with detailed, personalized output.

### 3. Space Journey Calculator
An innovative tool that calculates the duration of travel to the Moon or Mars based on the traveler's specified velocity.

## Project Structure

```
CCRI_Repos_Projects/
├── PowerShell/
│   ├── Enterprise.ps1
│   ├── UserLogger.ps1
│   ├── SpaceJourneyCalculator.ps1
│   ├── EnhancedSpaceJourneyCalculator.ps1
│   ├── SpaceData.psm1
│   └── SpaceLogger.psm1
├── Bash/
│   ├── enterprise.sh
│   └── UserLogger.sh
└── Python/
    ├── enterprise.py
    ├── UserLogger.py
    ├── SpaceJourneyCalculator.py
    ├── EnhancedSpaceJourneyCalculator.py
    ├── space_data.py
    └── space_logger.py
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

### Space Journey Calculator

#### Standard Versions

##### PowerShell Version
```powershell
cd PowerShell
.\SpaceJourneyCalculator.ps1
```

##### Python Version
```python
cd Python
python SpaceJourneyCalculator.py
```

#### Enhanced Versions (New!)

##### PowerShell Enhanced Version
```powershell
cd PowerShell
.\EnhancedSpaceJourneyCalculator.ps1
```

##### Python Enhanced Version
```python
cd Python
python EnhancedSpaceJourneyCalculator.py
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

### Space Journey Calculator
An interactive tool that calculates travel duration to space destinations with enhanced user interface features. Available in both standard and enhanced versions.

#### Standard Version Features
- Provides clear, user-friendly prompts with examples (e.g., "Enter your name (e.g., John Smith)")
- Collects traveler's name and country of origin with example guidance
- Validates year input with specified ranges (e.g., "Enter the year (2025-2055)")
- Accepts travel velocity with unit specification (km/h) and contextual examples
- Offers destination options with clear distance information
- Formats output with appropriate units and decimal precision

#### Enhanced Version Features (New!)
- **Advanced Input Validation:**
  - Comprehensive error handling with clear explanations for out-of-range values
  - Detailed guidance when input is rejected (e.g., reasons why a velocity exceeds limits)
  - Structured prompts with examples and context-sensitive help

- **Structured Data Model:**
  - Planetary Bodies (fixed data) including Moon, Mars, Venus, and Mercury
  - Transportation Vehicles (variable data) with different specifications
  - Clear separation between fixed astronomical data and changeable vehicle specifications

- **Robust Logging System:**
  - Multi-level logging (DEBUG, INFO, WARNING, ERROR, CRITICAL)
  - Console output with color-coding by severity level
  - File logging for persistent record-keeping
  - Detailed journey records with timestamps and user information

- **Enhanced Error Handling:**
  - Graceful error recovery
  - User-friendly error messages
  - Technical details logged for debugging

- **Professional Output:**
  - Comprehensive journey reports with clearly formatted sections
  - Calculation of fuel requirements and estimated costs
  - Plain English explanations of technical calculations

The enhanced calculator demonstrates advanced software development practices while maintaining an engaging, user-friendly interface.

---

Community College of Rhode Island - Programming Assignments (2025)
