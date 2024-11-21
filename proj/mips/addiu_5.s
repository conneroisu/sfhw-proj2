.data
.text
    .globlmain
main:

    # Test for adding 0
    # Adding 0 to a number should give the same number
    # Expected result is that the result register (t0) should hold the value 5

    addiu   $t0,    $0,     5   # t0 = 5
    addiu   $t1,    $0,     0   # t1 = 0
    addu    $t0,    $t0,    $t1 # t0 = 5 + 0 = 5

    #End Test
    #Exit program
    halt    
