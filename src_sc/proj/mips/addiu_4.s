.data
.text
    .globlmain
main:
    # Test for adding a negative number
    # Adding a negative number should subtract the absolute value of that number from the other operand
    # Expected result is that the result register (t0) should hold the value -7

    addiu   $t0,    $0,     -2  # t0 = -2
    addiu   $t1,    $0,     -5  # t1 = -5
    addu    $t0,    $t0,    $t1 # t0 = -2 - (-5) = -2 + 5 = 3
    addiu   $t2,    $0,     -10 # t2 = -10
    addu    $t0,    $t0,    $t2 # t0 = 3 - (-10) = 3 + 10 = 13
    addiu   $t1,    $0,     -20 # t1 = -20
    addu    $t0,    $t0,    $t1 # t0 = 13 - (-20) = 13 + 20 = 33
    addiu   $t2,    $0,     -40 # t2 = -40
    addu    $t0,    $t0,    $t2 # t0 = 33 - (-40) = 33 + 40 = 73
    addiu   $t1,    $0,     -80 # t1 = -80
    addu    $t0,    $t0,    $t1 # t0 = 73 - (-80) = 73 + 80 = -7


    #End Test
    #Exit program
    halt    
