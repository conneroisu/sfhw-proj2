.data
.text
    .globlmain
main:
    # Start Test
    sub     $1,     $0,     $11 # verify that negative numbers can be handled properly  assuming 11-20 contain (+) numbers $rd = $0 - $11
    sub     $2,     $0,     $12 # verify that negative numbers can be handled properly
    sub     $3,     $0,     $13 # verify that negative numbers can be handled properly
    sub     $4,     $0,     $14 # verify that negative numbers can be handled properly
    sub     $5,     $0,     $15 # verify that negative numbers can be handled properly
    sub     $6,     $0,     $16 # verify that negative numbers can be handled properly
    sub     $7,     $0,     $17 # verify that negative numbers can be handled properly
    sub     $8,     $0,     $18 # verify that negative numbers can be handled properly
    sub     $9,     $0,     $19 # verify that negative numbers can be handled properly
    sub     $10,    $0,     $20 # verify that negative numbers can be handled properly


    sub     $11,    $11,    $1  # verify that we can handle subtracting a negative number a - (-b)  using result from ^^^
    sub     $12,    $12,    $2  # verify that we can handle subtracting a negative number a - (-b)
    sub     $13,    $13,    $3  # verify that we can handle subtracting a negative number a - (-b)
    sub     $14,    $14,    $4  # verify that we can handle subtracting a negative number a - (-b)
    sub     $15,    $15,    $5  # verify that we can handle subtracting a negative number a - (-b)
    sub     $16,    $16,    $6  # verify that we can handle subtracting a negative number a - (-b)
    sub     $17,    $17,    $7  # verify that we can handle subtracting a negative number a - (-b)
    sub     $18,    $18,    $8  # verify that we can handle subtracting a negative number a - (-b)
    sub     $19,    $19,    $9  # verify that we can handle subtracting a negative number a - (-b)
    sub     $20,    $20,    $10 # verify that we can handle subtracting a negative number a - (-b)


    sub     $21,    $1,     $11 # verify that we can handle subtracting a negative number -a - (-b)  assuming source fields contain negatives
    sub     $22,    $2,     $12 # verify that we can handle subtracting a negative number -a - (-b)
    sub     $23,    $3,     $13 # verify that we can handle subtracting a negative number -a - (-b)
    sub     $24,    $4,     $14 # verify that we can handle subtracting a negative number -a - (-b)
    sub     $25,    $5,     $15 # verify that we can handle subtracting a negative number -a - (-b)
    sub     $26,    $6,     $16 # verify that we can handle subtracting a negative number -a - (-b)
    sub     $27,    $7,     $17 # verify that we can handle subtracting a negative number -a - (-b)
    sub     $28,    $8,     $18 # verify that we can handle subtracting a negative number -a - (-b)
    sub     $29,    $9,     $19 # verify that we can handle subtracting a negative number -a - (-b)
    sub     $30,    $10,    $20 # verify that we can handle subtracting a negative number -a - (-b)
    sub     $31,    $11,    $21 # verify that we can handle subtracting a negative number -a - (-b)
    # End Test

    # Exit program
    halt    
