#!/bin/bash

#------------------------------------------------------------------------------------------------------------------------------------------------
# Author: Opeyemi Oluwadare
# Script: checkfile.sh
# Description: Checks if files/directory exists in a working directory.
# Usage: ./countfiles.sh [filename], use Ctrl + c to exit.
# If no directory is provided as an argument, the script will prompt the user for it.
#------------------------------------------------------------------------------------------------------------------------------------------------

# Function to display usage information
usage() {
    echo "Usage: $0 [filename]"
    sleep 1
    echo "Checks if a specified file exists."
    sleep 1
    echo "If no filename is provided, it will prompt for one."
    sleep 11
#    exit 1
}

# --- Main Script Logic --- #

file=""

# Check if a filename was provided as a command-line argument
usage
if [ -n "$1" ]; then
    file="$1"
else
    # Loop until a non-empty filename is provided
    while [ -z "$file" ]; do
        read -r -p "Please enter filename: " file
        if [ -z "$file" ]; then
            echo "Error: No file specified. Please try again."
        fi
    done
fi

# Check file type and existence
if [ -f "$file" ]; then
    echo "Info: Regular file '$file' exists."
elif [ -d "$file" ]; then
    echo "Info: Directory '$file' exists."
elif [ -e "$file" ]; then
    echo "Info: '$file' exists but is not a regular file or directory (e.g., a symlink, device file)."
else
    echo "Error: File '$file' does not exist."
    exit 1
fi

exit 0
