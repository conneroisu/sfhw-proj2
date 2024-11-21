.data
.text
    .globlmain
main:

    #start test
    #test to make sure nor work with the bigest and smallest value

    lui     $t0,    0x7FFF
    ori     $t0,    0xFFFF

    lui     $t0,    0x0000
    ori     $t0,    0x0001

    #checking greatest nor together
    nor     $t1,    $t0,    $t0

    #cheching greatest with $0
    nor     $t2,    $t0,    $0

    #checking $0 together
    nor     $t3,    $0,     $0

    #making sure it wont update zero reg
    nor     $0,     $t0,    $t0

    #test Complete

    # Exit program
    halt    
    li      $v0,    10
    syscall 