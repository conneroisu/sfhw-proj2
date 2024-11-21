.data
.text
    .globlmain
    # Probably an edge case
main:
    # Start Test
    addiu   $t1,    $zero,  -5
    xori    $t2,    $t1,    -5  # verify reading from another reg besides zero, that xor of the same negative number works in the ALU
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
