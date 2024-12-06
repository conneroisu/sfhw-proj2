.data
.text
    .globlmain
main:
    #tests set less than with a negative number too, as well as using two registers instead of just using $zero
    #can add the u for unisgned if you want I guess, but that's not specified in the doc so I wont include it

    addi    $t0,    $zero,  -10
    addi    $t1,    $zero,  -5

    slt     $s0,    $t0,    $t1 #expected true

    #included syscalls, remove the comments if you want to use them. IDK if they're necessary
    #add $v0, $s0, $zero
    #syscall

    #check opposite too
    slt     $s0,    $t1,    $t0 #expected false

    #add $v0, $s0, $zero
    #syscall

    # End Test

    # Exit program
    halt    
