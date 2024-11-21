.data
.text
    .globlmain
main:
    # Start Test
    # Test for edge cases and overflow
    # We add 32767 and -32768 to test maximum and minimum values that can be represented in a 16-bit signed integer
    #Then we add 1 to test for overflow
    # Expected result is that the result register (t0) should hold the value -32768 after overflow

    addiu   $t0,    $zero,  32767
    # t0 = 32767
    addiu   $t1,    $zero,  -32768
    # t1 = -32768
    addiu   $t2,    $zero,  1
    # t2 = 1
    #addiu $t0, $t0, $t1
    # t0 = 32767 - 32768 = -1
    #addiu $t0, $t0, $t2
    # t0 = -1 + 1 = 0

    #End Test
    #Exit program
    halt    
