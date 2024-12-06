.data
.align 2
vals: .word 25 1 4 10 381 42 100 60 0 12 # address: 0x10010000
vals_length: .word 10                    # address: 0x10010028
.text
.globl main
# vars
# $s0 => *vals
# $s1 => vals_length
# $s2 => i
# $s3 => j
# $s4 => swapped
# $s5 => &arr[j]
# $s6 => &arr[j+1]
main:
    lui $s1, 0x1001
	nop
	nop
	nop
    lui $s0, 0x1001
	nop
	nop
	nop
    addi $s2, $zero, 0
	nop
	nop
	nop
    ori $s1, $s1, 0x0028
	nop
	nop
	nop
    lw $s1, 0($s1)
outer_loop_cond:
	nop
	nop
	nop
    addi $t0, $s1, -1
	nop
	nop
	nop
    slt $t1, $s2, $t0
	nop
	nop
	nop
    bne $t1, $zero, outer_loop_body
	nop
	nop
	nop
    j exit_outer_loop
	nop
	nop
	nop
outer_loop_body:
	nop
	nop
	nop
    add $s4, $zero, $zero
	nop
	nop
	nop
    add $s3, $zero, $zero
	nop
	nop
	nop
inner_loop_cond:
	nop
	nop
	nop
    sub  $t0, $s1, $s2
	nop
	nop
	nop
    addi $t0, $t0, -1
	nop
	nop
	nop
    slt $t0, $s3, $t0
	nop
	nop
	nop
    bne $t0, $zero, inner_loop_body
	nop
	nop
	nop
    j exit_inner_loop
	nop
	nop
	nop
inner_loop_body:
	nop
	nop
	nop
    sll $t0, $s3, 2
	nop
	nop
	nop
    add $s5, $s0, $t0
	nop
	nop
	nop
    addi $s6, $s5, 4
	nop
	nop
	nop
    lw $t0, 0($s5)
	nop
	nop
	nop
    lw $t1, 0($s6)
	nop
	nop
	nop
    slt $t2, $t1, $t0
	nop
	nop
	nop
    beq $t2, $zero, inner_loop_footer
	nop
	nop
	nop
    sw $t0, 0($s6)
	nop
	nop
	nop
    sw $t1, 0($s5)
	nop
	nop
	nop
    addi $s4, $zero, 1
	nop
	nop
	nop
inner_loop_footer:
	nop
	nop
	nop
    addi $s3, $s3, 1
	nop
	nop
	nop
    j inner_loop_cond
	nop
	nop
	nop
exit_inner_loop:
	nop
	nop
	nop
    beq $s4, $zero, exit_outer_loop
outer_loop_footer:
	nop
	nop
	nop
    addi $s2, $s2, 1
	nop
	nop
	nop
    j outer_loop_cond
	nop
	nop
	nop
exit_outer_loop:
    j exit
exit:
    halt
