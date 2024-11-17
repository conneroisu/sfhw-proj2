.text

    # addu stress test 1
main:
    # Initialize registers for unsigned addition.
    addi    $1,     $zero,  1
    addi    $2,     $zero,  2

    # test unsigned addition of 2 registers
    addu    $1,     $1,     $1  # $1 = 2, verify unsigned addition works for all registers with different numbers
    addu    $2,     $1,     $2  # $2 = 4, verify unsigned addition works for all registers with different numbers
    addu    $3,     $1,     $2  # $3 = 6, verify unsigned addition works for all registers with different numbers
    addu    $4,     $1,     $3  # $4 = 8, verify unsigned addition works for all registers with different numbers
    addu    $5,     $1,     $4  # $5 = 10, verify unsigned addition works for all registers with different numbers
    addu    $6,     $1,     $5  # $6 = 12, verify unsigned addition works for all registers with different numbers
    addu    $7,     $1,     $6  # $7 = 14, verify unsigned addition works for all registers with different numbers
    addu    $8,     $1,     $7  # $8 = 16, verify unsigned addition works for all registers with different numbers
    addu    $9,     $1,     $8  # $9 = 18, verify unsigned addition works for all registers with different numbers
    addu    $10,    $1,     $9  # $10 = 20, verify unsigned addition works for all registers with different numbers
    addu    $11,    $1,     $10 # $11 = 22, verify unsigned addition works for all registers with different numbers
    addu    $12,    $1,     $11 # $12 = 24, verify unsigned addition works for all registers with different numbers
    addu    $13,    $1,     $12 # $13 = 26, verify unsigned addition works for all registers with different numbers
    addu    $14,    $1,     $13 # $14 = 28, verify unsigned addition works for all registers with different numbers
    addu    $15,    $1,     $14 # $15 = 30, verify unsigned addition works for all registers with different numbers
    addu    $16,    $1,     $15 # $16 = 32, verify unsigned addition works for all registers with different numbers
    addu    $17,    $1,     $16 # $17 = 34, verify unsigned addition works for all registers with different numbers
    addu    $18,    $1,     $17 # $18 = 36, verify unsigned addition works for all registers with different numbers
    addu    $19,    $1,     $18 # $19 = 38, verify unsigned addition works for all registers with different numbers
    addu    $20,    $1,     $19 # $20 = 40, verify unsigned addition works for all registers with different numbers
    addu    $21,    $1,     $20 # $21 = 42, verify unsigned addition works for all registers with different numbers
    addu    $22,    $1,     $21 # $22 = 44, verify unsigned addition works for all registers with different numbers
    addu    $23,    $1,     $22 # $23 = 46, verify unsigned addition works for all registers with different numbers
    addu    $24,    $1,     $23 # $24 = 48, verify unsigned addition works for all registers with different numbers
    addu    $25,    $1,     $24 # $25 = 50, verify unsigned addition works for all registers with different numbers
    addu    $26,    $1,     $25 # $26 = 52, verify unsigned addition works for all registers with different numbers
    addu    $27,    $1,     $26 # $27 = 54, verify unsigned addition works for all registers with different numbers
    addu    $28,    $1,     $27 # $28 = 56, verify unsigned addition works for all registers with different numbers
    addu    $29,    $1,     $28 # $29 = 58, verify unsigned addition works for all registers with different numbers
    addu    $30,    $1,     $29 # $30 = 60, verify unsigned addition works for all registers with different numbers
    addu    $31,    $1,     $30 # $31 = 62, verify unsigned addition works for all registers with different numbers

    # Exit program
    halt    
    li      $v0,    10
    syscall 
