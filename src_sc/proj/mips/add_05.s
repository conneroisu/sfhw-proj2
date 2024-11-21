.data
.text

    # Start Test
    # This is an normal adding with a negative case test
    # The goal here is to run adding cases for when using a negative as an operand and ensuring correct sign results, without inducing overflow
    # Not every register is written to in this test, that was done in the last test

    # $1 and $2 will hold the operands for this test
addi    $1,     $0,     5
addi    $2,     $0,     -2
add     $3,     $1,     $2      # verify that the addition negative + positive = 3 works, is signed correctly, and assigns as expected
addi    $1,     $0,     -2
addi    $2,     $0,     5
add     $4,     $1,     $2      # verify that the addition inverse of above yeilds the same result

addi    $1,     $0,     -33
addi    $2,     $0,     32
add     $5,     $1,     $2      # verify that the addition negative + positive = -1 works, is signed correctly, and assigns as expected
addi    $1,     $0,     32
addi    $2,     $0,     -33
add     $6,     $1,     $2      # verify that the addition inverse of above yeilds the same result

addi    $1,     $0,     -381
add     $7,     $0,     $1      # verify that the addition 0 + negative = -381 works, is signed correctly, and assigns as expected
addi    $2,     $0,     -381
add     $8,     $1,     $0      # verify that the addition inverse of above yeilds the same result

    # For the last one lets go right up to the value before an overflow, it should not overflow
lui     $1,     0xC000
ori     $1,     $1,     1
lui     $2,     0xBFFF
ori     $2,     $2,     0xFFFF
add     $9,     $1,     $2      # verify that the addition negative + negative = -2,147,483,648 works, is signed correctly, does not overflow, and assigns as expected
lui     $1,     0xBFFF
ori     $1,     $1,     0xFFFF
lui     $2,     0xC000
ori     $2,     $2,     1
add     $10,    $1,     $2      # verify that the addition inverse of above yeilds the same result
    # End Test

    # Exit program
halt    

