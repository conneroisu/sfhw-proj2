.data
.text
    .globlmain
    # Common case
main:
    # Start Test
    addiu   $t1,    $zero,  44
    xori    $t2,    $t1,    20  # verify reading from another reg besides 0, that xor of two positve numbers works in ALU
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
