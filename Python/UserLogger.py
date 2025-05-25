#!/usr/bin/env python
# User Activity Logger - Python Version
# For www.spacetravel.com cybersecurity

import os
import platform
import socket
import datetime
import getpass

def log_user_activity():
    """
    Function to log user activity for cybersecurity purposes.
    Captures username, full name, current date/time, and system information.
    """
    # Get current date and time
    current_datetime = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    # Get username and attempt to get full name from environment variables
    username = os.environ.get('USERNAME') or getpass.getuser()
    
    # Try different environment variables for full name
    fullname = os.environ.get('USER')
    if not fullname:
        # If USER isn't available, try to extract from USERPROFILE
        if os.environ.get('USERPROFILE'):
            fullname = os.path.basename(os.environ.get('USERPROFILE'))
        else:
            fullname = username  # Fallback
    
    # Get system information
    computer_name = platform.node()
    system_platform = platform.system() + " " + platform.release()
    
    # Get IP address
    try:
        # This trick gets the IP address used for external connections
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))  # Doesn't actually send data, just gets interface
        ip_address = s.getsockname()[0]
        s.close()
    except:
        ip_address = "Unable to determine"
    
    # Create log message
    log_message = f"""
===== SPACE TRAVEL CYBERSECURITY LOG =====
Date and Time: {current_datetime}
User Details:
- Username: {username}
- Full Name: {fullname}
- Computer Name: {computer_name}
- System: {system_platform}
- IP Address: {ip_address}
============================================
"""
    
    # Display log message
    print(log_message)
    
    # Log to a file
    script_dir = os.path.dirname(os.path.abspath(__file__))
    log_file = os.path.join(script_dir, "user_activity_log.txt")
    
    with open(log_file, 'a') as f:
        f.write(log_message + "\n")
    
    print(f"Log has been written to: {log_file}")

# Call the function to log user activity
if __name__ == "__main__":
    log_user_activity()
