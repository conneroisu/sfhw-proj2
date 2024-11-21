.data
    
arr: .word 0 : 10
    
.text
    
la $s0, arr
addTests:
    addi $t0, $zero, 100
    addiu $t1, $zero, -1	
    add $t2, $t0, $zero	
    addu $t3, $t0, $t1
andTests:
    and $t1, $t3, $t0 	
    andi $t0, $t0, 66
swTest:
    sw $t0, 0($s0)
loadTests1:
    lui $t0, 0x1010
    lw $t1, 0($s0)
orTests:
    nor $t2, $t0, $t1
    xor $t3, $t0, $t1
    xori $t4, $t0, 0x11001100
    or $t5, $t0, $t1
    ori $t6, $t0, 0x4444
shiftTests:
    slt $t1, $t4, $t5
    slti $t2, $t2, 55
    addi $t0, $zero, 0x00000001
    sll $t0, $t0, 4
    srl $t0, $t0, 4
    addi $t0, $zero, -3456
    sra $t0, $t0, 4
subTests:
    addi $t0, $zero, 10
    addi $t1, $zero, 8
    sub $t2, $t0, $t1
    sub $t3, $t1, $t0
    subu $t4, $t1, $t0
loadTests2:
    lb $t0, 0($s0)
    lh $t1, 4($s0)
    lbu $t2, 8($s0)
    lhu $t3, 12($s0)
shiftVariableTests:
    addi $t0, $zero, 0x00000001
    addi $t7, $zero, 4
    sllv $t1, $t0, $t7
    srlv $t2, $t0, $t7
    addi $t0, $zero, -3456
    srav $t3, $t0, $t7

halt
