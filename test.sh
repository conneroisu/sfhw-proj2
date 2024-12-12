#!/bin/bash

# Check if a WLF file path is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_wlf_file>"
    exit 1
fi

WLF_FILE=$1

# Validate the WLF file
if [ ! -f "$WLF_FILE" ]; then
    echo "Error: File $WLF_FILE does not exist."
    exit 1
fi

# Set environment variables
export PATH=$PATH:/usr/local/mentor/questasim/bin
export SALT_LICENSE_SERVER=$SALT_LICENSE_SERVER:1717@io.ece.iastate.edu

# Run Questasim with the provided WLF file and then execute pipeline.do
/usr/local/mentor/questasim/bin/vsim -view "$WLF_FILE" -do "do pipeline.do; quit;"
