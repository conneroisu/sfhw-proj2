.data
.text
    .globlmain
main:
    #filling in register to use for test
    addi    $t0,    $0,         4
    lui     $t1,    0x1001
    #start test
    sw      $t0,    0x1e0($t1)
    #end test

    #this is an edge case to verify how the instruction will deal with a huge offset values.

    # Exit program
    halt    
    li      $v0,    10
    syscall 