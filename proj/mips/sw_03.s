.data
.text
    .globlmain
main:
    #filling in register to use for test
    addi    $t0,    $0,     4
    lui     $t1,    0x1001
    #start test
    sw      $t0,    4($t1)
    #end test

    #this is an average case to make sure the instruction will perform a proper "offset addition" to the base register value

    # Exit program
    halt    
    li      $v0,    10
    syscall 