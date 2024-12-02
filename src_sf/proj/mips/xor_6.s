.data
.text
    .globlmain
main:
    # Goal: These tests ensure that the common, basic case of 1 xor 1 = 0

    # Start Test
    lui     $t0,    0xFFFF
    addi    $t0,    $t0,    0xFFFF  # initialize to 0xFFFFFFFF
    lui     $t1,    0xFFFF
    addi    $t1,    $t1,    0xFFFF  # initialize to 0xFFFFFFFF
    xor     $t2,    $t0,    $t1     # verify that 0xFFFFFFFF xor 0xFFFFFFFF = 0
    # End Test

    # Exit program
    halt    
