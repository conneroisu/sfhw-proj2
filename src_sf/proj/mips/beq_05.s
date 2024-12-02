.data
.text
    .globlmain
main:
    #testing beq behavior when one of the operands is the largest possible signed integer value in the processor's word size.
    #This can be done by setting the contents of one or both registers to the value of 2147483647.
    #The other operand can be set to any other value.
    #This edge case can be useful to ensure that the BEQ instruction behaves correctly when comparing a large integer value with a small one(including negatives)
    # Start Test
    addi    $t0,    $zero,  2147483647  # $t0 = The largest signed integer
    addi    $t1,    $zero,  -10         # $t1 = -10
    beq     $t0,    $t1,    equal       # compare $t0 and $t1, branch to "equal" if equal
    addi    $t2,    $zero,  1
exit:
    # Exit program
    halt                                # if $t0 and $t1 are not equal, set $t2 = 1
equal:
    addi    $t2,    $zero,  0           # if $t0 and $t1 are equal, set $t2 = 0

exit1:
    # Exit program
    halt    
