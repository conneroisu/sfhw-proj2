.data
memory: .word 0x12345678, 0x9abcdef0, 0x11223344, 0x55667788
.text
main:
lw $1, 0($2)
sw $1, 4($3)
add $4, $1, $5
halt
