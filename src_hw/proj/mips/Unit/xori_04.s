.data
.text
    .globlmain
    # Common case
main:
    # Start Test
    addi    $t1,    $zero,  -13
    xori    $t2,    $t1,    -19 # verify reading from another reg besides 0, that xor of two neg numbers works in ALU
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
