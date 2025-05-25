# Space Data - Python Module
# For www.spacetravel.com innovative solutions
# Created: May 25, 2025

from typing import Dict, Any, Union, Optional, List
from dataclasses import dataclass

# Define planetary bodies with fixed data (will never change)
@dataclass
class PlanetaryBody:
    name: str
    distance_from_earth: float  # kilometers
    diameter: float            # kilometers
    gravity: float             # m/s²
    description: str
    
    @property
    def distance_from_earth_formatted(self) -> str:
        """Return the distance with proper formatting and units"""
        return f"{self.distance_from_earth:,.0f} km"

# Define transportation vehicles with variable data (expected to change)
@dataclass
class TransportationVehicle:
    name: str
    max_velocity: float       # km/h
    fuel_efficiency: float    # km per fuel unit
    passenger_capacity: int   # people
    cargo_capacity: int       # kg
    description: str
    
    @property
    def max_velocity_formatted(self) -> str:
        """Return the velocity with proper formatting and units"""
        return f"{self.max_velocity:,.2f} km/h"

# Instantiate planetary bodies
PLANETARY_BODIES: Dict[str, PlanetaryBody] = {
    "Moon": PlanetaryBody(
        name="Moon",
        distance_from_earth=384400,
        diameter=3474.8,
        gravity=1.62,
        description="Earth's only natural satellite and the fifth largest moon in the Solar System."
    ),
    "Mars": PlanetaryBody(
        name="Mars",
        distance_from_earth=225000000,
        diameter=6779,
        gravity=3.721,
        description="The fourth planet from the Sun and the second-smallest planet in the Solar System."
    ),
    "Venus": PlanetaryBody(
        name="Venus",
        distance_from_earth=41400000,
        diameter=12104,
        gravity=8.87,
        description="The second planet from the Sun and Earth's closest planetary neighbor."
    ),
    "Mercury": PlanetaryBody(
        name="Mercury",
        distance_from_earth=91700000,
        diameter=4879.4,
        gravity=3.7,
        description="The smallest planet in our Solar System and closest to the Sun."
    ),
}

# Instantiate transportation vehicles
TRANSPORTATION_VEHICLES: Dict[str, TransportationVehicle] = {
    "Standard Spacecraft": TransportationVehicle(
        name="Standard Spacecraft",
        max_velocity=40000,
        fuel_efficiency=20,
        passenger_capacity=10,
        cargo_capacity=5000,
        description="Standard spacecraft for routine space travel."
    ),
    "High-Speed Explorer": TransportationVehicle(
        name="High-Speed Explorer",
        max_velocity=100000,
        fuel_efficiency=15,
        passenger_capacity=6,
        cargo_capacity=3000,
        description="Fast exploration vehicle designed for speed."
    ),
    "Space Shuttle": TransportationVehicle(
        name="Space Shuttle",
        max_velocity=28000,
        fuel_efficiency=25,
        passenger_capacity=8,
        cargo_capacity=10000,
        description="Reliable transport shuttle for cargo and passengers."
    ),
    "Interplanetary Cruiser": TransportationVehicle(
        name="Interplanetary Cruiser",
        max_velocity=75000,
        fuel_efficiency=30,
        passenger_capacity=20,
        cargo_capacity=15000,
        description="Large cruiser designed for long-duration interplanetary travel."
    ),
}

# Functions to access the data
def get_planetary_body(name: str) -> PlanetaryBody:
    """Get a planetary body by name"""
    if name in PLANETARY_BODIES:
        return PLANETARY_BODIES[name]
    else:
        raise ValueError(f"Planetary body '{name}' not found in database.")

def get_transportation_vehicle(name: str) -> TransportationVehicle:
    """Get a transportation vehicle by name"""
    if name in TRANSPORTATION_VEHICLES:
        return TRANSPORTATION_VEHICLES[name]
    else:
        raise ValueError(f"Transportation vehicle '{name}' not found in database.")

def get_all_planetary_bodies() -> Dict[str, PlanetaryBody]:
    """Get all planetary bodies"""
    return PLANETARY_BODIES

def get_all_transportation_vehicles() -> Dict[str, TransportationVehicle]:
    """Get all transportation vehicles"""
    return TRANSPORTATION_VEHICLES

def update_transportation_vehicle(
    name: str,
    max_velocity: Optional[float] = None,
    fuel_efficiency: Optional[float] = None,
    passenger_capacity: Optional[int] = None,
    cargo_capacity: Optional[int] = None,
    description: Optional[str] = None
) -> TransportationVehicle:
    """Update a transportation vehicle's properties"""
    if name not in TRANSPORTATION_VEHICLES:
        raise ValueError(f"Transportation vehicle '{name}' not found in database.")
    
    vehicle = TRANSPORTATION_VEHICLES[name]
    
    if max_velocity is not None:
        vehicle.max_velocity = max_velocity
    
    if fuel_efficiency is not None:
        vehicle.fuel_efficiency = fuel_efficiency
    
    if passenger_capacity is not None:
        vehicle.passenger_capacity = passenger_capacity
    
    if cargo_capacity is not None:
        vehicle.cargo_capacity = cargo_capacity
    
    if description is not None:
        vehicle.description = description
    
    return vehicle
