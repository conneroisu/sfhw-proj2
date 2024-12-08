
addi $t1, $0, 5
lui $t5, 0x1000
sw $t1, 0($t5) # Fwd $t3 and $t2

# Test1: Load-use
lw $2, 0($t5)
addi $3, $t3, 1 # (Stall b/c of load-use)
addi $4, $t3, 2 # Fwd $1
addi $5, $2, 3 # Okay because of stall

t0 t1 t2 t3
# Test2: Regfile bypass
addi $t2, $0, 5
addi $t3, $t2, 1 # (fwd)
addi $t4, $t2, 1 # (fwd)
and $t2, $t2, $t3 # (rf bypass)

# Test3: Fwd mem -> ex
addi $t1, $0, 10
addi $t2, $t1, 20 # (fwd mem to ex stage)

# Test4: Fwd wb to ex 
addi $t1, $0, 10
nop
addi $t2, $t1, 20 # (fwd wb to ex stage)

# Test5: Fwd wb to mem to ex
addi $t1, $0, 10
addi $t2, $t1, 20 # (fwd from mem to ex)
addi $t3, $t2, 30 # (fwd from mem to ex)

# Test6: STall branch/Jr b/c of data hazard
addi $t1, $0, 1
addi $t2, $0, 1
beq $t1, $t2, brnch # Stall dependencies out of pipeline because pc fetch is in ID and it isn't Fwded
addi $t2, $0, 3 # Flushed
brnch:
halt

