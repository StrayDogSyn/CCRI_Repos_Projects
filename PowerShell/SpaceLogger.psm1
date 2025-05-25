# Space Journey Logger - PowerShell Module
# For www.spacetravel.com innovative solutions
# Created: May 25, 2025

# Logging levels
enum LogLevel {
    DEBUG = 0
    INFO = 1
    WARNING = 2
    ERROR = 3
    CRITICAL = 4
}

# Function to write logs with timestamp, level, and message
function Write-SpaceLog {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message,
        
        [Parameter(Mandatory=$false)]
        [LogLevel]$Level = [LogLevel]::INFO,
        
        [Parameter(Mandatory=$false)]
        [switch]$ToFile,
        
        [Parameter(Mandatory=$false)]
        [string]$LogFile = "SpaceTravel_Log.txt"
    )
    
    # Create timestamp
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    # Format the log message
    $levelString = $Level.ToString().PadRight(8)
    $formattedMessage = "[$timestamp] [$levelString] $Message"
    
    # Set color based on log level
    $foregroundColor = switch ($Level) {
        ([LogLevel]::DEBUG)    { "Gray" }
        ([LogLevel]::INFO)     { "White" }
        ([LogLevel]::WARNING)  { "Yellow" }
        ([LogLevel]::ERROR)    { "Red" }
        ([LogLevel]::CRITICAL) { "Magenta" }
        default               { "White" }
    }
    
    # Write to console
    Write-Host $formattedMessage -ForegroundColor $foregroundColor
    
    # Write to file if requested
    if ($ToFile) {
        # Get the script's directory
        $scriptDir = $PSScriptRoot
        
        # Create full path to log file
        $logFilePath = Join-Path -Path $scriptDir -ChildPath $LogFile
        
        # Append log to file
        Add-Content -Path $logFilePath -Value $formattedMessage
    }
}

# Export functions
Export-ModuleMember -Function Write-SpaceLog
