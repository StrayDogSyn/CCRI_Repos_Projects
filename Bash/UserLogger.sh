#!/bin/bash
# User Activity Logger - Bash Version
# For www.spacetravel.com cybersecurity

log_user_activity() {
    # Get current date and time
    current_datetime=$(date "+%Y-%m-%d %H:%M:%S")
    
    # Get username from environment variables
    username=${USER:-${USERNAME:-$(whoami)}}
    
    # Try to get full name from different possible sources
    if [ -n "$LOGNAME" ]; then
        fullname=$LOGNAME
    elif [ -n "$USER" ]; then
        fullname=$USER
    else
        fullname=$username  # Fallback to username if no other option available
    fi
    
    # Get computer name
    computer_name=$(hostname)
    
    # Get IP address - choose the primary interface
    ip_address=$(hostname -I | awk '{print $1}')
    if [ -z "$ip_address" ]; then
        ip_address="Unable to determine"
    fi
    
    # Get system information
    system_info=$(uname -a)
    
    # Create log message
    log_message="
===== SPACE TRAVEL CYBERSECURITY LOG =====
Date and Time: $current_datetime
User Details:
- Username: $username
- Full Name: $fullname
- Computer Name: $computer_name
- IP Address: $ip_address
- System: $system_info
============================================
"
    
    # Display log message
    echo "$log_message"
    
    # Log to a file
    script_dir=$(dirname "$0")
    log_file="$script_dir/user_activity_log.txt"
    
    echo "$log_message" >> "$log_file"
    echo "" >> "$log_file"  # Add an empty line for separation
    
    echo "Log has been written to: $log_file"
}

# Call the function to log user activity
log_user_activity
