    # ------------------- srl -- Shift Right Logical Unit Tests -------------------
    # I used the following test cases to stress test the possible edge
    # cases like shifting half the bits overand all 1's shifting to all 0's
    # for example. Along with that, the test cases checks the
    # functionality of regular shifts with 0 (nothing should happen)
    # as well as shifting a single bit down to a desired spot.

.data
.text
    .globlmain

main:

    #Test 0 -- 0000000011111111 << 16 == All zeros
    addiu   $t1,    $0,     255
    srl     $t1,    $t1,    16

    #Test 1 -- 1111111111111111 << 16 == 0000000011111111
    addiu   $t1,    $0,     65535
    srl     $t1,    $t1,    16

    #Test 2 -- 1111111111111110 << 31 == 0000000000000001
    addiu   $t1,    $0,     65534
    srl     $t1,    $t1,    31

    #Test 3 -- 111111111111111 << 0 == 111111111111111
    addiu   $t1,    $0,     65535
    srl     $t1,    $t1,    0

    #Test 4 -- 000001111110011 << 4 == 0000000000001111
    addiu   $t1,    $0,     1011
    srl     $t1,    $t1,    4

    #Test 5 -- 000000100000000 << 6 == 0000000000000100
    addiu   $t1,    $0,     256
    srl     $t1,    $t1,    6
    # End Tests

    # Exit program
    halt    
