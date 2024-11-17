    # testing normal range and overflow of 16 bit immediate
.data
.text
    .globlmain
main:

    addi    $8,     $0,     -85
    addi    $9,     $0,     5000
    addi    $10,    $0,     20000
    addi    $11,    $0,     -1

    andi    $11,    $8,     32767
    andi    $12,    $9,     -85
    andi    $13,    $10,    -32767
    andi    $14,    $11,    32768
    andi    $14,    $10,    -32768

    halt    