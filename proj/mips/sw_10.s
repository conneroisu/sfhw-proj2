#       
    #  In this test case, we are testing to verify that store word will populate all 32 bits
    #  This test was approved directly by Professor Duwe
#       
#       
.data
.text
lui     $t1,    0x1000  # Setting register to 0x1000_0000

lui     $t0,    0xABCD  # Setting upper value of $t0 to 0xABCD
ori     $t0,    0xEFAA  # Setting lower value of $t0 to 0xEFAA
sw      $t0,    0($t1)  # store word $t0 into $t1 + 0

lui     $t0,    0x1234  # Setting upper value of $t0 to 0x1234
ori     $t0,    0x5678  # Setting lower value of $t0 to 0x5678
sw      $t0,    4($t1)  # store word $t0 into $t1 + 4

lui     $t0,    0xABCD  # Setting upper value of $t0 to 0xABCD
ori     $t0,    0xEFAA  # Setting lower value of $t0 to 0xEFAA
sw      $t0,    8($t1)  # store word $t0 into $t1 + 8

lui     $t0,    0x1234  # Setting upper value of $t0 to 0x1234
ori     $t0,    0x5678  # Setting lower value of $t0 to 0x5678
sw      $t0,    12($t1) # store word $t0 into $t1 + 12

halt    