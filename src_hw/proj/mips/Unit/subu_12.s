.data
.text
    .globlmain
main:

    # initialize registers with test values

    ori     $t0,    $0,     0xffffffff
    ori     $t1,    $0,     0xdeadbeef

    # Test 0: Common case - subtract values

    subu    $t2,    $t0,    $t1         # 0xffffffff - 0xdeadbeef = 0x21524100

    halt    


