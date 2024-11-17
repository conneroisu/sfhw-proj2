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

# Function to detect the available terminal emulator
detect_terminal() {
    if command -v gnome-terminal &> /dev/null; then
        echo "gnome-terminal"
    elif command -v konsole &> /dev/null; then
        echo "konsole"
    elif command -v xterm &> /dev/null; then
        echo "xterm"
    elif command -v terminator &> /dev/null; then
        echo "terminator"
    else
        echo "none"
    fi
}

# Get the available terminal
TERMINAL=$(detect_terminal)

# Function to launch script in new terminal
launch_in_terminal() {
    local script="$1"
    local title=$(basename "$script")
    
    case $TERMINAL in
        "gnome-terminal")
            gnome-terminal --title="$title" -- bash -c "echo 'Running: $script'; $script; echo 'Press Enter to close'; read"
            ;;
        "konsole")
            konsole --new-tab --title "$title" -e bash -c "$script; echo 'Press Enter to close'; read"
            ;;
        "xterm")
            xterm -T "$title" -e bash -c "$script; echo 'Press Enter to close'; read" &
            ;;
        "terminator")
            terminator --new-tab -x bash -c "$script; echo 'Press Enter to close'; read"
            ;;
        *)
            echo "No supported terminal emulator found"
            exit 1
            ;;
    esac
}

# Counter for terminal positions (for staggered positioning)
count=0

# Find and execute all .sh files
for script in "$directory"/*.sh; do
    if [ -f "$script" ]; then
        echo "Starting: $script"
        # Make sure the script is executable
        chmod +x "$script"
        
        # Calculate position offset for terminals
        x_pos=$((50 + count * 50))
        y_pos=$((50 + count * 50))
        
        # Launch script in new terminal
        launch_in_terminal "$script"
        
        count=$((count + 1))
        # Small delay to prevent terminals from overlapping
        sleep 0.5
    fi
done

echo "All scripts have been launched in separate terminals"
