.data
test_val: .word 15
.text
lui   $12, 0x1234
lasw  $10, test_val
nop
lw    $11, 0($10)
nop
lui   $8, 0x0FFF
lui   $9, 0x0FF0
nop
nop
nop
nop
xor   $14, $8, $9
or    $15, $8, $9
and   $16, $8, $9
nor   $17, $8, $9
xori  $18, $8, 0x0FF0
ori   $19, $8, 0x0FF0
andi  $20, $9, 0x2F0
addi  $21, $0, 0x123
nop
nop
nop
nop
addiu $22, $21, 0x7F
nop
nop
nop
nop
addu  $23, $21, $22
nop
nop
nop
nop
sub   $24, $23, $21
nop
nop
nop
nop
subu  $25, $24, $24
sll   $8, $8, 3
nop
nop
nop
nop
srl   $8, $8, 2
nop
lui   $8, 0x8FFF
nop
nop
nop
nop
sra   $8, $8, 5
nop
nop
nop
nop
sw    $8, 4($10)
nop
nop
nop
nop
slt   $26, $8, $9
slti  $27, $8, 0x1FFF
lui   $1, 0x0020
lui   $2, 0x0020
nop
nop
nop
nop
beq   $1, $2, equal_branch
addi  $3, $3, 0x1111

equal_branch:
	bne  $1, $2, not_equal
	nop
	nop
	nop
	bgez $0, gez_branch
	nop
	nop
	addi $3, $3, 0x2222

gez_branch:
	bgtz $1, gtz_branch
	nop
	nop
	addi $3, $3, 0x3333

gtz_branch:
	nop
	nop
	nop
	nop
	blez $0, lez_branch
	nop
	nop
	nop
	nop
	addi $3, $3, 0x4444

lez_branch:
	nop
	nop
	nop
	nop
	lui  $4, 0x8FFF
	nop
	nop
	nop
	nop
	bltz $4, ltz_branch
	addi $3, $3, 0x5555

ltz_branch:
	j    jump_target
	nop
	nop
	addi $3, $3, 0x6666

jump_target:
	nop
	nop
	nop
	nop
	jal  jal_target
	nop
	nop
	addi $3, $3, 0x7777

jal_target:
	addu   $28, $0, $31
	bgezal $0, gezal_target
	bltzal $4, ltzal_target
	halt

not_equal:
gezal_target:
ltzal_target:
	jr $31
	nop
	nop
	nop
