.data
.text
    .globlmain
main:

    # Start test
    #testing to make sure that nor work under basic operations
    #including this tets because we have to know if the operation is functioning in the way it is most commonly used
    #test start
    addi    $t0,    $0,     0xFF00
    addi    $t1,    $0,     0x00FF
    #test positive number with offset 1s and 0s
    nor     $t2,    $t0,    $t1

    lui     $t0,    0xFFFF
    #testing number and its match
    nor     $t3,    $t0,    $t2
    #test number and its inverse with positive and negative number
    nor     $t4,    $t0,    $t3


    #test lower bit FFFF with numbersmall
    addi    $t1,    $0,     1
    nor     $t4,    $t1,    $t3
    addi    $t1,    $0,     2
    nor     $t4,    $t1,    $t3
    addi    $t1,    $0,     3
    nor     $t4,    $t1,    $t3
    addi    $t1,    $0,     130
    nor     $t4,    $t1,    $t3
    #number should resulting always in upperbit FFFF

    #test complete

    # Exit program
    halt    
    li      $v0,    10
    syscall 