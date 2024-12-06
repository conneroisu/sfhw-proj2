.data
.text
    .globlmain
main:
    #Goal: See if or can set all bits.

    #Start Test
    addi    $t0,    $zero,  0xFFFFFFFF  #reg t0 has all bits set.
    or      $t2,    $zero,  $t0         #Expect $t2 to be 0xFFFFFFFF

    # Exit program
    halt    
    li      $v0,    10
    syscall 
