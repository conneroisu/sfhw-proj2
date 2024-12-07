.data
array: .word 10, 20, 30, 40

.text
main:
    addi $0, $zero, 0       # Initialize base address index to 0
    addi $1, $zero, 100     # Initialize data value to 100

    lw $2, 0($0)           # Load value from array[0]
    addi $3, $2, 5         # Perform an operation with the loaded value
<<<<<<< HEAD
=======
nop
nop
>>>>>>> ef04ee4 (fix)
    sw $1, 4($0)           # Store 100 to array[1]
    addi $4, $1, 10        # Another addi instruction around sw

    halt                     # End program
