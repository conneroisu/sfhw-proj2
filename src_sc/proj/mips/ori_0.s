.data
.text
    .globlmain
main:
    #Here we are doing a base test to see if all regieters can read the immediate 0 and the 0 register
    # Start Test
    ori     $1,     $0, 0   # verify that one can clear registers
    ori     $2,     $0, 0   # verify that one can clear registers
    ori     $3,     $0, 0   # verify that one can clear registers
    ori     $4,     $0, 0   # verify that one can clear registers
    ori     $5,     $0, 0   # verify that one can clear registers
    ori     $6,     $0, 0   # verify that one can clear registers
    ori     $7,     $0, 0   # verify that one can clear registers
    ori     $8,     $0, 0   # verify that one can clear registers
    ori     $9,     $0, 0   # verify that one can clear registers
    ori     $10,    $0, 0   # verify that one can clear registers
    ori     $11,    $0, 0   # verify that one can clear registers
    ori     $12,    $0, 0   # verify that one can clear registers
    ori     $13,    $0, 0   # verify that one can clear registers
    ori     $14,    $0, 0   # verify that one can clear registers
    ori     $15,    $0, 0   # verify that one can clear registers
    ori     $16,    $0, 0   # verify that one can clear registers
    ori     $17,    $0, 0   # verify that one can clear registers
    ori     $18,    $0, 0   # verify that one can clear registers
    ori     $19,    $0, 0   # verify that one can clear registers
    ori     $20,    $0, 0   # verify that one can clear registers
    ori     $21,    $0, 0   # verify that one can clear registers
    ori     $22,    $0, 0   # verify that one can clear registers
    ori     $23,    $0, 0   # verify that one can clear registers
    ori     $24,    $0, 0   # verify that one can clear registers
    ori     $25,    $0, 0   # verify that one can clear registers
    ori     $26,    $0, 0   # verify that one can clear registers
    ori     $27,    $0, 0   # verify that one can clear registers
    ori     $28,    $0, 0   # verify that one can clear registers
    ori     $29,    $0, 0   # verify that one can clear registers
    ori     $30,    $0, 0   # verify that one can clear registers
    ori     $31,    $0, 0   # verify that one can clear registers
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
