.data
    msg_even: .asciiz " is even\n"
    msg_odd: .asciiz " is odd\n"
    msg_fact: .asciiz "Factorial: "
    newline: .asciiz "\n"

.text
.globl main

main:
    # Set fixed input value of 10
    li $s0, 10

    # Print the number
    move $a0, $s0
    li $v0, 1
    syscall

    # Function call depth 2
    move $a0, $s0
    jal check_even_odd

    # Function call depth 3
    move $a0, $s0
    jal factorial

    # Print factorial result
    la $a0, msg_fact
    li $v0, 4
    syscall

    move $a0, $v1
    li $v0, 1
    syscall

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
    mfhi $t1  # Get remainder

    beq $t1, $zero, is_even

    # Not even, so it's odd
    jal print_odd
    j end_check_even_odd

is_even:
    jal print_even

end_check_even_odd:
    # Restore return address and return
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

print_even:
    # Save $ra before jal
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    la $a0, msg_even
    li $v0, 4
    syscall

    # Function call depth 5
    jal print_newline

    # Restore $ra
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

print_odd:
    # Save $ra before jal
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    la $a0, msg_odd
    li $v0, 4
    syscall

    # Function call depth 5 (alternate path)
    jal print_newline

    # Restore $ra
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

print_newline:
    la $a0, newline
    li $v0, 4
    syscall
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

halt
