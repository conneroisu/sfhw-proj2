.data
.text
    .globlmain
main:
    #Negative overflow - This tests the overflow in the negative direction
    addi    $t0,    $zero,  -0x80000000 #This sets t0 to the max negative value allowed
    addi    $t0,    $t0,    -4          #This tests the negative overflow


    halt    