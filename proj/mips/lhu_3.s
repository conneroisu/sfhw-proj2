# Standard test for checking correct output. Checkings to see if you can get the
# lower half of word correctly.
.data
.text
.globl main
main:

addi $t1, $zero, 0xD0D0F00D
sw $t1, 0x10010000($zero)
lhu $8, 0x10010000($zero) # $t1 should be be 0x0000F00D

#exit
halt