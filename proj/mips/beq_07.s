
main:
    addi    $t0,    $0,     0
    addi    $t1,    $0,     0
    addi    $t2,    $0,     2
    #Start test
    beq     $t1,    $t2,    exit    # Checks two different positive numbers
    beq     $t0,    $t1,    exit    # Chec if two postive numbers match
    #End test
exit:
    halt    