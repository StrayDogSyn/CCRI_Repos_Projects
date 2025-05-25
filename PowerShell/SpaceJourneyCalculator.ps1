# Space Journey Calculator - PowerShell Version
# For www.spacetravel.com innovative solutions
# Created: May 25, 2025

function Calculate-SpaceJourney {
    # Clear the screen for better user experience
    Clear-Host
    
    # ASCII art header for a more engaging experience
    $header = @"
    
    ____                       __                         __
   / __/___  ___ ___________ _/ /____  ____ ___ ___ ____ / /
  _\ \/ _ \/ _ `/ __/ __/ _ `/ __/ _ \/ __/ -_|_-</ __// / 
 /___/ .__/\_,_/\__/_/  \_,_/\__/\___/_/  \__/___/\__//_/  
    /_/                                                    
       ___                               ____      __         __     __         
      / _ \___ ___ _____  ___ ___ __ __ / __/__ __/ /_____ __/ /__ _/ /____  ___
     / // / _ `/ // / _ \/ -_) _ \\ \ // _// // / / / -_) `/ / _ `/ __/ _ \/ _ \ 
    /____/\_,_/\_, / .__/\__/_//_/_\_\/_/  \_,_/_/_/\__/\_/_/\_,_/\__/\___/_//_/ 
              /___/_/                                                              

"@
    Write-Host $header -ForegroundColor Cyan
    
    # Define the distances (in kilometers)
    $distanceToMoon = 384400
    $distanceToMars = 225000000
    
    # Get user's name
    Write-Host "`nWelcome to the Space Journey Calculator!" -ForegroundColor Green
    $travelerName = Read-Host "Please enter your name"
    
    # Greet the user by name
    Write-Host "`nHello, $travelerName! Let's plan your space journey." -ForegroundColor Yellow
    
    # Velocity input with validation
    do {
        $velocityInput = Read-Host "`nPlease enter your travel velocity (in km/h)"
        $velocity = 0
        $isValid = [double]::TryParse($velocityInput, [ref]$velocity)
        
        if (-not $isValid) {
            Write-Host "Invalid input. Please enter a numeric value." -ForegroundColor Red
        }
        elseif ($velocity -le 0) {
            Write-Host "Velocity must be greater than zero." -ForegroundColor Red
            $isValid = $false
        }
    } while (-not $isValid)
    
    # Destination selection
    $validChoice = $false
    do {
        Write-Host "`nSelect your destination:" -ForegroundColor Yellow
        Write-Host "1. Moon (384,400 km from Earth)" -ForegroundColor Cyan
        Write-Host "2. Mars (225,000,000 km from Earth)" -ForegroundColor Cyan
        $destinationChoice = Read-Host "Enter 1 for Moon or 2 for Mars"
        
        if ($destinationChoice -eq "1" -or $destinationChoice -eq "2") {
            $validChoice = $true
        }
        else {
            Write-Host "Invalid choice. Please enter 1 or 2." -ForegroundColor Red
        }
    } while (-not $validChoice)
    
    # Calculate journey duration
    if ($destinationChoice -eq "1") {
        $destination = "Moon"
        $distance = $distanceToMoon
    }
    else {
        $destination = "Mars"
        $distance = $distanceToMars
    }
    
    # Perform calculation (distance / velocity)
    $durationHours = $distance / $velocity
    
    # Convert to days, hours, minutes for better readability
    $durationDays = [Math]::Floor($durationHours / 24)
    $remainingHours = [Math]::Floor($durationHours % 24)
    $remainingMinutes = [Math]::Floor(($durationHours * 60) % 60)
    
    # Generate the result message
    $resultMessage = @"

===== SPACE TRAVEL JOURNEY CALCULATION =====
Traveler: $travelerName
Destination: $destination
Distance: $($distance.ToString('N0')) kilometers
Velocity: $($velocity.ToString('N0')) km/h

Estimated Journey Duration:
- Total Hours: $($durationHours.ToString('N2')) hours
- In Days/Hours/Minutes: $durationDays days, $remainingHours hours, $remainingMinutes minutes
============================================

"@
    
    # Display result with formatting
    Write-Host $resultMessage -ForegroundColor Green
    
    # Option to calculate another journey
    $anotherJourney = Read-Host "Would you like to calculate another journey? (y/n)"
    if ($anotherJourney -eq "y" -or $anotherJourney -eq "Y") {
        Calculate-SpaceJourney
    }
    else {
        Write-Host "`nThank you for using the Space Journey Calculator!" -ForegroundColor Yellow
        Write-Host "www.spacetravel.com - Your Gateway to the Stars" -ForegroundColor Cyan
    }
}

# Start the calculation
Calculate-SpaceJourney
