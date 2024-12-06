.data
.text
.globl main
# Common case
main:
    # Start Test
    addiu $t1, $zero, -20
    xori $t2, $t1, 80     # verify that a positive number xor a negative number works in ALU
    # End Test

    # Exit program
    halt
    li $v0, 10
    syscall
