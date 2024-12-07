# Test Flushing of IF on control flow instruction
j check1
addi $t1, $0, 5 # Flush this to nop
check1:
addi $t2, $0, 1

# Test data flow hazard through a control flow hazard
addi $t3 $0, 2
j check2
addi $t1, $0, 999 # Flush this to nop
check2:
addi $t2, $2, 1 # Fwd from wb to id

# Test branch in combination with data flow hazard
addi $t1, $0, 1
addi $t2, $0, 1
beq $t1, $t2, check3
addi $t1, $0, 999 # Flush this
check3:
add $t3, $t2, $t1 # No fwd needed because beq stalls for the data hazards

# Branch & Jump combination
addi $t1, $0, 1
addi $t2, $0, 1
j check4
addi $t1, $0, 3 # Flush
check4:
beq $t1, $t2, check5 # Stall once for $t3 (Because it's in WB)
addi $t1, $0, 3 # Flush
check5:
add $t3, $t2, $t1 # No fwding needed because branch stalled $t3 and $t2 out of pipeline


# j, jal, jr test
	jal jalmiddle
	addi $t6, $0, 1 # Initially flushed then returned to
	j jal_end
jmid  : addi $t5, $0, 1 # Executed then flushed out later by jump
	    jr $ra
jend  : addi $t7, $0, 1 # Initially flushed then returned to



halt
