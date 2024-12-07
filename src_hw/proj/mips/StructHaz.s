# Structural Hazard Test Example with Data Initialization

.data
array:  .word 10, 20, 30, 40  # Initialize an array in memory with some values

.text
main:
    la $a0, array          # Load the address of the array into $a0
    lw $t0, 0($a0)         # Load the first word (10) from the array into $t0
    sw $t1, 4($a0)         # Store the value from $t1 into the second word of the array
    add $t4, $t2, $t3      # Add $t2 and $t3, storing the result in $t4
    sub $t7, $t6, $t5      # Subtract $t5 from $t6, storing the result in $t7

    # End of the program
    li $v0, 10             # Exit syscall
    syscall
