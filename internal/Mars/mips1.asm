.data
    msg_even: .asciiz " is even\n"
    msg_odd: .asciiz " is odd\n"
    msg_fact: .asciiz "Factorial: "
    newline: .asciiz "\n"

.text
.globl main

main:
    # Set fixed input value of 10
    li $s0, 10          # Initial value
    move $a0, $s0       # Pass value to $a0

    # Call check_even_odd function
    jal check_even_odd  # Result in $t1 (0 if even, 1 if odd)

    # Call factorial function
    move $a0, $s0       # Pass value to $a0
    jal factorial       # Factorial result in $v1

    # Exit program
    li $v0, 10
    syscall

# Function to check if number is even or odd
check_even_odd:
    # Save return address
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $t0, 2
    div $a0, $t0
    mfhi $t1  # Remainder in $t1

    # Check remainder; 0 if even, 1 if odd
    # 0 = even, 1 = odd

    # Restore return address and return
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

# Recursive factorial function
factorial:
    # Save return address and n
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp)

    # Base case: if n <= 1, return 1
    li $t0, 1
    ble $a0, $t0, factorial_base

    # Recursive case: n * factorial(n-1)
    addi $a0, $a0, -1
    jal factorial

    # Multiply result by n
    lw $t0, 4($sp)
    mul $v1, $v1, $t0

    # Restore and return
    lw $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra

factorial_base:
    li $v1, 1
    lw $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra

