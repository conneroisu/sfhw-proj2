# This test is for using a base address that isn't zero. In this case it 
# is a positive base value.
.data
.text
.globl main
main:
addi $t1, $zero, 0xD0D0F00D
sw $t1, 0x10010000($zero)
addi $t1, $zero, 0x2
# should have 0x0000D0D0 in $t1
lhu $8, 0x10010000($t1)

#exit
halt