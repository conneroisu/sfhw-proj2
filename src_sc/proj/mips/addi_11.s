.data
.text
    .globlmain
main:
    #Test overflow - This tests the overflow in both directions of 0 (positive and negative)
    addi    $t0,    $zero,  2147483647  #This sets t0 to being 1 below the max allowed value for $t0
    addi    $t0,    $t0,    4           #This tests the overflow in the positive direction

    halt    