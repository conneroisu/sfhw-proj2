.data
.text
    .globlmain
main:
    # Goal: This test ensures that the basic, common xor operation works with 0 xor 1 = 1 for all bits in the inputs

    # Start Test
    addi    $t0,    $0,     0       # initialize to 0
    lui     $t1,    0xFFFF          # initialize to 0xFFFFFFFF
    addi    $t1,    $t1,    0xFFFF
    xor     $t2,    $t0,    $t1     # verify that 0 xor 0xFFFFFFFF = 0xFFFFFFFF
    # End Test

    # Exit program
    halt    
