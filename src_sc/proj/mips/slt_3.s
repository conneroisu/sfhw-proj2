.data
.text
    .globlmain
main:
    # Start Test
    addi    $1,     $0, 0xFFFF
    addi    $2,     $0, 0x0001
    slt     $3,     $2, $1
    #register 3 should be 1

    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
