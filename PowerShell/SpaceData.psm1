# Space Data - PowerShell Module
# For www.spacetravel.com innovative solutions
# Created: May 25, 2025

# Define planetary bodies with fixed data (will never change)
$Global:PlanetaryBodies = @{
    "Moon" = @{
        Name = "Moon"
        DistanceFromEarth = 384400  # kilometers
        Diameter = 3474.8           # kilometers
        Gravity = 1.62              # m/s²
        Description = "Earth's only natural satellite and the fifth largest moon in the Solar System."
    }
    "Mars" = @{
        Name = "Mars"
        DistanceFromEarth = 225000000  # kilometers (average distance)
        Diameter = 6779                # kilometers
        Gravity = 3.721                # m/s²
        Description = "The fourth planet from the Sun and the second-smallest planet in the Solar System."
    }
    "Venus" = @{
        Name = "Venus"
        DistanceFromEarth = 41400000   # kilometers (average distance)
        Diameter = 12104               # kilometers
        Gravity = 8.87                 # m/s²
        Description = "The second planet from the Sun and Earth's closest planetary neighbor."
    }
    "Mercury" = @{
        Name = "Mercury"
        DistanceFromEarth = 91700000   # kilometers (average distance)
        Diameter = 4879.4              # kilometers
        Gravity = 3.7                  # m/s²
        Description = "The smallest planet in our Solar System and closest to the Sun."
    }
}

# Define transportation vehicles with variable data (expected to change)
$Global:TransportationVehicles = @{
    "Standard Spacecraft" = @{
        Name = "Standard Spacecraft"
        MaxVelocity = 40000         # km/h
        FuelEfficiency = 20         # km per fuel unit
        PassengerCapacity = 10      # people
        CargoCapacity = 5000        # kg
        Description = "Standard spacecraft for routine space travel."
    }
    "High-Speed Explorer" = @{
        Name = "High-Speed Explorer"
        MaxVelocity = 100000        # km/h
        FuelEfficiency = 15         # km per fuel unit
        PassengerCapacity = 6       # people
        CargoCapacity = 3000        # kg
        Description = "Fast exploration vehicle designed for speed."
    }
    "Space Shuttle" = @{
        Name = "Space Shuttle"
        MaxVelocity = 28000         # km/h
        FuelEfficiency = 25         # km per fuel unit
        PassengerCapacity = 8       # people
        CargoCapacity = 10000       # kg
        Description = "Reliable transport shuttle for cargo and passengers."
    }
    "Interplanetary Cruiser" = @{
        Name = "Interplanetary Cruiser"
        MaxVelocity = 75000         # km/h
        FuelEfficiency = 30         # km per fuel unit
        PassengerCapacity = 20      # people
        CargoCapacity = 15000       # kg
        Description = "Large cruiser designed for long-duration interplanetary travel."
    }
}

# Functions to access the data
function Get-PlanetaryBody {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Name
    )
    
    if ($Global:PlanetaryBodies.ContainsKey($Name)) {
        return $Global:PlanetaryBodies[$Name]
    } else {
        throw "Planetary body '$Name' not found in database."
    }
}

function Get-TransportationVehicle {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Name
    )
    
    if ($Global:TransportationVehicles.ContainsKey($Name)) {
        return $Global:TransportationVehicles[$Name]
    } else {
        throw "Transportation vehicle '$Name' not found in database."
    }
}

function Get-AllPlanetaryBodies {
    return $Global:PlanetaryBodies
}

function Get-AllTransportationVehicles {
    return $Global:TransportationVehicles
}

function Update-TransportationVehicle {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Name,
        
        [Parameter(Mandatory=$false)]
        [double]$MaxVelocity,
        
        [Parameter(Mandatory=$false)]
        [double]$FuelEfficiency,
        
        [Parameter(Mandatory=$false)]
        [int]$PassengerCapacity,
        
        [Parameter(Mandatory=$false)]
        [int]$CargoCapacity,
        
        [Parameter(Mandatory=$false)]
        [string]$Description
    )
    
    if (-not $Global:TransportationVehicles.ContainsKey($Name)) {
        throw "Transportation vehicle '$Name' not found in database."
    }
    
    $vehicle = $Global:TransportationVehicles[$Name]
    
    if ($PSBoundParameters.ContainsKey('MaxVelocity')) {
        $vehicle.MaxVelocity = $MaxVelocity
    }
    
    if ($PSBoundParameters.ContainsKey('FuelEfficiency')) {
        $vehicle.FuelEfficiency = $FuelEfficiency
    }
    
    if ($PSBoundParameters.ContainsKey('PassengerCapacity')) {
        $vehicle.PassengerCapacity = $PassengerCapacity
    }
    
    if ($PSBoundParameters.ContainsKey('CargoCapacity')) {
        $vehicle.CargoCapacity = $CargoCapacity
    }
    
    if ($PSBoundParameters.ContainsKey('Description')) {
        $vehicle.Description = $Description
    }
    
    return $vehicle
}

# Export functions
Export-ModuleMember -Function Get-PlanetaryBody, Get-TransportationVehicle, Get-AllPlanetaryBodies, Get-AllTransportationVehicles, Update-TransportationVehicle
Export-ModuleMember -Variable PlanetaryBodies, TransportationVehicles
