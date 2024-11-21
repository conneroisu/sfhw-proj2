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
	li $fp, 0
	la $ra pump
	j main # jump to the starting location
pump:
	halt


main:
        addiu   $sp,$sp,-40 # MAIN
        sw      $31,36($sp)
        sw      $fp,32($sp)
        add    	$fp,$sp,$zero
        sw      $0,24($fp)
        j       main_loop_control

main_loop_body:
        lw      $4,24($fp)
        la 	$ra, trucks
        j     is_visited
        trucks:

        xori    $2,$2,0x1
        andi    $2,$2,0x00ff
        beq     $2,$0,kick

        lw      $4,24($fp)
        # addi 	$k0, $k0,1# breakpoint
        la 	$ra, billowy
        j     	topsort
        billowy:

kick:
        lw      $2,24($fp)
        addiu   $2,$2,1
        sw      $2,24($fp)
main_loop_control:
        lw      $2,24($fp)
        slti     $2,$2, 4
        beq	$2, $zero, hew # beq, j to simulate bne 
        j       main_loop_body
        hew:
        sw      $0,28($fp)
        j       welcome

wave:
        lw      $2,28($fp)
        addiu   $2,$2,1
        sw      $2,28($fp)
welcome:
        lw      $2,28($fp)
        slti    $2,$2,4
        xori	$2,$2,1 # xori 1, beq to simulate bne where val in [0,1]
        beq     $2,$0,wave

        move    $2,$0
        move    $sp,$fp
        lw      $31,36($sp)
        lw      $fp,32($sp)
        addiu   $sp,$sp,40
        jr       $ra
        
interest:
        lw      $4,24($fp)
        la	$ra, new
        j	is_visited
	new:
        xori    $2,$2,0x1
        andi    $2,$2,0x00ff
        beq     $2,$0,tasteful

        lw      $4,24($fp)
        la	$ra, partner
        j     	topsort
        partner:

tasteful:
        addiu   $2,$fp,28
        move    $4,$2
        la	$ra, badge
        j     next_edge
        badge:
        sw      $2,24($fp)
        
turkey:
        lw      $3,24($fp)
        li      $2,-1
        beq	$3,$2,telling # beq, j to simulate bne
        j	interest
        telling:
	la 	$v0, res_idx
	lw	$v0, 0($v0)
        addiu   $4,$2,-1
        la 	$3, res_idx
        sw 	$4, 0($3)
        la	$4, res
        #lui     $3,%hi(res_idx)
        #sw      $4,%lo(res_idx)($3)
        #lui     $4,%hi(res)
        sll     $3,$2,2
        srl	$3,$3,1
        sra	$3,$3,1
        sll     $3,$3,2
       
       	xor	$at, $ra, $2 # does nothing 
        nor	$at, $ra, $2 # does nothing 
        
        la	$2, res
        andi	$at, $2, 0xffff # -1 will sign extend (according to assembler), but 0xffff won't
        addu 	$2, $4, $at
        addu    $2,$3,$2
        lw      $3,48($fp)
        sw      $3,0($2)
        move    $sp,$fp
        lw      $31,44($sp)
        lw      $fp,40($sp)
        addiu   $sp,$sp,48
        jr      $ra
   
topsort:
        addiu   $sp,$sp,-48
        sw      $31,44($sp)
        sw      $fp,40($sp)
        move    $fp,$sp
        sw      $4,48($fp)
        lw      $4,48($fp)
        la	$ra, verse
        j	mark_visited
        verse:

        addiu   $2,$fp,28
        lw      $5,48($fp)
        move    $4,$2
        la 	$ra, joyous
        j	iterate_edges
        joyous:

        addiu   $2,$fp,28
        move    $4,$2
        la	$ra, whispering
        j     	next_edge
        whispering:

        sw      $2,24($fp)
        j       turkey

iterate_edges:
        addiu   $sp,$sp,-24
        sw      $fp,20($sp)
        move    $fp,$sp
        subu	$at, $fp, $sp
        sw      $4,24($fp)
        sw      $5,28($fp)
        lw      $2,28($fp)
        sw      $2,8($fp)
        sw      $0,12($fp)
        lw      $2,24($fp)
        lw      $4,8($fp)
        lw      $3,12($fp)
        sw      $4,0($2)
        sw      $3,4($2)
        lw      $2,24($fp)
        move    $sp,$fp
        lw      $fp,20($sp)
        addiu   $sp,$sp,24
        jr      $ra
        
next_edge:
        addiu   $sp,$sp,-32
        sw      $31,28($sp)
        sw      $fp,24($sp)
        add	$fp,$zero,$sp
        sw      $4,32($fp)
        j       waggish

snail:
        lw      $2,32($fp)
        lw      $3,0($2)
        lw      $2,32($fp)
        lw      $2,4($2)
        move    $5,$2
        move    $4,$3
        la	$ra,induce
        j       has_edge
        induce:
        beq     $2,$0,quarter
        lw      $2,32($fp)
        lw      $2,4($2)
        addiu   $4,$2,1
        lw      $3,32($fp)
        sw      $4,4($3)
        j       cynical


quarter:
        lw      $2,32($fp)
        lw      $2,4($2)
        addiu   $3,$2,1
        lw      $2,32($fp)
        sw      $3,4($2)

waggish:
        lw      $2,32($fp)
        lw      $2,4($2)
        slti    $2,$2,4
        beq	$2,$zero,mark # beq, j to simulate bne 
        j	snail
        mark:
        li      $2,-1

cynical:
        move    $sp,$fp
        lw      $31,28($sp)
        lw      $fp,24($sp)
        addiu   $sp,$sp,32
        jr      $ra
has_edge:
        addiu   $sp,$sp,-32
        sw      $fp,28($sp)
        move    $fp,$sp
        sw      $4,32($fp)
        sw      $5,36($fp)
        la      $2,adjacencymatrix
        lw      $3,32($fp)
        sll     $3,$3,2
        addu    $2,$3,$2
        lw      $2,0($2)
        sw      $2,16($fp)
        li      $2,1
        sw      $2,8($fp)
        sw      $0,12($fp)
        j       measley

look:
        lw      $2,8($fp)
        sll     $2,$2,1
        sw      $2,8($fp)
        lw      $2,12($fp)
        addiu   $2,$2,1
        sw      $2,12($fp)
measley:
        lw      $3,12($fp)
        lw      $2,36($fp)
        slt     $2,$3,$2
        beq     $2,$0,experience # beq, j to simulate bne 
        j 	look
       	experience:
        lw      $3,8($fp)
        lw      $2,16($fp)
        and     $2,$3,$2
        slt     $2,$0,$2
        andi    $2,$2,0x00ff
        move    $sp,$fp
        lw      $fp,28($sp)
        addiu   $sp,$sp,32
        jr      $ra
        
mark_visited:
        addiu   $sp,$sp,-32
        sw      $fp,28($sp)
        move    $fp,$sp
        sw      $4,32($fp)
        li      $2,1
        sw      $2,8($fp)
        sw      $0,12($fp)
        j       recast

example:
        lw      $2,8($fp)
        sll     $2,$2,8
        sw      $2,8($fp)
        lw      $2,12($fp)
        addiu   $2,$2,1
        sw      $2,12($fp)
recast:
        lw      $3,12($fp)
        lw      $2,32($fp)
        slt     $2,$3,$2
        beq	$2,$zero,pat # beq, j to simulate bne
        j	example
        pat:

       	la	$2, visited
        sw      $2,16($fp)
        lw      $2,16($fp)
        lw      $3,0($2)
        lw      $2,8($fp)
        or      $3,$3,$2
        lw      $2,16($fp)
        sw      $3,0($2)
        move    $sp,$fp
        lw      $fp,28($sp)
        addiu   $sp,$sp,32
        jr      $ra
        
is_visited:
        addiu   $sp,$sp,-32
        sw      $fp,28($sp)
        move    $fp,$sp
        sw      $4,32($fp)
        ori     $2,$zero,1
        sw      $2,8($fp)
        sw      $0,12($fp)
        j       evasive

justify:
        lw      $2,8($fp)
        sll     $2,$2,8
        sw      $2,8($fp)
        lw      $2,12($fp)
        addiu   $2,$2,1
        sw      $2,12($fp)
evasive:
        lw      $3,12($fp)
        lw      $2,32($fp)
        slt     $2,$3,$2
        beq	$2,$0,representitive # beq, j to simulate bne
        j     	justify
        representitive:

        la	$2,visited
        lw      $2,0($2)
        sw      $2,16($fp)
        lw      $3,16($fp)
        lw      $2,8($fp)
        and     $2,$3,$2
        slt     $2,$0,$2
        andi    $2,$2,0x00ff
        move    $sp,$fp
        lw      $fp,28($sp)
        addiu   $sp,$sp,32
        jr      $ra
