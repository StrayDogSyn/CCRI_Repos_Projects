# Space Journey Calculator - Enhanced PowerShell Version
# For www.spacetravel.com innovative solutions
# Created: May 25, 2025

# Import required modules
Import-Module -Name "$PSScriptRoot\SpaceLogger.psm1" -Force
Import-Module -Name "$PSScriptRoot\SpaceData.psm1" -Force

function Calculate-SpaceJourney {
    # Initialize logging
    Write-SpaceLog -Message "Space Journey Calculator started" -Level INFO -ToFile
    
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
    
    #===== USER INPUT SECTION =====
    Write-SpaceLog -Message "Beginning user input collection" -Level DEBUG -ToFile
    
    # Get user's name with example and validation
    Write-Host "`nWelcome to the Space Journey Calculator!" -ForegroundColor Green
    $travelerName = ""
    while ([string]::IsNullOrWhiteSpace($travelerName)) {
        $travelerName = Read-Host "Please enter your name (e.g., John Smith)"
        if ([string]::IsNullOrWhiteSpace($travelerName)) {
            Write-SpaceLog -Message "Invalid name provided: empty name" -Level WARNING -ToFile
            Write-Host "Name cannot be empty. Please enter a valid name." -ForegroundColor Red
        }
    }
    Write-SpaceLog -Message "User name collected: $travelerName" -Level INFO -ToFile
    
    # Get country with examples and validation
    $country = ""
    while ([string]::IsNullOrWhiteSpace($country)) {
        $country = Read-Host "Please enter your country (e.g., United States, Canada, Mexico)"
        if ([string]::IsNullOrWhiteSpace($country)) {
            Write-SpaceLog -Message "Invalid country provided: empty country" -Level WARNING -ToFile
            Write-Host "Country cannot be empty. Please enter a valid country." -ForegroundColor Red
        }
    }
    Write-SpaceLog -Message "User country collected: $country" -Level INFO -ToFile
    
    # Greet the user by name
    Write-Host "`nHello, $travelerName from $country! Let's plan your space journey." -ForegroundColor Yellow

    # Get today's date for the journey
    $today = Get-Date
    Write-Host "`nToday's date is $($today.ToString('yyyy-MM-dd'))." -ForegroundColor White

    # Year selection with range validation
    $currentYear = $today.Year
    $validYear = $false
    $year = 0
    do {
        try {
            $yearInput = Read-Host "`nEnter the year of travel ($currentYear-$($currentYear+30))"
            
            if (-not [int]::TryParse($yearInput, [ref]$year)) {
                Write-SpaceLog -Message "Invalid year format provided: $yearInput" -Level WARNING -ToFile
                Write-Host "Invalid input. Please enter a valid year (numeric value)." -ForegroundColor Red
                continue
            }
            
            if ($year -lt $currentYear -or $year -gt ($currentYear + 30)) {
                Write-SpaceLog -Message "Year out of valid range: $year" -Level WARNING -ToFile
                Write-Host "Year must be between $currentYear and $($currentYear+30)." -ForegroundColor Red
                Write-Host "- Values below $currentYear are in the past" -ForegroundColor Red
                Write-Host "- Values above $($currentYear+30) exceed our reservation system capabilities" -ForegroundColor Red
                continue
            }
            
            $validYear = $true
            Write-SpaceLog -Message "Valid travel year selected: $year" -Level INFO -ToFile
        }
        catch {
            Write-SpaceLog -Message "Exception in year input: $($_.Exception.Message)" -Level ERROR -ToFile
            Write-Host "An error occurred. Please try again." -ForegroundColor Red
        }
    } while (-not $validYear)
    
    # Calculate travel date
    $travelDate = Get-Date -Year $year -Month $today.Month -Day $today.Day
    Write-Host "`nYour journey is planned for: $($travelDate.ToString('yyyy-MM-dd'))" -ForegroundColor White
    $daysTillTravel = (New-TimeSpan -Start $today -End $travelDate).Days
    
    if ($daysTillTravel -gt 0) {
        Write-Host "That's $daysTillTravel days from today." -ForegroundColor White
    }
    
    # Vehicle selection with validation
    Write-Host "`nAvailable Transportation Vehicles:" -ForegroundColor Yellow
    $vehicles = Get-AllTransportationVehicles
    $validVehicle = $false
    $selectedVehicle = $null
    $vehicleOptions = @{}
    $index = 1

    foreach ($vehicle in $vehicles.GetEnumerator()) {
        $vehicleOptions[$index] = $vehicle.Key
        Write-Host "$index. $($vehicle.Key) (Max Velocity: $($vehicle.Value.MaxVelocity.ToString('N0')) km/h)" -ForegroundColor Cyan
        $index++
    }
    
    do {
        try {
            $vehicleChoice = Read-Host "`nSelect a transportation vehicle (1-$($vehicleOptions.Count))"
            $vehicleIndex = 0
            
            if (-not [int]::TryParse($vehicleChoice, [ref]$vehicleIndex) -or 
                $vehicleIndex -lt 1 -or 
                $vehicleIndex -gt $vehicleOptions.Count) {
                Write-SpaceLog -Message "Invalid vehicle selection: $vehicleChoice" -Level WARNING -ToFile
                Write-Host "Invalid choice. Please enter a number between 1 and $($vehicleOptions.Count)." -ForegroundColor Red
                continue
            }
            
            $selectedVehicleName = $vehicleOptions[$vehicleIndex]
            $selectedVehicle = $vehicles[$selectedVehicleName]
            $validVehicle = $true
            Write-SpaceLog -Message "Vehicle selected: $selectedVehicleName" -Level INFO -ToFile
        }
        catch {
            Write-SpaceLog -Message "Exception in vehicle selection: $($_.Exception.Message)" -Level ERROR -ToFile
            Write-Host "An error occurred. Please try again." -ForegroundColor Red
        }
    } while (-not $validVehicle)
    
    Write-Host "`nYou selected: $($selectedVehicle.Name)" -ForegroundColor White
    Write-Host "Maximum Velocity: $($selectedVehicle.MaxVelocity.ToString('N0')) km/h" -ForegroundColor White
    Write-Host "Passenger Capacity: $($selectedVehicle.PassengerCapacity) people" -ForegroundColor White
    Write-Host "Cargo Capacity: $($selectedVehicle.CargoCapacity.ToString('N0')) kg" -ForegroundColor White
    
    # Velocity input with validation and examples
    $velocity = 0
    $validVelocity = $false
    
    # Default to maximum velocity of selected vehicle
    $suggestedVelocity = $selectedVehicle.MaxVelocity * 0.8  # 80% of max for safety
    
    do {
        try {
            Write-Host "`nRecommended velocity: $($suggestedVelocity.ToString('N0')) km/h (80% of maximum)" -ForegroundColor Cyan
            $velocityInput = Read-Host "Please enter your travel velocity in km/h (1-$($selectedVehicle.MaxVelocity.ToString('N0')))"
            
            if (-not [double]::TryParse($velocityInput, [ref]$velocity)) {
                Write-SpaceLog -Message "Invalid velocity format: $velocityInput" -Level WARNING -ToFile
                Write-Host "Invalid input. Please enter a numeric value." -ForegroundColor Red
                continue
            }
            
            if ($velocity -le 0) {
                Write-SpaceLog -Message "Invalid velocity value (zero or negative): $velocity" -Level WARNING -ToFile
                Write-Host "Velocity must be greater than zero." -ForegroundColor Red
                Write-Host "- Space travel requires positive velocity" -ForegroundColor Red
                continue
            }
            
            if ($velocity -gt $selectedVehicle.MaxVelocity) {
                Write-SpaceLog -Message "Velocity exceeds vehicle maximum: $velocity > $($selectedVehicle.MaxVelocity)" -Level WARNING -ToFile
                Write-Host "Velocity cannot exceed the maximum velocity of the selected vehicle ($($selectedVehicle.MaxVelocity.ToString('N0')) km/h)." -ForegroundColor Red
                Write-Host "- Exceeding the maximum velocity would damage the vehicle" -ForegroundColor Red
                Write-Host "- Safety protocols prevent exceeding maximum velocity" -ForegroundColor Red
                continue
            }
            
            $validVelocity = $true
            Write-SpaceLog -Message "Valid velocity selected: $velocity km/h" -Level INFO -ToFile
        }
        catch {
            Write-SpaceLog -Message "Exception in velocity input: $($_.Exception.Message)" -Level ERROR -ToFile
            Write-Host "An error occurred. Please try again." -ForegroundColor Red
        }
    } while (-not $validVelocity)
    
    # Format velocity with commas and units
    $formattedVelocity = "{0:N2} km/h" -f $velocity
    Write-Host "You've selected a travel velocity of $formattedVelocity" -ForegroundColor White
    
    # Destination selection with clear options and validation
    Write-Host "`nAvailable Destinations:" -ForegroundColor Yellow
    $planets = Get-AllPlanetaryBodies
    $validDestination = $false
    $selectedPlanet = $null
    $planetOptions = @{}
    $index = 1

    foreach ($planet in $planets.GetEnumerator()) {
        $planetOptions[$index] = $planet.Key
        Write-Host "$index. $($planet.Key) ($($planet.Value.DistanceFromEarth.ToString('N0')) km from Earth)" -ForegroundColor Cyan
        $index++
    }
    
    do {
        try {
            $planetChoice = Read-Host "`nSelect a destination (1-$($planetOptions.Count))"
            $planetIndex = 0
            
            if (-not [int]::TryParse($planetChoice, [ref]$planetIndex) -or 
                $planetIndex -lt 1 -or 
                $planetIndex -gt $planetOptions.Count) {
                Write-SpaceLog -Message "Invalid destination selection: $planetChoice" -Level WARNING -ToFile
                Write-Host "Invalid choice. Please enter a number between 1 and $($planetOptions.Count)." -ForegroundColor Red
                continue
            }
            
            $selectedPlanetName = $planetOptions[$planetIndex]
            $selectedPlanet = $planets[$selectedPlanetName]
            $validDestination = $true
            Write-SpaceLog -Message "Destination selected: $selectedPlanetName" -Level INFO -ToFile
        }
        catch {
            Write-SpaceLog -Message "Exception in destination selection: $($_.Exception.Message)" -Level ERROR -ToFile
            Write-Host "An error occurred. Please try again." -ForegroundColor Red
        }
    } while (-not $validDestination)
    
    Write-Host "`nYou selected: $($selectedPlanet.Name)" -ForegroundColor White
    Write-Host "Distance from Earth: $($selectedPlanet.DistanceFromEarth.ToString('N0')) km" -ForegroundColor White
    Write-Host "Gravity: $($selectedPlanet.Gravity) m/s²" -ForegroundColor White
    Write-Host "Description: $($selectedPlanet.Description)" -ForegroundColor White

    #===== CALCULATION SECTION =====
    Write-SpaceLog -Message "Beginning journey calculations" -Level DEBUG -ToFile
    
    try {
        # Extract the distance from the planetary body
        $distance = $selectedPlanet.DistanceFromEarth
        
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
        
        # Calculate fuel usage
        $fuelUnits = $distance / $selectedVehicle.FuelEfficiency
        
        # Calculate journey cost (fictional rate of $1000 per million km)
        $journeyCost = ($distance / 1000000) * 1000
        
        Write-SpaceLog -Message "Journey calculations completed successfully" -Level INFO -ToFile
    }
    catch {
        Write-SpaceLog -Message "Error in journey calculations: $($_.Exception.Message)" -Level ERROR -ToFile
        Write-Host "`nAn error occurred while calculating your journey details." -ForegroundColor Red
        Write-Host "Please try again with different parameters." -ForegroundColor Red
        return
    }
    
    #===== RESULTS SECTION =====
    # Generate the result message with proper formatting
    $resultMessage = @"

===== SPACE TRAVEL JOURNEY CALCULATION =====
Traveler: $travelerName
Country: $country
Travel Date: $($travelDate.ToString('yyyy-MM-dd'))

Vehicle: $($selectedVehicle.Name)
Maximum Velocity: $($selectedVehicle.MaxVelocity.ToString('N2')) km/h
Selected Velocity: $($velocity.ToString('N2')) km/h
Fuel Efficiency: $($selectedVehicle.FuelEfficiency.ToString('N2')) km per unit

Destination: $($selectedPlanet.Name)
Distance: $($distance.ToString('N0')) km

Estimated Journey Details:
- Duration: $($durationHours.ToString('N5')) hours
           $($durationDays.ToString('N5')) days
           $($durationMonths.ToString('N5')) months
           $($durationYears.ToString('N5')) years

- Plain English: Your journey to $($selectedPlanet.Name) will take approximately 
  $([Math]::Floor($durationDays)) days, $wholeHours hours, and $wholeMinutes minutes
  at your selected speed of $($velocity.ToString('N2')) km/h.

- Fuel Required: $($fuelUnits.ToString('N2')) units
- Estimated Arrival: $($arrivalDate.ToString('yyyy-MM-dd HH:mm'))
- Estimated Cost: `$$($journeyCost.ToString('N2'))
============================================

"@

    # Display result with formatting
    Write-Host $resultMessage -ForegroundColor Green
    
    # Log the journey details
    Write-SpaceLog -Message "Journey to $($selectedPlanet.Name) calculated for $travelerName" -Level INFO -ToFile
    Write-SpaceLog -Message "Journey duration: $($durationDays.ToString('N2')) days at $($velocity.ToString('N2')) km/h" -Level INFO -ToFile
    Write-SpaceLog -Message "Journey cost: `$$($journeyCost.ToString('N2'))" -Level INFO -ToFile
    
    # Save the journey details to a file
    $journeyLogFile = Join-Path -Path $PSScriptRoot -ChildPath "JourneyDetails_$($travelerName.Replace(' ', '_'))_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
    $resultMessage | Out-File -FilePath $journeyLogFile -Encoding UTF8
    Write-Host "Your journey details have been saved to: $journeyLogFile" -ForegroundColor Yellow
    
    # Option to calculate another journey
    $anotherJourney = Read-Host "Would you like to calculate another journey? (y/n)"
    if ($anotherJourney -eq "y" -or $anotherJourney -eq "Y") {
        Write-SpaceLog -Message "User requested another journey calculation" -Level INFO -ToFile
        Calculate-SpaceJourney
    }
    else {
        Write-Host "`nThank you for using the Space Journey Calculator!" -ForegroundColor Yellow
        Write-Host "www.spacetravel.com - Your Gateway to the Stars" -ForegroundColor Cyan
        Write-SpaceLog -Message "Space Journey Calculator session ended" -Level INFO -ToFile
    }
}

# Start the calculation
try {
    Calculate-SpaceJourney
}
catch {
    Write-Host "A critical error occurred: $($_.Exception.Message)" -ForegroundColor Red
    Write-SpaceLog -Message "Critical error in Space Journey Calculator: $($_.Exception.Message)" -Level CRITICAL -ToFile
    Write-Host "Please contact support@spacetravel.com for assistance." -ForegroundColor Yellow
}
