
.PHONY: test-all
test-all:
	@echo "Launching questasim in test directory with all tests..."
	cd proj/test; pwd
	# Find all .sh files and execute them
	for script in "./proj/test/*.sh"; do
	    if [ -f "$script" ]; then
		echo "Starting: $script"
		# Make sure the script is executable
		chmod +x "$script"
		# Run the script in background
		"$script" &
		# Store the PID
		echo "Process ID: $!"
	    fi
	done


