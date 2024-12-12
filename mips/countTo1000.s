.data
.text
.globl main
main:
addi $1, $1, 0
addi $2, $1, 1000

loop1:
addi $1, $1, 1
bne $1, $2, loop1 
halt