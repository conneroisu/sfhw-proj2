# Bubble Sort implementation in MIPS

.data
    array_size: .word 7                          # Store array size in memory
    array:      .word 45, 23, 78, 12, 90, 34, 1  # Test array
    sorted_msg: .asciiz "\nArray has been sorted!"

.text
.globl main

main:
    # Initialize registers
    la   $s0, array        # Load array base address
    lw   $s1, array_size   # Load array size
    li   $s2, 0           # Swapped flag (0 = no swap, 1 = swap occurred)
    
outer_loop:
    # Reset swap flag at start of each pass
    li   $s2, 0           # Reset swapped flag
    li   $t0, 0           # Initialize inner loop counter (i)
    
    # Calculate number of comparisons needed (size - 1)
    addi $t1, $s1, -1     # $t1 = size - 1
    
inner_loop:
    # Check if we've reached the end of inner loop
    beq  $t0, $t1, check_if_sorted
    
    # Load adjacent elements
    sll  $t2, $t0, 2      # Convert index to byte offset (multiply by 4)
    add  $t3, $s0, $t2    # Get address of current element
    lw   $t4, 0($t3)      # Load current element
    lw   $t5, 4($t3)      # Load next element
    
    # Compare elements
    ble  $t4, $t5, no_swap  # If current <= next, skip swap
    
    # Perform swap
    sw   $t5, 0($t3)      # Store smaller value in current position
    sw   $t4, 4($t3)      # Store larger value in next position
    li   $s2, 1           # Set swapped flag
    
no_swap:
    addi $t0, $t0, 1      # Increment counter
    j    inner_loop
    
check_if_sorted:
    # If no swaps occurred, array is sorted
    beq  $s2, $0, print_result
    j    outer_loop
    
print_result:
    # Print completion message
    li   $v0, 4
    la   $a0, sorted_msg
    syscall
    
    # Exit program
    li   $v0, 10
    syscall

halt
