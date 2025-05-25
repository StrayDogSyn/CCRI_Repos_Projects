# Space Journey Logger - Python Module
# For www.spacetravel.com innovative solutions
# Created: May 25, 2025

import os
import datetime
import enum
from typing import Optional

class LogLevel(enum.Enum):
    DEBUG = 0
    INFO = 1
    WARNING = 2
    ERROR = 3
    CRITICAL = 4

class SpaceLogger:
    def __init__(self, log_to_file: bool = False, log_file: str = "SpaceTravel_Log.txt"):
        self.log_to_file = log_to_file
        self.log_file = log_file
        
        # Colors for terminal output (ANSI color codes)
        self.colors = {
            LogLevel.DEBUG: "\033[90m",     # Gray
            LogLevel.INFO: "\033[0m",       # White/Default
            LogLevel.WARNING: "\033[93m",   # Yellow
            LogLevel.ERROR: "\033[91m",     # Red
            LogLevel.CRITICAL: "\033[95m",  # Magenta
            "RESET": "\033[0m"              # Reset color
        }
    
    def log(self, message: str, level: LogLevel = LogLevel.INFO) -> None:
        """Log a message with the specified level"""
        # Create timestamp
        timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        
        # Format the log message
        level_str = level.name.ljust(8)
        formatted_message = f"[{timestamp}] [{level_str}] {message}"
        
        # Print to console with color
        color = self.colors.get(level, self.colors[LogLevel.INFO])
        print(f"{color}{formatted_message}{self.colors['RESET']}")
        
        # Write to file if requested
        if self.log_to_file:
            script_dir = os.path.dirname(os.path.abspath(__file__))
            log_file_path = os.path.join(script_dir, self.log_file)
            
            with open(log_file_path, "a") as f:
                f.write(f"{formatted_message}\n")
    
    def debug(self, message: str) -> None:
        """Log a debug message"""
        self.log(message, LogLevel.DEBUG)
    
    def info(self, message: str) -> None:
        """Log an info message"""
        self.log(message, LogLevel.INFO)
    
    def warning(self, message: str) -> None:
        """Log a warning message"""
        self.log(message, LogLevel.WARNING)
    
    def error(self, message: str) -> None:
        """Log an error message"""
        self.log(message, LogLevel.ERROR)
    
    def critical(self, message: str) -> None:
        """Log a critical message"""
        self.log(message, LogLevel.CRITICAL)

# Create a default logger instance
default_logger = SpaceLogger()

# Functions to use the default logger
def debug(message: str) -> None:
    default_logger.debug(message)

def info(message: str) -> None:
    default_logger.info(message)

def warning(message: str) -> None:
    default_logger.warning(message)

def error(message: str) -> None:
    default_logger.error(message)

def critical(message: str) -> None:
    default_logger.critical(message)

# Enable file logging
def enable_file_logging(log_file: Optional[str] = None) -> None:
    default_logger.log_to_file = True
    if log_file:
        default_logger.log_file = log_file
