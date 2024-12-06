.data
.text
    .globlmain
main:
    #filling in register to use for test
    addi    $t0,    $0,         4
    lui     $t1,    0x1001
    #start test
    sw      $t0,    -4($t1)
    #end test

    #this is an edge case to verify how the instruction will deal with a negative offset

    # Exit program
    halt    
    li      $v0,    10
    syscall 