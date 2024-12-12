#
# Topological sort using an adjacency matrix. Maximum 4 nodes.
# 
# The expected output of this program is that the 1st 4 addresses of the data segment
# are [4,0,3,2]. should take ~2000 cycles in a single cycle procesor.
#

.data
res:
	.word -1-1-1-1
nodes:
        .byte   97 # a
        .byte   98 # b
        .byte   99 # c
        .byte   100 # d
adjacencymatrix:
        .word   6
        .word   0
        .word   0
        .word   3
visited:
	.byte 0 0 0 0
res_idx:
        .word   3
.text
	li $sp, 0x10011000
	nop
	nop
	nop
	li $fp, 0
	nop
	nop
	nop
	la $ra pump
	nop
	nop
	nop
	j main # jump to the starting location
	nop
	nop
	nop
pump:
	halt
main:
	nop
	nop
	nop
        addiu   $sp,$sp,-40 # MAIN
	nop
	nop
	nop
        sw      $31,36($sp)
	nop
	nop
	nop
        sw      $fp,32($sp)
	nop
	nop
	nop
        add    	$fp,$sp,$zero
	nop
	nop
	nop
        sw      $0,24($fp)
	nop
	nop
	nop
        j       main_loop_control
	nop
	nop
	nop

	nop
	nop
	nop
main_loop_body:
	nop
	nop
	nop
        lw      $4,24($fp)
        la 	$ra, trucks
	nop
	nop
	nop
        j     is_visited
	nop
	nop
	nop
        trucks:
	nop
	nop
	nop
        xori    $2,$2,0x1
	nop
	nop
	nop
        andi    $2,$2,0x00ff
	nop
	nop
	nop
        beq     $2,$0,kick
	nop
	nop
	nop

	nop
	nop
	nop
        lw      $4,24($fp)
	nop
	nop
	nop
        # addi 	$k0, $k0,1# breakpoint
	nop
	nop
	nop
        la 	$ra, billowy
	nop
	nop
	nop
        j     	topsort
	nop
	nop
	nop
        billowy:
	nop
	nop
	nop
kick:
	nop
	nop
	nop
        lw      $2,24($fp)
	nop
	nop
	nop
        addiu   $2,$2,1
	nop
	nop
	nop
        sw      $2,24($fp)
	nop
	nop
	nop
main_loop_control:
	nop
	nop
	nop
        lw      $2,24($fp)
	nop
	nop
	nop
        slti     $2,$2, 4
	nop
	nop
	nop
        beq	$2, $zero, hew # beq, j to simulate bne 
	nop
	nop
	nop
        j       main_loop_body
	nop
	nop
	nop
        hew:
	nop
	nop
	nop
        sw      $0,28($fp)
	nop
	nop
	nop
        j       welcome
	nop
	nop
	nop
wave:
	nop
	nop
	nop
        lw      $2,28($fp)
	nop
	nop
	nop
        addiu   $2,$2,1
	nop
	nop
	nop
        sw      $2,28($fp)
	nop
	nop
	nop
welcome:
	nop
	nop
	nop
        lw      $2,28($fp)
	nop
	nop
	nop
        slti    $2,$2,4
	nop
	nop
	nop
        xori	$2,$2,1 # xori 1, beq to simulate bne where val in [0,1]
	nop
	nop
	nop
        beq     $2,$0,wave
	nop
	nop
	nop
        move    $2,$0
	nop
	nop
	nop
        move    $sp,$fp
	nop
	nop
	nop
        lw      $31,36($sp)
	nop
	nop
	nop
        lw      $fp,32($sp)
	nop
	nop
	nop
        addiu   $sp,$sp,40
	nop
	nop
	nop
        jr       $ra
	nop
	nop
	nop
interest:
	nop
	nop
	nop
        lw      $4,24($fp)
	nop
	nop
	nop
        la	$ra, new
	nop
	nop
	nop
        j	is_visited
	nop
	nop
	nop
	new:
	nop
	nop
	nop
        xori    $2,$2,0x1
	nop
	nop
	nop
        andi    $2,$2,0x00ff
	nop
	nop
	nop
        beq     $2,$0,tasteful
	nop
	nop
	nop
        lw      $4,24($fp)
	nop
	nop
	nop
        la	$ra, partner
	nop
	nop
	nop
        j     	topsort
	nop
	nop
	nop
        partner:
	nop
	nop
	nop
tasteful:
	nop
	nop
	nop
        addiu   $2,$fp,28
	nop
	nop
	nop
        move    $4,$2
	nop
	nop
	nop
        la	$ra, badge
	nop
	nop
	nop
        j     next_edge
	nop
	nop
	nop
        badge:
	nop
	nop
	nop
        sw      $2,24($fp)
	nop
	nop
	nop
turkey:
	nop
	nop
	nop
        lw      $3,24($fp)
	nop
	nop
	nop
        li      $2,-1
	nop
	nop
	nop
        beq	$3,$2,telling # beq, j to simulate bne
	nop
	nop
	nop
        j	interest
	nop
	nop
	nop
        telling:
	nop
	nop
	nop
	la 	$v0, res_idx
	nop
	nop
	nop
	lw	$v0, 0($v0)
	nop
	nop
	nop
        addiu   $4,$2,-1
	nop
	nop
	nop
        la 	$3, res_idx
	nop
	nop
	nop
        sw 	$4, 0($3)
	nop
	nop
	nop
        la	$4, res
	nop
	nop
	nop
        sll     $3,$2,2
	nop
	nop
	nop
        srl	$3,$3,1
	nop
	nop
	nop
        sra	$3,$3,1
	nop
	nop
	nop
        sll     $3,$3,2
	nop
	nop
	nop
       	xor	$at, $ra, $2 # does nothing 
	nop
	nop
	nop
        nor	$at, $ra, $2 # does nothing 
	nop
	nop
	nop
        
	nop
	nop
	nop
        la	$2, res
	nop
	nop
	nop
        andi	$at, $2, 0xffff # -1 will sign extend (according to assembler), but 0xffff won't
	nop
	nop
	nop
        addu 	$2, $4, $at
	nop
	nop
	nop
        addu    $2,$3,$2
	nop
	nop
	nop
        lw      $3,48($fp)
	nop
	nop
	nop
        sw      $3,0($2)
	nop
	nop
	nop
        move    $sp,$fp
	nop
	nop
	nop
        lw      $31,44($sp)
	nop
	nop
	nop
        lw      $fp,40($sp)
	nop
	nop
	nop
        addiu   $sp,$sp,48
	nop
	nop
	nop
        jr      $ra
	nop
	nop
	nop
   
	nop
	nop
	nop
topsort:
	nop
	nop
	nop
        addiu   $sp,$sp,-48
	nop
	nop
	nop
        sw      $31,44($sp)
	nop
	nop
	nop
        sw      $fp,40($sp)
	nop
	nop
	nop
        move    $fp,$sp
	nop
	nop
	nop
        sw      $4,48($fp)
	nop
	nop
	nop
        lw      $4,48($fp)
	nop
	nop
	nop
        la	$ra, verse
	nop
	nop
	nop
        j	mark_visited
	nop
	nop
	nop
        verse:
	nop
	nop
	nop

	nop
	nop
	nop
        addiu   $2,$fp,28
	nop
	nop
	nop
        lw      $5,48($fp)
	nop
	nop
	nop
        move    $4,$2
	nop
	nop
	nop
        la 	$ra, joyous
	nop
	nop
	nop
        j	iterate_edges
	nop
	nop
	nop
        joyous:
	nop
	nop
	nop

	nop
	nop
	nop
        addiu   $2,$fp,28
	nop
	nop
	nop
        move    $4,$2
	nop
	nop
	nop
        la	$ra, whispering
	nop
	nop
	nop
        j     	next_edge
	nop
	nop
	nop
        whispering:
	nop
	nop
	nop

	nop
	nop
	nop
        sw      $2,24($fp)
	nop
	nop
	nop
        j       turkey
	nop
	nop
	nop

	nop
	nop
	nop
iterate_edges:
	nop
	nop
	nop
        addiu   $sp,$sp,-24
	nop
	nop
	nop
        sw      $fp,20($sp)
	nop
	nop
	nop
        move    $fp,$sp
	nop
	nop
	nop
        subu	$at, $fp, $sp
	nop
	nop
	nop
        sw      $4,24($fp)
	nop
	nop
	nop
        sw      $5,28($fp)
	nop
	nop
	nop
        lw      $2,28($fp)
	nop
	nop
	nop
        sw      $2,8($fp)
	nop
	nop
	nop
        sw      $0,12($fp)
	nop
	nop
	nop
        lw      $2,24($fp)
	nop
	nop
	nop
        lw      $4,8($fp)
	nop
	nop
	nop
        lw      $3,12($fp)
	nop
	nop
	nop
        sw      $4,0($2)
	nop
	nop
	nop
        sw      $3,4($2)
	nop
	nop
	nop
        lw      $2,24($fp)
	nop
	nop
	nop
        move    $sp,$fp
	nop
	nop
	nop
        lw      $fp,20($sp)
	nop
	nop
	nop
        addiu   $sp,$sp,24
	nop
	nop
	nop
        jr      $ra
	nop
	nop
	nop
        
	nop
	nop
	nop
next_edge:
	nop
	nop
	nop
        addiu   $sp,$sp,-32
	nop
	nop
	nop
        sw      $31,28($sp)
	nop
	nop
	nop
        sw      $fp,24($sp)
	nop
	nop
	nop
        add	$fp,$zero,$sp
	nop
	nop
	nop
        sw      $4,32($fp)
	nop
	nop
	nop
        j       waggish
	nop
	nop
	nop

	nop
	nop
	nop
snail:
	nop
	nop
	nop
        lw      $2,32($fp)
	nop
	nop
	nop
        lw      $3,0($2)
	nop
	nop
	nop
        lw      $2,32($fp)
	nop
	nop
	nop
        lw      $2,4($2)
	nop
	nop
	nop
        move    $5,$2
	nop
	nop
	nop
        move    $4,$3
	nop
	nop
	nop
        la	$ra,induce
	nop
	nop
	nop
        j       has_edge
	nop
	nop
	nop
        induce:
	nop
	nop
	nop
        beq     $2,$0,quarter
	nop
	nop
	nop
        lw      $2,32($fp)
	nop
	nop
	nop
        lw      $2,4($2)
	nop
	nop
	nop
        addiu   $4,$2,1
	nop
	nop
	nop
        lw      $3,32($fp)
	nop
	nop
	nop
        sw      $4,4($3)
	nop
	nop
	nop
        j       cynical
	nop
	nop
	nop

	nop
	nop
	nop

	nop
	nop
	nop
quarter:
	nop
	nop
	nop
        lw      $2,32($fp)
	nop
	nop
	nop
        lw      $2,4($2)
	nop
	nop
	nop
        addiu   $3,$2,1
	nop
	nop
	nop
        lw      $2,32($fp)
	nop
	nop
	nop
        sw      $3,4($2)
	nop
	nop
	nop

	nop
	nop
	nop
waggish:
	nop
	nop
	nop
        lw      $2,32($fp)
	nop
	nop
	nop
        lw      $2,4($2)
	nop
	nop
	nop
        slti    $2,$2,4
	nop
	nop
	nop
        beq	$2,$zero,mark # beq, j to simulate bne 
	nop
	nop
	nop
        j	snail
	nop
	nop
	nop
        mark:
	nop
	nop
	nop
        li      $2,-1
	nop
	nop
	nop

	nop
	nop
	nop
cynical:
	nop
	nop
	nop
        move    $sp,$fp
	nop
	nop
	nop
        lw      $31,28($sp)
	nop
	nop
	nop
        lw      $fp,24($sp)
	nop
	nop
	nop
        addiu   $sp,$sp,32
	nop
	nop
	nop
        jr      $ra
	nop
	nop
	nop
has_edge:
	nop
	nop
	nop
        addiu   $sp,$sp,-32
	nop
	nop
	nop
        sw      $fp,28($sp)
	nop
	nop
	nop
        move    $fp,$sp
	nop
	nop
	nop
        sw      $4,32($fp)
	nop
	nop
	nop
        sw      $5,36($fp)
	nop
	nop
	nop
        la      $2,adjacencymatrix
	nop
	nop
	nop
        lw      $3,32($fp)
	nop
	nop
	nop
        sll     $3,$3,2
	nop
	nop
	nop
        addu    $2,$3,$2
	nop
	nop
	nop
        lw      $2,0($2)
	nop
	nop
	nop
        sw      $2,16($fp)
	nop
	nop
	nop
        li      $2,1
	nop
	nop
	nop
        sw      $2,8($fp)
	nop
	nop
	nop
        sw      $0,12($fp)
	nop
	nop
	nop
        j       measley
	nop
	nop
	nop

	nop
	nop
	nop
look:
	nop
	nop
	nop
        lw      $2,8($fp)
	nop
	nop
	nop
        sll     $2,$2,1
	nop
	nop
	nop
        sw      $2,8($fp)
	nop
	nop
	nop
        lw      $2,12($fp)
	nop
	nop
	nop
        addiu   $2,$2,1
	nop
	nop
	nop
        sw      $2,12($fp)
	nop
	nop
	nop
measley:
	nop
	nop
	nop
        lw      $3,12($fp)
	nop
	nop
	nop
        lw      $2,36($fp)
	nop
	nop
	nop
        slt     $2,$3,$2
	nop
	nop
	nop
        beq     $2,$0,experience # beq, j to simulate bne 
	nop
	nop
	nop
        j 	look
	nop
	nop
	nop
       	experience:
	nop
	nop
	nop
        lw      $3,8($fp)
	nop
	nop
	nop
        lw      $2,16($fp)
	nop
	nop
	nop
        and     $2,$3,$2
	nop
	nop
	nop
        slt     $2,$0,$2
	nop
	nop
	nop
        andi    $2,$2,0x00ff
	nop
	nop
	nop
        move    $sp,$fp
	nop
	nop
	nop
        lw      $fp,28($sp)
	nop
	nop
	nop
        addiu   $sp,$sp,32
	nop
	nop
	nop
        jr      $ra
	nop
	nop
	nop
        
	nop
	nop
	nop
mark_visited:
	nop
	nop
	nop
        addiu   $sp,$sp,-32
	nop
	nop
	nop
        sw      $fp,28($sp)
	nop
	nop
	nop
        move    $fp,$sp
	nop
	nop
	nop
        sw      $4,32($fp)
	nop
	nop
	nop
        li      $2,1
	nop
	nop
	nop
        sw      $2,8($fp)
	nop
	nop
	nop
        sw      $0,12($fp)
	nop
	nop
	nop
        j       recast
	nop
	nop
	nop

	nop
	nop
	nop
example:
	nop
	nop
	nop
        lw      $2,8($fp)
	nop
	nop
	nop
        sll     $2,$2,8
	nop
	nop
	nop
        sw      $2,8($fp)
	nop
	nop
	nop
        lw      $2,12($fp)
	nop
	nop
	nop
        addiu   $2,$2,1
	nop
	nop
	nop
        sw      $2,12($fp)
	nop
	nop
	nop
recast:
	nop
	nop
	nop
        lw      $3,12($fp)
	nop
	nop
	nop
        lw      $2,32($fp)
	nop
	nop
	nop
        slt     $2,$3,$2
	nop
	nop
	nop
        beq	$2,$zero,pat # beq, j to simulate bne
	nop
	nop
	nop
        j	example
	nop
	nop
	nop
        pat:
	nop
	nop
	nop

	nop
	nop
	nop
       	la	$2, visited
	nop
	nop
	nop
        sw      $2,16($fp)
	nop
	nop
	nop
        lw      $2,16($fp)
	nop
	nop
	nop
        lw      $3,0($2)
	nop
	nop
	nop
        lw      $2,8($fp)
	nop
	nop
	nop
        or      $3,$3,$2
	nop
	nop
	nop
        lw      $2,16($fp)
	nop
	nop
	nop
        sw      $3,0($2)
	nop
	nop
	nop
        move    $sp,$fp
	nop
	nop
	nop
        lw      $fp,28($sp)
	nop
	nop
	nop
        addiu   $sp,$sp,32
	nop
	nop
	nop
        jr      $ra
	nop
	nop
	nop
        
	nop
	nop
	nop
is_visited:
	nop
	nop
	nop
        addiu   $sp,$sp,-32
	nop
	nop
	nop
        sw      $fp,28($sp)
	nop
	nop
	nop
        move    $fp,$sp
	nop
	nop
	nop
        sw      $4,32($fp)
	nop
	nop
	nop
        ori     $2,$zero,1
	nop
	nop
	nop
        sw      $2,8($fp)
	nop
	nop
	nop
        sw      $0,12($fp)
	nop
	nop
	nop
        j       evasive
	nop
	nop
	nop

	nop
	nop
	nop
justify:
	nop
	nop
	nop
        lw      $2,8($fp)
	nop
	nop
	nop
        sll     $2,$2,8
	nop
	nop
	nop
        sw      $2,8($fp)
	nop
	nop
	nop
        lw      $2,12($fp)
	nop
	nop
	nop
        addiu   $2,$2,1
	nop
	nop
	nop
        sw      $2,12($fp)
	nop
	nop
	nop
evasive:
	nop
	nop
	nop
        lw      $3,12($fp)
	nop
	nop
	nop
        lw      $2,32($fp)
	nop
	nop
	nop
        slt     $2,$3,$2
	nop
	nop
	nop
        beq	$2,$0,representitive # beq, j to simulate bne
	nop
	nop
	nop
        j     	justify
	nop
	nop
	nop
        representitive:
	nop
	nop
	nop

	nop
	nop
	nop
        la	$2,visited
	nop
	nop
	nop
        lw      $2,0($2)
	nop
	nop
	nop
        sw      $2,16($fp)
	nop
	nop
	nop
        lw      $3,16($fp)
	nop
	nop
	nop
        lw      $2,8($fp)
	nop
	nop
	nop
        and     $2,$3,$2
	nop
	nop
	nop
        slt     $2,$0,$2
	nop
	nop
	nop
        andi    $2,$2,0x00ff
	nop
	nop
	nop
        move    $sp,$fp
	nop
	nop
	nop
        lw      $fp,28($sp)
	nop
	nop
	nop
        addiu   $sp,$sp,32
	nop
	nop
	nop
        jr      $ra
	nop
	nop
	nop
