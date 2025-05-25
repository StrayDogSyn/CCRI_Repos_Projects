#!/usr/bin/env python
# Enhanced Space Journey Calculator - Python Version
# For www.spacetravel.com innovative solutions
# Created: May 25, 2025

import os
import math
import time
import datetime
from typing import Dict, Any, Optional

# Import our custom modules
from space_logger import SpaceLogger, LogLevel
from space_data import (
    get_all_planetary_bodies, 
    get_all_transportation_vehicles,
    PlanetaryBody,
    TransportationVehicle
)

# Initialize logger with file logging
logger = SpaceLogger(log_to_file=True)

def clear_screen() -> None:
    """Clear screen for better user experience - works on both Windows and Unix-like systems"""
    os.system('cls' if os.name == 'nt' else 'clear')

def display_header() -> None:
    """Display the ASCII art header"""
    header = """
    ____                       __                         __
   / __/___  ___ ___________ _/ /____  ____ ___ ___ ____ / /
  _\ \/ _ \/ _ `/ __/ __/ _ `/ __/ _ \/ __/ -_|_-</ __// / 
 /___/ .__/\_,_/\__/_/  \_,_/\__/\___/_/  \__/___/\__//_/  
    /_/                                                    
       ___                               ____      __         __     __         
      / _ \___ ___ _____  ___ ___ __ __ / __/__ __/ /_____ __/ /__ _/ /____  ___
     / // / _ `/ // / _ \/ -_) _ \\\\ \\ // _// // / / / -_) `/ / _ `/ __/ _ \\/ _ \\ 
    /____/\_,_/\_, / .__/\__/_//_/_\_\\/_/  \_,_/_/_/\__/\\_/_/\_,_/\__/\___/_//_/ 
              /___/_/                                                              
    """
    print("\033[96m" + header + "\033[0m")  # Cyan color on most terminals

def get_input_with_validation(prompt: str, validation_fn, error_msg: str, examples: Optional[str] = None) -> Any:
    """
    General function to get user input with validation
    
    Args:
        prompt: The prompt to display to the user
        validation_fn: Function that validates the input and returns (is_valid, validated_value)
        error_msg: Message to display if validation fails
        examples: Optional examples to display with the error message
        
    Returns:
        Validated input value
    """
    while True:
        try:
            user_input = input(prompt)
            is_valid, value = validation_fn(user_input)
            
            if is_valid:
                return value
            
            logger.warning(f"Invalid input: {user_input}")
            print(f"\033[91m{error_msg}\033[0m")
            
            if examples:
                print(f"\033[93m{examples}\033[0m")
                
        except Exception as e:
            logger.error(f"Exception during input: {str(e)}")
            print(f"\033[91mAn error occurred. Please try again.\033[0m")

def calculate_space_journey() -> None:
    """Main function to calculate a space journey"""
    # Start logging
    logger.info("Space Journey Calculator started")
    
    # Clear the screen and display header
    clear_screen()
    display_header()
    
    # ===== USER INPUT SECTION =====
    logger.debug("Beginning user input collection")
    
    # Get user's name with validation
    def validate_name(name: str) -> tuple[bool, str]:
        if name.strip() == "":
            return False, ""
        return True, name.strip()
    
    print("\033[92m\nWelcome to the Space Journey Calculator!\033[0m")
    traveler_name = get_input_with_validation(
        "Please enter your name (e.g., Jane Smith): ",
        validate_name,
        "Name cannot be empty. Please enter a valid name."
    )
    logger.info(f"User name collected: {traveler_name}")
    
    # Get country with validation
    def validate_country(country: str) -> tuple[bool, str]:
        if country.strip() == "":
            return False, ""
        return True, country.strip()
    
    country = get_input_with_validation(
        "Please enter your country (e.g., United States, Canada, Mexico): ",
        validate_country,
        "Country cannot be empty. Please enter a valid country."
    )
    logger.info(f"User country collected: {country}")
    
    # Greet the user by name and country
    print(f"\033[93m\nHello, {traveler_name} from {country}! Let's plan your space journey.\033[0m")
    
    # Get today's date for the journey
    today = datetime.datetime.now()
    print(f"\nToday's date is {today.strftime('%Y-%m-%d')}.")
    
    # Year selection with range validation
    current_year = today.year
    
    def validate_year(year_str: str) -> tuple[bool, int]:
        try:
            year = int(year_str)
            if year < current_year or year > (current_year + 30):
                return False, 0
            return True, year
        except ValueError:
            return False, 0
    
    year = get_input_with_validation(
        f"\nEnter the year of travel ({current_year}-{current_year+30}): ",
        validate_year,
        f"Year must be between {current_year} and {current_year+30}.",
        f"- Values below {current_year} are in the past\n"
        f"- Values above {current_year+30} exceed our reservation system capabilities"
    )
    logger.info(f"Valid travel year selected: {year}")
    
    # Calculate travel date
    travel_date = datetime.datetime(year, today.month, today.day)
    print(f"\nYour journey is planned for: {travel_date.strftime('%Y-%m-%d')}")
    days_till_travel = (travel_date - today).days
    
    if days_till_travel > 0:
        print(f"That's {days_till_travel} days from today.")
    
    # Vehicle selection with validation
    print("\n\033[93mAvailable Transportation Vehicles:\033[0m")
    vehicles = get_all_transportation_vehicles()
    vehicle_options = {}
    
    for i, (name, vehicle) in enumerate(vehicles.items(), 1):
        vehicle_options[i] = name
        print(f"\033[96m{i}. {name} (Max Velocity: {vehicle.max_velocity:,.0f} km/h)\033[0m")
    
    def validate_vehicle_choice(choice_str: str) -> tuple[bool, int]:
        try:
            choice = int(choice_str)
            if choice < 1 or choice > len(vehicle_options):
                return False, 0
            return True, choice
        except ValueError:
            return False, 0
    
    vehicle_choice = get_input_with_validation(
        f"\nSelect a transportation vehicle (1-{len(vehicle_options)}): ",
        validate_vehicle_choice,
        f"Invalid choice. Please enter a number between 1 and {len(vehicle_options)}."
    )
    
    selected_vehicle_name = vehicle_options[vehicle_choice]
    selected_vehicle = vehicles[selected_vehicle_name]
    logger.info(f"Vehicle selected: {selected_vehicle_name}")
    
    print(f"\nYou selected: {selected_vehicle.name}")
    print(f"Maximum Velocity: {selected_vehicle.max_velocity:,.0f} km/h")
    print(f"Passenger Capacity: {selected_vehicle.passenger_capacity} people")
    print(f"Cargo Capacity: {selected_vehicle.cargo_capacity:,.0f} kg")
    
    # Velocity input with validation
    suggested_velocity = selected_vehicle.max_velocity * 0.8  # 80% of max for safety
    
    def validate_velocity(velocity_str: str) -> tuple[bool, float]:
        try:
            velocity = float(velocity_str)
            if velocity <= 0:
                return False, 0
            if velocity > selected_vehicle.max_velocity:
                return False, 0
            return True, velocity
        except ValueError:
            return False, 0
    
    print(f"\n\033[96mRecommended velocity: {suggested_velocity:,.0f} km/h (80% of maximum)\033[0m")
    velocity = get_input_with_validation(
        f"Please enter your travel velocity in km/h (1-{selected_vehicle.max_velocity:,.0f}): ",
        validate_velocity,
        f"Velocity must be positive and cannot exceed {selected_vehicle.max_velocity:,.0f} km/h.",
        "- Space travel requires positive velocity\n"
        "- Exceeding the maximum velocity would damage the vehicle\n"
        "- Safety protocols prevent exceeding maximum velocity"
    )
    logger.info(f"Valid velocity selected: {velocity} km/h")
    
    print(f"You've selected a travel velocity of {velocity:,.2f} km/h")
    
    # Destination selection with validation
    print("\n\033[93mAvailable Destinations:\033[0m")
    planets = get_all_planetary_bodies()
    planet_options = {}
    
    for i, (name, planet) in enumerate(planets.items(), 1):
        planet_options[i] = name
        print(f"\033[96m{i}. {name} ({planet.distance_from_earth:,.0f} km from Earth)\033[0m")
    
    def validate_planet_choice(choice_str: str) -> tuple[bool, int]:
        try:
            choice = int(choice_str)
            if choice < 1 or choice > len(planet_options):
                return False, 0
            return True, choice
        except ValueError:
            return False, 0
    
    planet_choice = get_input_with_validation(
        f"\nSelect a destination (1-{len(planet_options)}): ",
        validate_planet_choice,
        f"Invalid choice. Please enter a number between 1 and {len(planet_options)}."
    )
    
    selected_planet_name = planet_options[planet_choice]
    selected_planet = planets[selected_planet_name]
    logger.info(f"Destination selected: {selected_planet_name}")
    
    print(f"\nYou selected: {selected_planet.name}")
    print(f"Distance from Earth: {selected_planet.distance_from_earth:,.0f} km")
    print(f"Gravity: {selected_planet.gravity} m/s²")
    print(f"Description: {selected_planet.description}")
    
    # ===== CALCULATION SECTION =====
    logger.debug("Beginning journey calculations")
    
    try:
        # Extract the distance from the planetary body
        distance = selected_planet.distance_from_earth
        
        # Perform calculation (distance / velocity)
        duration_hours = distance / velocity
        
        # Convert to various time formats for better understanding
        duration_days = duration_hours / 24
        duration_months = duration_days / 30.44  # Average month length
        duration_years = duration_days / 365.25  # Account for leap years
        
        # Format remaining hours and minutes for display
        whole_days = math.floor(duration_days)
        whole_hours = math.floor(duration_hours % 24)
        whole_minutes = math.floor((duration_hours * 60) % 60)
        
        # Calculate arrival date
        arrival_date = travel_date + datetime.timedelta(hours=duration_hours)
        
        # Calculate fuel usage
        fuel_units = distance / selected_vehicle.fuel_efficiency
        
        # Calculate journey cost (fictional rate of $1000 per million km)
        journey_cost = (distance / 1000000) * 1000
        
        logger.info("Journey calculations completed successfully")
    except Exception as e:
        logger.error(f"Error in journey calculations: {str(e)}")
        print("\n\033[91mAn error occurred while calculating your journey details.")
        print("Please try again with different parameters.\033[0m")
        return
    
    # Add a bit of animation for the calculation
    print("\n\033[93mCalculating journey duration", end="")
    for _ in range(5):
        print(".", end="", flush=True)
        time.sleep(0.3)
    print("\033[0m\n")
    
    # ===== RESULTS SECTION =====
    # Generate the result message with proper formatting
    result_message = f"""
\033[92m===== SPACE TRAVEL JOURNEY CALCULATION =====
Traveler: {traveler_name}
Country: {country}
Travel Date: {travel_date.strftime('%Y-%m-%d')}

Vehicle: {selected_vehicle.name}
Maximum Velocity: {selected_vehicle.max_velocity:,.2f} km/h
Selected Velocity: {velocity:,.2f} km/h
Fuel Efficiency: {selected_vehicle.fuel_efficiency:,.2f} km per unit

Destination: {selected_planet.name}
Distance: {distance:,.0f} km

Estimated Journey Details:
- Duration: {duration_hours:.5f} hours
           {duration_days:.5f} days
           {duration_months:.5f} months
           {duration_years:.5f} years

- Plain English: Your journey to {selected_planet.name} will take approximately
  {whole_days} days, {whole_hours} hours, and {whole_minutes} minutes
  at your selected speed of {velocity:,.2f} km/h.

- Fuel Required: {fuel_units:.2f} units
- Estimated Arrival: {arrival_date.strftime('%Y-%m-%d %H:%M')}
- Estimated Cost: ${journey_cost:,.2f}
============================================\033[0m
"""
    
    # Display result with formatting
    print(result_message)
    
    # Log the journey details
    logger.info(f"Journey to {selected_planet.name} calculated for {traveler_name}")
    logger.info(f"Journey duration: {duration_days:.2f} days at {velocity:.2f} km/h")
    logger.info(f"Journey cost: ${journey_cost:.2f}")
    
    # Save the journey details to a file
    script_dir = os.path.dirname(os.path.abspath(__file__))
    file_timestamp = datetime.datetime.now().strftime('%Y%m%d_%H%M%S')
    journey_log_file = os.path.join(
        script_dir, 
        f"JourneyDetails_{traveler_name.replace(' ', '_')}_{file_timestamp}.txt"
    )
    
    with open(journey_log_file, "w") as f:
        # Strip ANSI color codes when writing to file
        clean_message = result_message.replace("\033[92m", "").replace("\033[0m", "")
        f.write(clean_message)
    
    print(f"Your journey details have been saved to: {journey_log_file}")
    
    # Option to calculate another journey
    another_journey = input("Would you like to calculate another journey? (y/n): ")
    if another_journey.lower() == "y":
        logger.info("User requested another journey calculation")
        calculate_space_journey()
    else:
        print("\n\033[93mThank you for using the Space Journey Calculator!\033[0m")
        print("\033[96mwww.spacetravel.com - Your Gateway to the Stars\033[0m")
        logger.info("Space Journey Calculator session ended")

# Start the calculation
if __name__ == "__main__":
    try:
        calculate_space_journey()
    except Exception as e:
        print(f"\033[91mA critical error occurred: {str(e)}\033[0m")
        logger.log("Critical error in Space Journey Calculator", LogLevel.CRITICAL)
        print("\033[93mPlease contact support@spacetravel.com for assistance.\033[0m")
