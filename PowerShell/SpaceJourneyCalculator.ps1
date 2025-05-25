# Space Journey Calculator - PowerShell Version
# For www.spacetravel.com innovative solutions
# Created: May 25, 2025

function Measure-SpaceJourney {
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
      # Get user's name with example
    Write-Host "`nWelcome to the Space Journey Calculator!" -ForegroundColor Green
    $travelerName = Read-Host "Please enter your name (e.g., John Smith)"
    
    # Get country with examples
    $country = Read-Host "Please enter your country (e.g., United States, Canada, Mexico)"
    
    # Greet the user by name
    Write-Host "`nHello, $travelerName from $country! Let's plan your space journey." -ForegroundColor Yellow

    # Get today's date for the journey
    $today = Get-Date
    Write-Host "`nToday's date is $($today.ToString('yyyy-MM-dd'))." -ForegroundColor White

    # Year selection with range validation
    $currentYear = $today.Year
    $validYear = $false
    do {
        $yearInput = Read-Host "`nEnter the year of travel ($currentYear-$($currentYear+30))"
        $year = 0
        $isValidFormat = [int]::TryParse($yearInput, [ref]$year)
        
        if (-not $isValidFormat) {
            Write-Host "Invalid input. Please enter a valid year." -ForegroundColor Red
        }
        elseif ($year -lt $currentYear -or $year -gt ($currentYear + 30)) {
            Write-Host "Year must be between $currentYear and $($currentYear+30)." -ForegroundColor Red
        }
        else {
            $validYear = $true
        }
    } while (-not $validYear)
    
    # Calculate travel date
    $travelDate = Get-Date -Year $year -Month $today.Month -Day $today.Day
    Write-Host "`nYour journey is planned for: $($travelDate.ToString('yyyy-MM-dd'))" -ForegroundColor White
    $daysTillTravel = (New-TimeSpan -Start $today -End $travelDate).Days
    
    if ($daysTillTravel -gt 0) {
        Write-Host "That's $daysTillTravel days from today." -ForegroundColor White
    }
    
    # Velocity input with validation and examples
    do {
        $velocityInput = Read-Host "`nPlease enter your travel velocity (in km/h, e.g., 50000 for spacecraft, 1000 for airplane)"
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
    
    # Format velocity with commas and units
    $formattedVelocity = "{0:N2} km/h" -f $velocity
    Write-Host "You've selected a travel velocity of $formattedVelocity" -ForegroundColor White
    
    # Destination selection with clear options
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
    
    # Convert to various time formats for better understanding
    $durationDays = $durationHours / 24
    $durationMonths = $durationDays / 30.44  # Average month length
    $durationYears = $durationDays / 365.25  # Account for leap years
    
    # Format remaining hours and minutes for display
    $wholeHours = [Math]::Floor($durationHours % 24)
    $wholeMinutes = [Math]::Floor(($durationHours * 60) % 60)
    
    # Calculate arrival date
    $arrivalDate = $travelDate.AddHours($durationHours)
    
    # Calculate journey cost (fictional rate of $1000 per million km)
    $journeyCost = ($distance / 1000000) * 1000
      # Generate the result message with proper formatting
    $resultMessage = @"

===== SPACE TRAVEL JOURNEY CALCULATION =====
Traveler: $travelerName
Country: $country
Travel Date: $($travelDate.ToString('yyyy-MM-dd'))
Destination: $destination
Distance: $($distance.ToString('N0')) km
Velocity: $($velocity.ToString('N2')) km/h

Estimated Journey Details:
- Duration: $($durationHours.ToString('N5')) hours
           $($durationDays.ToString('N5')) days
           $($durationMonths.ToString('N5')) months
           $($durationYears.ToString('N5')) years

- Plain English: Your journey to the $destination will take approximately 
  $([Math]::Floor($durationDays)) days, $wholeHours hours, and $wholeMinutes minutes
  at your selected speed of $($velocity.ToString('N2')) km/h.

- Estimated Arrival: $($arrivalDate.ToString('yyyy-MM-dd HH:mm'))

- Estimated Cost: `$$($journeyCost.ToString('N2'))
============================================

"@
    
    # Display result with formatting
    Write-Host $resultMessage -ForegroundColor Green
    
    # Option to calculate another journey
    $anotherJourney = Read-Host "Would you like to calculate another journey? (y/n)"
    if ($anotherJourney -eq "y" -or $anotherJourney -eq "Y") {
        Measure-SpaceJourney
    }
    else {
        Write-Host "`nThank you for using the Space Journey Calculator!" -ForegroundColor Yellow
        Write-Host "www.spacetravel.com - Your Gateway to the Stars" -ForegroundColor Cyan
    }
}

# Start the calculation
Measure-SpaceJourney
