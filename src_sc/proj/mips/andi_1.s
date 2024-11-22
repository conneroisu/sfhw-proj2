    #andi stress test anding with 0 to see that all registers clear and that the alu preforms as expected
.data
.text
    .globlmain
main:

    addi    $8,     $0,     20
    addi    $9,     $0,     500
    addi    $10,    $0,     -20
    addi    $11,    $0,     -200

    andi    $12,    $8,     0
    andi    $13,    $9,     0
    andi    $14,    $10,    0
    andi    $15,    $11,    0

    andi    $8,     $8,     0
    andi    $9,     $9,     0
    andi    $10,    $10,    0
    andi    $11,    $11,    0

    halt    