.data
.text
    .globlmain
    # Probably an edge case
main:
    # Start Test
    addiu   $t1,    $zero,  20
    xori    $t2,    $t1,    20  # verify reading from another reg besides 0, that the xor of the same positive number works in the ALU
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
