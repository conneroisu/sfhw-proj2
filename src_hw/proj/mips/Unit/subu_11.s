.data
.text
    .globlmain
main:
    # Start Test
    addi    $t0,    $t0,    0
    addi    $t2,    $t2,    0
    subu    $t4,    $t2,    $t0 #load values into registers, subtract registers, common case 0
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
