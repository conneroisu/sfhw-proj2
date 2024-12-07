.data
memory: .word 0x12345678, 0x9abcdef0, 0x11223344, 0x55667788
.text
main:
    lw $t1, memory($t2)
    sw $t1, 4($t3)
    add $t4, $t1, $t5
    halt
