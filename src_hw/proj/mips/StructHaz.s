.data
array: .word 10, 20, 30, 40

.text
main:
    addi $t0, $zero, 0       # Initialize base address index to 0
    addi $t1, $zero, 100     # Initialize data value to 100

    lw $t2, 0($t0)           # Load value from array[0]
    addi $t3, $t2, 5         # Perform an operation with the loaded value
    sw $t1, 4($t0)           # Store 100 to array[1]
    addi $t4, $t1, 10        # Another addi instruction around sw

    halt                     # End program
