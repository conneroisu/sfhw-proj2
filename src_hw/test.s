.data
    array: .word 64, 34, 25, 12, 22, 11, 90, 50   # Initial array to sort
    size: .word 8                                  # Size of array
    newline: .asciiz "\n"
    space: .asciiz " "

.text
.globl main

main:
    # Load array address without la
    lui $s0, 0x1001       # Upper half of data segment address
    ori $s0, $s0, 0x0000  # Lower half - array is at start of data segment
    lui $t0, 0x1001       # Load size without la
    ori $t0, $t0, 0x0020  # offset to size
    lw $s1, ($t0)         # Load array size
    move $a0, $s0         # First argument: array address
    li $a1, 0             # Second argument: left index
    addi $a2, $s1, -1     # Third argument: right index
    jal mergesort         # Call mergesort
    
    # Print sorted array
    li $t0, 0             # Initialize counter
print_loop:
    beq $t0, $s1, exit    # If counter == size, exit
    sll $t1, $t0, 2       # Multiply counter by 4
    add $t1, $s0, $t1     # Add to base address
    lw $a0, ($t1)         # Load number to print
    li $v0, 1             # Print integer syscall
    syscall
    
    # Print space without la
    lui $a0, 0x1001
    ori $a0, $a0, 0x0024  # offset to space string
    li $v0, 4
    syscall
    
    addi $t0, $t0, 1      # Increment counter
    j print_loop

exit:
    # Print newline without la
    lui $a0, 0x1001
    ori $a0, $a0, 0x0026  # offset to newline string
    li $v0, 4
    syscall
    
    li $v0, 10            # Exit program
    syscall

mergesort:
    # Save return address and registers
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $s0, 8($sp)
    sw $s1, 4($sp)
    sw $s2, 0($sp)
    
    # Check if array has more than one element
    sub $t0, $a2, $a1     # right - left
    blez $t0, mergesort_return   # If <= 0, return
    
    # Calculate middle point
    add $s0, $a1, $a2     # left + right
    srl $s0, $s0, 1       # (left + right) / 2
    
    # Save arguments
    move $s1, $a1         # Save left
    move $s2, $a2         # Save right
    
    # Sort left half
    move $a2, $s0         # right = mid
    jal mergesort
    
    # Sort right half
    move $a1, $s0         # left = mid
    addi $a1, $a1, 1      # left = mid + 1
    move $a2, $s2         # right = original right
    jal mergesort
    
    # Merge the sorted halves
    move $a1, $s1         # Restore original left
    move $a2, $s0         # mid
    move $a3, $s2         # Restore original right
    jal merge

mergesort_return:
    # Restore registers and return
    lw $ra, 12($sp)
    lw $s0, 8($sp)
    lw $s1, 4($sp)
    lw $s2, 0($sp)
    addi $sp, $sp, 16
    jr $ra

merge:
    # Save registers
    addi $sp, $sp, -20
    sw $ra, 16($sp)
    sw $s0, 12($sp)
    sw $s1, 8($sp)
    sw $s2, 4($sp)
    sw $s3, 0($sp)
    
    move $s0, $a1         # i = left
    addi $s1, $a2, 1      # j = mid + 1
    move $s2, $a0         # Save array base address
    
merge_loop:
    bgt $s0, $a2, merge_done    # If i > mid, done
    bgt $s1, $a3, merge_done    # If j > right, done
    
    # Load elements to compare
    sll $t0, $s0, 2       # i * 4
    add $t0, $s2, $t0     # array + i*4
    lw $t2, ($t0)         # array[i]
    
    sll $t1, $s1, 2       # j * 4
    add $t1, $s2, $t1     # array + j*4
    lw $t3, ($t1)         # array[j]
    
    # Compare and swap if necessary
    ble $t2, $t3, no_swap
    
    # Swap elements
    sw $t3, ($t0)
    sw $t2, ($t1)
    
no_swap:
    addi $s0, $s0, 1      # i++
    j merge_loop

merge_done:
    # Restore registers and return
    lw $ra, 16($sp)
    lw $s0, 12($sp)
    lw $s1, 8($sp)
    lw $s2, 4($sp)
    lw $s3, 0($sp)
    addi $sp, $sp, 20
    jr $ra
