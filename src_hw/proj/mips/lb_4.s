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

# LB

lb $t4, 0($t0)
lb $t5, 1($t0)
lb $t6, 2($t0)
lb $t7, 3($t0)

lb $t4, 0($t1)
lb $t5, 1($t1)
lb $t6, 2($t1)
lb $t7, 3($t1)

lb $t4, 0($t2)
lb $t5, 1($t2)
lb $t6, 2($t2)
lb $t7, 3($t2)

lb $t4, 0($t3)
lb $t5, 1($t3)
lb $t6, 2($t3)
lb $t7, 3($t3)

halt
