.data

.text

    .globlmain

main:
    # start test
    jal     test2                   # jumping forward
    halt    

test1:

    halt                            # end test
    addi    $t0,    $t0,    1111    #i n case of fail $t0 is 1111

test2:
    jal     test1                   # jumping backwards


