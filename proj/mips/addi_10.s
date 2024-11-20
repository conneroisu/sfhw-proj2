.data
.text
    .globlmain
main:
    #Test subtraction - This will test subtraction through the addi instruction
    addi    $t0,    $zero,  10  #Tests regular addition
    addi    $t1,    $zero,  -8  #Tests subtraction from the $zero register
    addi    $zero,  $zero,  -6  #Tests that the $zero register won't be overwritten

    halt    