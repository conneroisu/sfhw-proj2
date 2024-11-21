.data
.text
    .globlmain
    # This test makes sure jr can jump to the point mentioned in any register.
main:
    # Start Test
    beq     $0,     $0,     start

TEST1:
    addi    $1,     $31,    0
    jr      $1
TEST2:
    addi    $2,     $31,    0
    jr      $2
TEST3:
    addi    $3,     $31,    0
    jr      $3
TEST4:
    addi    $4,     $31,    0
    jr      $4
TEST5:
    addi    $5,     $31,    0
    jr      $5
TEST6:
    addi    $6,     $31,    0
    jr      $6
TEST7:
    addi    $7,     $31,    0
    jr      $7
TEST8:
    addi    $8,     $31,    0
    jr      $8
TEST9:
    addi    $9,     $31,    0
    jr      $9
TEST10:
    addi    $10,    $31,    0
    jr      $10
TEST11:
    addi    $11,    $31,    0
    jr      $11
TEST12:
    addi    $12,    $31,    0
    jr      $12
TEST13:
    addi    $13,    $31,    0
    jr      $13
TEST14:
    addi    $14,    $31,    0
    jr      $14
TEST15:
    addi    $15,    $31,    0
    jr      $15
TEST16:
    addi    $16,    $31,    0
    jr      $16
TEST17:
    addi    $17,    $31,    0
    jr      $17
TEST18:
    addi    $18,    $31,    0
    jr      $18
TEST19:
    addi    $19,    $31,    0
    jr      $19
TEST20:
    addi    $20,    $31,    0
    jr      $20
TEST21:
    addi    $21,    $31,    0
    jr      $21
TEST22:
    addi    $22,    $31,    0
    jr      $22
TEST23:
    addi    $23,    $31,    0
    jr      $23
TEST24:
    addi    $24,    $31,    0
    jr      $24
TEST25:
    addi    $25,    $31,    0
    jr      $25
TEST26:
    addi    $26,    $31,    0
    jr      $26
TEST27:
    addi    $27,    $31,    0
    jr      $27
TEST28:
    addi    $28,    $31,    0
    jr      $28
TEST29:
    addi    $29,    $31,    0
    jr      $29
TEST30:
    addi    $30,    $31,    0
    jr      $30
TEST31:
    jr      $31

start:
    jal     TEST1
    jal     TEST2
    jal     TEST3
    jal     TEST4
    jal     TEST5
    jal     TEST6
    jal     TEST7
    jal     TEST8
    jal     TEST9
    jal     TEST10
    jal     TEST11
    jal     TEST12
    jal     TEST13
    jal     TEST14
    jal     TEST15
    jal     TEST16
    jal     TEST17
    jal     TEST18
    jal     TEST19
    jal     TEST20
    jal     TEST21
    jal     TEST22
    jal     TEST23
    jal     TEST24
    jal     TEST25
    jal     TEST26
    jal     TEST27
    jal     TEST28
    jal     TEST29
    jal     TEST30
    jal     TEST31
    #end of the test

    # Exit program
    halt    
    li      $v0,    10
    syscall 

