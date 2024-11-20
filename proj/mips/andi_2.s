    #andi stress test anding with all 1s to ensure that values are copied and that extend work as intended
.data
.text
    .globlmain
main:

    addi    $8,     $0,     -85
    addi    $9,     $0,     5000
    addi    $10,    $0,     20000
    addi    $11,    $0,     -1

    andi    $12,    $8,     -1
    andi    $13,    $9,     -1
    andi    $14,    $10,    -1
    andi    $15,    $11,    -1

    halt    

