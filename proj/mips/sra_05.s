.data
.text
    .globlmain
main:
    # Start Test
    addi    $t1,    $t1,    4294000000
    sra     $t3,    $t1,    5           #Testing of another edge case of shifting to make sure the msb stay one when shift
    #goes from 0xfff13d80 and it should be 0xFFFF89ec
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
