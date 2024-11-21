main:
    addi    $t0,    $0,     -1
    addi    $t1,    $0,     1
    #Start test
    beq     $t1,    $t0,    exit    # Checks a number matchs its negative self
    halt                            #Ends test if it doesn't jump
    #End test
exit:
    halt    