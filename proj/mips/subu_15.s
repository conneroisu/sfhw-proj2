.data
.text
    .globltest4
test4:

    #test overflow with larger numbers

    addiu   $t1,    $0,     0   #to test the lack of overflow protection, set the value of $t1 to 0 using $0
    subu    $t0,    $t1,    16  # subtract the value 16 to zero out last bit, should be 0xfffffff0
    halt    



