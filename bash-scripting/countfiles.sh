#!/bin/bash

#------------------------------------------------------------------------------------------------------------------------------------------------
# Author: Opeyemi Oluwadare
# Script: countfiles.sh
# Description: Counts the number of regular files in a given directory.
# Usage: ./countfiles.sh [path-for-dir] use Ctrl + c to exit.
# If no directory is provided as an argument, the script will prompt the user for it.
#------------------------------------------------------------------------------------------------------------------------------------------------

# Function to display usage information
usage() {
    echo "Usage: $0 [path_to_directory]"
    sleep 1
    echo "Counts the number of file in a directory."
    sleep 1
    echo "If no path is provided, it will prompt for one."
    sleep 1
#    exit 1
}

# --- Main Script Logic --- #

dir_path=""

usage
# Check if a directory path was provided as a command-line argument
if [ -n "$1" ]; then
    dir_path="$1"
else
    # Loop until a non-empty directory path is provided by the user
    while [ -z "$dir_path" ]; do
        read -r -p "Please enter the absolute path to the directory: " dir_path
        if [ -z "$dir_path" ]; then
            echo "Error: No directory path specified. Please try again."
        fi
    done
fi

# Validate if the provided path is actually a directory
if [ ! -d "$dir_path" ]; then
    echo "Error: '$ddir_path' is not a valid directory or does not exist."
    exit 1
fi

file_count=$(find "$dir_path" -maxdepth 1 -type f -print0 | xargs -0 -r ls | wc -l)

# Print the result
echo "---"
echo "Number of regular files in '$dir_path': $file_count"
echo "---"

exit 0
