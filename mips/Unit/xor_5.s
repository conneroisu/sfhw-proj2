.data
.text
    .globlmain
main:
    # Goal: These tests ensure that the common, basic case of 0 xor 0 = 0

    # Start Test
    addi    $t0,    $0,     0   # initialize to 0
    addi    $t1,    $0,     0   # initialize to 0
    xor     $t2,    $t0,    $t1 # verify that 0 xor 0 = 0
    # End Test

    # Exit program
    halt    
