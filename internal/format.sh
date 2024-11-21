#!bin/bash

format_vhdl_files() {
    # Gather all VHDL files into an array
    mapfile -t vhdl_files < <(find . -type f -name "*.vhd")

    # Check if any VHDL files are found
    if [ ${#vhdl_files[@]} -eq 0 ]; then
        echo "No VHDL files found in the current directory or subdirectories."
        return 1
    fi

    # Process each VHDL file
    for file in "${vhdl_files[@]}"; do
        emacs --batch --eval "(progn \
            (require (quote vhdl-mode)) \
            (vhdl-set-style \"IEEE\") \
            (let ((content (with-temp-buffer \
                (insert-file-contents \"$file\") \
                (buffer-string)))) \
            (with-temp-buffer \
                (insert content) \
                (vhdl-mode) \
                (vhdl-beautify-region (point-min) (point-max)) \
                (write-region (point-min) (point-max) \"$file\"))))"
    done
}

format_vhdl_files
