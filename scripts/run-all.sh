#!/bin/bash

# Check if directory is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

directory="$1"

# Check if directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist"
    exit 1
fi

# Find all .sh files and execute them
for script in "$directory"/*.sh; do
    if [ -f "$script" ]; then
        echo "Starting: $script"
        sh "$script" &
        # Store the PID
        echo "Process ID: $!"
    fi
done

echo "All scripts have been started"

# Wait for all background processes to complete
wait
echo "All scripts have completed"
