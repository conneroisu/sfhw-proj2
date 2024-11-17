.data
.text
    .globlmain
main:
    #tests edge case when both inputs are equal.
    #result should be false, SLT does not include equals

    slt     $s0,    $zero,  $zero   #all should be false

    addi    $t0,    $zero,  0xFFFF  #check for overflow or other weirdness in the ALU

    slt     $s0,    $t0,    $t0

    addi    $t0,    $zero,  0x7FFF

    slt     $s0,    $t0,    $t0

    #included syscalls, remove the comments if you want to use them. IDK if they're necessary
    #add $v0, $s0, $zero
    #syscall

    # End Test

    # Exit program
    halt    
