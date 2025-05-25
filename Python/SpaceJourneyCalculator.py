#!/usr/bin/env python
# Space Journey Calculator - Python Version
# For www.spacetravel.com innovative solutions
# Created: May 25, 2025

import os
import math
import time

def clear_screen():
    # Clear screen for better user experience - works on both Windows and Unix-like systems
    os.system('cls' if os.name == 'nt' else 'clear')

def calculate_space_journey():
    # Clear the screen for better user experience
    clear_screen()
    
    # ASCII art header for a more engaging experience
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
      # Define the distances (in kilometers)
    distance_to_moon = 384400
    distance_to_mars = 225000000
      # Get user's name with example
    print("\033[92m\nWelcome to the Space Journey Calculator!\033[0m")
    traveler_name = input("Please enter your name (e.g., Jane Smith): ")
    
    # Get country with examples
    country = input("Please enter your country (e.g., United States, Canada, Mexico): ")
    
    # Greet the user by name
    print(f"\033[93m\nHello, {traveler_name} from {country}! Let's plan your space journey.\033[0m")
    
    # Get today's date for the journey
    from datetime import datetime, timedelta
    today = datetime.now()
    print(f"\nToday's date is {today.strftime('%Y-%m-%d')}.")
    
    # Year selection with range validation
    current_year = today.year
    valid_year = False
    while not valid_year:
        try:
            year_input = input(f"\nEnter the year of travel ({current_year}-{current_year+30}): ")
            year = int(year_input)
            
            if year < current_year or year > (current_year + 30):
                print(f"\033[91mYear must be between {current_year} and {current_year+30}.\033[0m")
            else:
                valid_year = True
        except ValueError:
            print("\033[91mInvalid input. Please enter a valid year.\033[0m")
    
    # Calculate travel date
    travel_date = datetime(year, today.month, today.day)
    print(f"\nYour journey is planned for: {travel_date.strftime('%Y-%m-%d')}")
    days_till_travel = (travel_date - today).days
    
    if days_till_travel > 0:
        print(f"That's {days_till_travel} days from today.")
    
    # Velocity input with validation and examples
    valid_velocity = False
    while not valid_velocity:
        try:
            velocity = float(input("\nPlease enter your travel velocity (in km/h, e.g., 50000 for spacecraft, 1000 for airplane): "))
            if velocity <= 0:
                print("\033[91mVelocity must be greater than zero.\033[0m")
                continue
            valid_velocity = True
        except ValueError:
            print("\033[91mInvalid input. Please enter a numeric value.\033[0m")
    
    # Destination selection
    valid_choice = False
    while not valid_choice:
        print("\n\033[93mSelect your destination:\033[0m")
        print("\033[96m1. Moon (384,400 km from Earth)\033[0m")
        print("\033[96m2. Mars (225,000,000 km from Earth)\033[0m")
        destination_choice = input("Enter 1 for Moon or 2 for Mars: ")
        
        if destination_choice in ["1", "2"]:
            valid_choice = True
        else:
            print("\033[91mInvalid choice. Please enter 1 or 2.\033[0m")
    
    # Calculate journey duration
    if destination_choice == "1":
        destination = "Moon"
        distance = distance_to_moon
    else:
        destination = "Mars"
        distance = distance_to_mars
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
    from datetime import timedelta
    arrival_date = travel_date + timedelta(hours=duration_hours)
    
    # Calculate journey cost (fictional rate of $1000 per million km)
    journey_cost = (distance / 1000000) * 1000
    
    # Add a bit of animation for the calculation
    print("\n\033[93mCalculating journey duration", end="")
    for _ in range(5):
        print(".", end="", flush=True)
        time.sleep(0.3)
    print("\033[0m\n")
    
    # Generate the result message with proper formatting
    result_message = f"""
\033[92m===== SPACE TRAVEL JOURNEY CALCULATION =====
Traveler: {traveler_name}
Country: {country}
Travel Date: {travel_date.strftime('%Y-%m-%d')}
Destination: {destination}
Distance: {distance:,.0f} km
Velocity: {velocity:,.2f} km/h

Estimated Journey Details:
- Duration: {duration_hours:.5f} hours
           {duration_days:.5f} days
           {duration_months:.5f} months
           {duration_years:.5f} years

- Plain English: Your journey to the {destination} will take approximately
  {whole_days} days, {whole_hours} hours, and {whole_minutes} minutes
  at your selected speed of {velocity:,.2f} km/h.

- Estimated Arrival: {arrival_date.strftime('%Y-%m-%d %H:%M')}

- Estimated Cost: ${journey_cost:,.2f}
============================================\033[0m
"""
    
    # Display result with formatting
    print(result_message)
    
    # Option to calculate another journey
    another_journey = input("Would you like to calculate another journey? (y/n): ")
    if another_journey.lower() == "y":
        calculate_space_journey()
    else:
        print("\n\033[93mThank you for using the Space Journey Calculator!\033[0m")
        print("\033[96mwww.spacetravel.com - Your Gateway to the Stars\033[0m")

# Start the calculation
if __name__ == "__main__":
    calculate_space_journey()
