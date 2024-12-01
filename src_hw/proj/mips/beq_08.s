main:
    addi    $t0,    $0,     -2
    addi    $t1,    $0,     -2
    addi    $t2,    $0,     -3
    #Start test
    beq     $t1,    $t2,    exit    # Checks two different negative numbers
    beq     $t2,    $t1,    exit    # Check if order matters
    beq     $t0,    $t1,    exit    # Check if two negative nubmer match
    #End test
exit:
    halt    