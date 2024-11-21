
    #Here we are testing
    # Start Test
.data
.text
    .globlmain
main:
    # Loads all registers with 1 field, then tests if the bits are cleared correctly
    # Start Test
    addi    $1,     $0, 0xFFFFFFFF
    addi    $2,     $0, 0xFFFFFFFF
    addi    $3,     $0, 0xFFFFFFFF
    addi    $4,     $0, 0xFFFFFFFF
    addi    $5,     $0, 0xFFFFFFFF
    addi    $6,     $0, 0xFFFFFFFF
    addi    $7,     $0, 0xFFFFFFFF
    addi    $8,     $0, 0xFFFFFFFF
    addi    $9,     $0, 0xFFFFFFFF
    addi    $10,    $0, 0xFFFFFFFF
    addi    $11,    $0, 0xFFFFFFFF
    addi    $12,    $0, 0xFFFFFFFF
    addi    $13,    $0, 0xFFFFFFFF
    addi    $14,    $0, 0xFFFFFFFF
    addi    $15,    $0, 0xFFFFFFFF
    addi    $16,    $0, 0xFFFFFFFF
    addi    $17,    $0, 0xFFFFFFFF
    addi    $18,    $0, 0xFFFFFFFF
    addi    $19,    $0, 0xFFFFFFFF
    addi    $20,    $0, 0xFFFFFFFF
    addi    $21,    $0, 0xFFFFFFFF
    addi    $22,    $0, 0xFFFFFFFF
    addi    $23,    $0, 0xFFFFFFFF
    addi    $24,    $0, 0xFFFFFFFF
    addi    $25,    $0, 0xFFFFFFFF
    addi    $26,    $0, 0xFFFFFFFF
    addi    $27,    $0, 0xFFFFFFFF
    addi    $28,    $0, 0xFFFFFFFF
    addi    $29,    $0, 0xFFFFFFFF
    addi    $30,    $0, 0xFFFFFFFF
    addi    $31,    $0, 0xFFFFFFFF

    addi    $1,     $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $2,     $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $3,     $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $4,     $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $5,     $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $6,     $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $7,     $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $8,     $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $9,     $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $10,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $11,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $12,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $13,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $14,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $15,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $16,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $17,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $18,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $19,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $20,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $21,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $22,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $23,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $24,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $25,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $26,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $27,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $28,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $29,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $30,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    addi    $31,    $0, 0           # verify that one can clear registers and 0+0 works in the ALU
    # End Test
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
