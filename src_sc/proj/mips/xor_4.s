.data
.text
    .globlmain
main:
    xor     $1,     $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $2,     $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $3,     $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $4,     $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $5,     $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $6,     $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $7,     $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $8,     $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $9,     $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $10,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $11,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $12,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $13,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $14,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $15,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $16,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $17,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $18,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $19,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $20,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $21,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $22,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $23,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $24,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $25,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $26,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $27,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $28,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $29,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $30,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU
    xor     $31,    $0,     0           # verify that one can clear registers and 0^0 works in the ALU

    addi    $t1,    $0,     15          #Set first input to 0x0000000F
    addi    $t2,    $0,     31          #Set second input to 0x0000001F
    xor     $s0,    $t1,    $t2         #test xor functionality Output= 0x00000010
    addi    $t1,    $0,     4294967295  #Set first input to all 1's 0xFFFFFFFF
    xor     $s1,    $t1,    $0          #Verify input xor'ed with 0's equals input Output= 0xFFFFFFFF
    addi    $t1,    $0,     2863311530  #Set second input to 0xAAAAAAAA
    xor     $s2,    $t1,    $s1         #use xor as a not Output= 0x55555555
    xor     $s3,    $t1,    $s2         #Verify xor Output= 0xFFFFFFFF
    xor     $s4,    $s3,    $s1         #Verify xor Output= 0x00000000
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
