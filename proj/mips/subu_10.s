.data
.text
    .globlmain
main:
    # Start Test
    addi    $t0,    $t0,    156
    addi    $t2,    $t2,    251
    subu    $t4,    $t2,    $t0 #load values into registers, subtract registers, common case
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
