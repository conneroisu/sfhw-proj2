.data
.text
    .globlmain
main:
    # Start Test
    addi    $1,     $0, 0x19A8D7A
    addi    $2,     $0, 0xFE657285
    add     $3,     $2, $1


    #register 3 should be 0xFFFFFFFF

    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 