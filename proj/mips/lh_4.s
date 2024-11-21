.data

test1: .word 0x87654321
test2: .word 0xDEADBEEF
test3: .word 0x00000000
test4: .word 0xFFFFFFFF

.text

la $t0, test1
la $t1, test2
la $t2, test3
la $t3, test4

lh $t4, 0($t0)
lh $t6, 2($t0)

lh $t4, 0($t1)
lh $t6, 2($t1)

lh $t4, 0($t2)
lh $t6, 2($t2)

lh $t4, 0($t3)
lh $t6, 2($t3)

halt
