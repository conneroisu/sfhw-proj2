.data
.text
    .globlmain
main:
    #Test positive addition - This test will test the positive addition of a number to a register
    addi    $t0,    $zero,  1   #Verify that simple addition works with the $zero register
    addi    $t1,    $zero,  3   #Verify that simple addition works with the $zero register
    addi    $zero,  $zero,  52  #Verify that the $zero register can't be overwritten

    halt    