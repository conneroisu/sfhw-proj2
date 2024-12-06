# This test is for using a base address that isn't zero. In this case it 
# is a negative base value.
.data
.text
.globl main
main:

addi $t1, $zero, 0xD0D0F00D
sw $t1, 0x10010000($zero)
addi $t1, $zero, 0xFFFFFFFE
# should have 0x0000F00D in $t1
lhu $8, 0x10010002($t1)

#exit program
halt