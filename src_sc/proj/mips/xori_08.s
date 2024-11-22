.data
.text
    .globlmain
    # Edge case, because shouldn't be inputting such large numbers
main:
    # Start Test
    addiu   $t1,    $zero,  20
    xori    $t2,    $t1,    3000    # verify that two positive numbers, one that is too large for a register, get xor-ed properly, overflow works properly
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
