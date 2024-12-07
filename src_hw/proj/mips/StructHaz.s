.data
memory: .word 0x12345678, 0x9abcdef0, 0x11223344, 0x55667788
.text
main:
lw $t1, memory
sw $t1, 4($sp)
add $t3, $t1, $t4
halt
