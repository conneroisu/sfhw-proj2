.data
.text
.globl main
main:
    # Start Test 
    lui $4, 0x0000
    addi $5, $0, 0

    srav $8,  $4, $5
    srav $9,  $4, $5
    srav $10, $4, $5
    srav $11, $4, $5
    srav $12, $4, $5
    srav $13, $4, $5
    srav $14, $4, $5
    srav $15, $4, $5
    srav $16, $4, $5
    srav $17, $4, $5
    srav $18, $4, $5
    srav $19, $4, $5
    srav $20, $4, $5
    srav $21, $4, $5
    srav $22, $4, $5
    srav $23, $4, $5
    srav $24, $4, $5
    srav $25, $4, $5
    # End Test

    # Exit program
    halt
