    .data
prompt: .asciiz "Enter a number: "
result_msg: .asciiz "The result is: "
newline: .asciiz "\n"

    .text
    .globl main

main:
    # Print the prompt
    li $v0, 4              # syscall code for print string
    la $a0, prompt         # load address of prompt
    syscall                # make syscall to print prompt

    # Read integer input
    li $v0, 5              # syscall code for read integer
    syscall                # make syscall to read integer
    move $t0, $v0          # move input to $t0

    # Basic Arithmetic Instructions
    li $t1, 2              # load immediate 2 into $t1
    add $t2, $t0, $t1      # add $t0 and $t1, store result in $t2
    sub $t3, $t2, $t1      # subtract $t1 from $t2, store result in $t3
    mul $t4, $t3, $t1      # multiply $t3 by $t1, store result in $t4
    div $t4, $t1           # divide $t4 by $t1
    mflo $t5               # move result of division to $t5 (quotient)
    mfhi $t6               # move remainder to $t6

    # Logical Instructions
    and $t7, $t0, $t1      # bitwise AND between $t0 and $t1
    or $t8, $t0, $t1       # bitwise OR between $t0 and $t1
    xor $t9, $t0, $t1      # bitwise XOR between $t0 and $t1
    nor $s0, $t0, $t1      # bitwise NOR between $t0 and $t1

    # Shift Instructions
    sll $s1, $t0, 2        # shift left logical $t0 by 2, store in $s1
    srl $s2, $t0, 2        # shift right logical $t0 by 2, store in $s2
    sra $s3, $t0, 2        # shift right arithmetic $t0 by 2, store in $s3

    # Comparison Instructions
    slt $s4, $t0, $t1      # set $s4 to 1 if $t0 < $t1, else set to 0
    slti $s5, $t0, 5       # set $s5 to 1 if $t0 < 5, else set to 0
    seq $s6, $t0, $t1      # set $s6 to 1 if $t0 == $t1, else set to 0
    sne $s7, $t0, $t1      # set $s7 to 1 if $t0 != $t1, else set to 0

    # Memory Instructions
    sw $t0, 0($sp)         # store word in memory at $sp + 0
    lw $t0, 0($sp)         # load word from memory at $sp + 0
    lb $t1, 0($sp)         # load byte from memory at $sp + 0
    sb $t1, 1($sp)         # store byte to memory at $sp + 1

    # Jump Instructions
    j end                  # jump to end label

loop:
    # Branch Instructions
    beq $t0, $zero, end    # branch to end if $t0 == 0
    bne $t0, $zero, loop   # branch to loop if $t0 != 0

end:
    # Print result
    li $v0, 4              # syscall code for print string
    la $a0, result_msg     # load address of result message
    syscall                # make syscall to print result message

    li $v0, 1              # syscall code for print integer
    move $a0, $t2          # move result into $a0
    syscall                # make syscall to print result

    # Print newline
    li $v0, 4              # syscall code for print string
    la $a0, newline        # load address of newline
    syscall                # make syscall to print newline

    # Exit program
    li $v0, 10             # syscall code for exit
    syscall                # make syscall to exit
