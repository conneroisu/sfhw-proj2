    # This test determines if the bne instruction will branch multiple times in a row.
    # This has value since it determines if the instruction is properly holding on to values after each branch,
    # and is not resulting in any weird behavior after multiple branches are performed in a row.
    # The end value of $8 should be 1, since it should never have it's value changed.

.data
.text
    .globlmain
main:
    # Start Test
    addi    $8,     $0, 1

    # Branch 1
    bne     $8,     $0, branch2
    addi    $8,     $8, 1

    # Branch 2
branch2:
    bne     $8,     $0, branch3
    addi    $8,     $8, 1

branch3:
    bne     $8,     $0, exit
    addi    $8,     $8, 1

exit:
    # Exit program
    halt    
    li      $v0,    10
    syscall 