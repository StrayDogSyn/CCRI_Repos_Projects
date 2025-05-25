# User Activity Logger - PowerShell Version
# For www.spacetravel.com cybersecurity

function Log-UserActivity {
    # Get current date and time
    $currentDateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    # Get user information from environment variables
    $username = $env:USERNAME  # Login username
    $computerName = $env:COMPUTERNAME
    
    # Try to get full name from different possible environment variables
    $fullName = $env:USER
    if (-not $fullName) {
        # If USER isn't set, try other potential variables
        $fullName = $env:USERPROFILE.Split('\')[-1]
    }
    
    # Get additional system information for security logging
    $ipAddress = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "*Ethernet*" | Select-Object -First 1).IPAddress
    if (-not $ipAddress) {
        # Try to get Wi-Fi address if Ethernet isn't available
        $ipAddress = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "*Wi-Fi*" | Select-Object -First 1).IPAddress
    }
    
    # Create log message
    $logMessage = @"
===== SPACE TRAVEL CYBERSECURITY LOG =====
Date and Time: $currentDateTime
User Details:
- Username: $username
- Full Name: $fullName
- Computer Name: $computerName
- IP Address: $ipAddress
============================================
"@

    # Display log message
    Write-Host $logMessage
    
    # Optionally, log to a file
    $logFile = Join-Path $PSScriptRoot "user_activity_log.txt"
    Add-Content -Path $logFile -Value "$logMessage`n"
    
    Write-Host "Log has been written to: $logFile"
}

# Call the function to log user activity
Log-UserActivity
