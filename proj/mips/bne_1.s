    # This test determines if the bne instruction will not branch since both register will be equal to each other.
    # This has value since it determines if the instruction is not just always branching.
    # The end value of $8 should be 1, since it should have it's value changed from 0 to 1.

.data
.text
    .globlmain
main:
    # Start Test
    addi    $8,     $0, 0
    bne     $8,     $0, exit
    addi    $8,     $0, 1

exit:
    # Exit program
    halt    
    li      $v0,    10
    syscall 