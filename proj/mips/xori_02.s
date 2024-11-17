.data
.text
    .globlmain
    # An edge case
main:
    # Start Test
    xori    $t2,    $zero,  -20 # verify reading from 0 reg, that 0 xor a negative number works in the ALU
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
