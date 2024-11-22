.data
.text
    .globlmain
main:
    # Start Test
    addi    $t0,    $t0,    156
    addi    $t2,    $t2,    251
    subu    $t4,    $t0,    $t2 #load values into registers, subtract registers, will be negative number so should not throw exception, other common case
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
