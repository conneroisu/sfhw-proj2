addi    $t0,    $t0,    0

lui     $t0,    0xFFFF          # Load Max
lui     $t0,    0x0000          # Load Min

    #Load random values
lui     $t1,    0xCD14
lui     $t2,    0x7FFF
lui     $t3,    0x4444
lui     $t4,    0xABCD
lui     $t5,    0x381
lui     $t6,    0x1FFF
lui     $t7,    0x8463
lui     $t8,    0xFFF
lui     $t9,    0x0000
lui     $t0,    0x1
lui     $t0,    0x21

    #Set max register value
lui     $t0,    0xFFFF
addi    $t0,    $t0,    0xFFFF

    # Test overflow
lui     $t0,    0xFFFF
addi    $t0,    $t0,    65536   # Overflow the register (More of a test for addi)
lui     $t0,    0
    #TA EDIT
halt    
