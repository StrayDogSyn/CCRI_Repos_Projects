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
    
    # Get user's name
    print("\033[92m\nWelcome to the Space Journey Calculator!\033[0m")
    traveler_name = input("Please enter your name: ")
    
    # Greet the user by name
    print(f"\033[93m\nHello, {traveler_name}! Let's plan your space journey.\033[0m")
    
    # Velocity input with validation
    valid_velocity = False
    while not valid_velocity:
        try:
            velocity = float(input("\nPlease enter your travel velocity (in km/h): "))
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
    
    # Convert to days, hours, minutes for better readability
    duration_days = math.floor(duration_hours / 24)
    remaining_hours = math.floor(duration_hours % 24)
    remaining_minutes = math.floor((duration_hours * 60) % 60)
    
    # Add a bit of animation for the calculation
    print("\n\033[93mCalculating journey duration", end="")
    for _ in range(5):
        print(".", end="", flush=True)
        time.sleep(0.3)
    print("\033[0m\n")
    
    # Generate the result message
    result_message = f"""
\033[92m===== SPACE TRAVEL JOURNEY CALCULATION =====
Traveler: {traveler_name}
Destination: {destination}
Distance: {distance:,} kilometers
Velocity: {velocity:,.2f} km/h

Estimated Journey Duration:
- Total Hours: {duration_hours:,.2f} hours
- In Days/Hours/Minutes: {duration_days} days, {remaining_hours} hours, {remaining_minutes} minutes
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
