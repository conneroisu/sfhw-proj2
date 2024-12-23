.data
    # Space for array (adjust size as needed)
    array: .word 0:100    # Array to store 100 integers
    size:  .word 0        # Current size of array
    temp:  .word 0:100    # Temporary array for merging

.text
.globl main

main:
    lw $a0, array        # Load array base address
    li $a1, 0           # Left index = 0
    lw $a2, size        # Load size
	nop
	nop
	nop
    addi $a2, $a2, -1   # Right index = size-1
	nop
	nop
	nop
    jal mergeSort
    j exit
mergeSort:
    addi $sp, $sp, -16 # Save return address and registers we'll use
	nop
	nop
	nop
    sw $ra, 12($sp)
	nop
	nop
	nop
    sw $s0, 8($sp)      # For left index
    sw $s1, 4($sp)      # For right index
	nop
	nop
	nop
    sw $s2, 0($sp)      # For mid point
    # If left >= right, return (base case)
	nop
	nop
	nop
    slt $t0, $a1, $a2   # t0 = 1 if left < right
	nop
	nop
	nop
    beq $t0, $zero, mergeSortReturn
    add $s2, $a1, $a2   # mid = left + right
	nop
	nop
	nop
    srl $s2, $s2, 1     # mid = (left + right) / 2
	nop
	nop
	nop
    # Save arguments
    move $s0, $a1       # Save left
	nop
	nop
	nop
    move $s1, $a2       # Save right
	nop
	nop
	nop
    move $a2, $s2       # right = mid
	nop
	nop
	nop
    jal mergeSort
	nop
	nop
	nop
    addi $a1, $s2, 1    # left = mid + 1
	nop
	nop
	nop
    move $a2, $s1       # right = original right
	nop
	nop
	nop
    jal mergeSort
	nop
	nop
	nop
    move $a1, $s0       # Restore original left
	nop
	nop
	nop
    move $a2, $s2       # mid
	nop
	nop
	nop
    move $a3, $s1       # Restore original right
	nop
	nop
	nop
    jal merge
	nop
	nop
	nop
mergeSortReturn:
	nop
	nop
	nop
    lw $ra, 12($sp)
	nop
	nop
	nop
    lw $s0, 8($sp)
	nop
	nop
	nop
    lw $s1, 4($sp)
	nop
	nop
	nop
    lw $s2, 0($sp)
	nop
	nop
	nop
    addi $sp, $sp, 16
	nop
	nop
	nop
    jr $ra
	nop
	nop
	nop
merge:
	nop
	nop
	nop
    addi $sp, $sp, -28
	nop
	nop
	nop
    sw $ra, 24($sp)
	nop
	nop
	nop
    sw $s0, 20($sp)     # Left index for first subarray
	nop
	nop
	nop
    sw $s1, 16($sp)     # Right index for first subarray (mid)
	nop
	nop
	nop
    sw $s2, 12($sp)     # Left index for second subarray
	nop
	nop
	nop
    sw $s3, 8($sp)      # Right index for second subarray
	nop
	nop
	nop
    sw $s4, 4($sp)      # Index for temp array
	nop
	nop
	nop
    sw $s5, 0($sp)      # Base address of temp array
	nop
	nop
	nop
    move $s0, $a1       # i = left
	nop
	nop
	nop
    move $s1, $a2       # mid
	nop
	nop
	nop
    addi $s2, $a2, 1    # j = mid + 1
	nop
	nop
	nop
    move $s3, $a3       # right
	nop
	nop
	nop
    move $s4, $a1       # k = left
	nop
	nop
	nop
    la $s5, temp        # Load temp array address
	nop
	nop
	nop
mergeLoop1:
	nop
	nop
	nop
    slt $t0, $s1, $s0   # t0 = 1 if i > mid
	nop
	nop
	nop
    bne $t0, $zero, mergeLoop2
	nop
	nop
	nop
    slt $t0, $s3, $s2   # t0 = 1 if j > right
	nop
	nop
	nop
    bne $t0, $zero, mergeLoop2
	nop
	nop
	nop
    sll $t1, $s0, 2     # t1 = i * 4
	nop
	nop
	nop
    add $t1, $a0, $t1   # t1 = address of arr[i]
	nop
	nop
	nop
    lw $t3, 0($t1)      # t3 = arr[i]
	nop
	nop
	nop
    sll $t2, $s2, 2     # t2 = j * 4
	nop
	nop
	nop
    add $t2, $a0, $t2   # t2 = address of arr[j]
	nop
	nop
	nop
    lw $t4, 0($t2)      # t4 = arr[j]
	nop
	nop
	nop
    slt $t0, $t4, $t3   # t0 = 1 if arr[j] < arr[i]
	nop
	nop
	nop
    beq $t0, $zero, copyFromFirst
	nop
	nop
	nop
copyFromSecond:
	nop
	nop
	nop
    sll $t5, $s4, 2     # t5 = k * 4
	nop
	nop
	nop
    add $t5, $s5, $t5   # t5 = address of temp[k]
	nop
	nop
	nop
    sw $t4, 0($t5)      # temp[k] = arr[j]
	nop
	nop
	nop
    addi $s2, $s2, 1    # j++
	nop
	nop
	nop
    j incrementK
	nop
	nop
	nop
copyFromFirst:
	nop
	nop
	nop
    sll $t5, $s4, 2     # t5 = k * 4
	nop
	nop
	nop
    add $t5, $s5, $t5   # t5 = address of temp[k]
	nop
	nop
	nop
    sw $t3, 0($t5)      # temp[k] = arr[i]
    addi $s0, $s0, 1    # i++
incrementK:
	nop
	nop
	nop
    addi $s4, $s4, 1    # k++
	nop
	nop
	nop
    j mergeLoop1
	nop
	nop
	nop
mergeLoop2:
	nop
	nop
	nop
    slt $t0, $s1, $s0   # t0 = 1 if i > mid
	nop
	nop
	nop
    bne $t0, $zero, mergeLoop3
	nop
	nop
	nop
    sll $t1, $s0, 2     # t1 = i * 4
	nop
	nop
	nop
    add $t1, $a0, $t1   # t1 = address of arr[i]
	nop
	nop
	nop
    lw $t3, 0($t1)      # t3 = arr[i]
	nop
	nop
	nop
    sll $t5, $s4, 2     # t5 = k * 4
	nop
	nop
	nop
    add $t5, $s5, $t5   # t5 = address of temp[k]
	nop
	nop
	nop
    sw $t3, 0($t5)      # temp[k] = arr[i]
	nop
	nop
	nop
    addi $s0, $s0, 1    # i++
	nop
	nop
	nop
    addi $s4, $s4, 1    # k++
	nop
	nop
	nop
    j mergeLoop2
	nop
	nop
	nop
mergeLoop3:
	nop
	nop
	nop
    slt $t0, $s3, $s2   # t0 = 1 if j > right
	nop
	nop
	nop
    bne $t0, $zero, copyBack
    sll $t2, $s2, 2     # t2 = j * 4
	nop
	nop
	nop
    add $t2, $a0, $t2   # t2 = address of arr[j]
	nop
	nop
	nop
    lw $t4, 0($t2)      # t4 = arr[j]
	nop
	nop
	nop
    sll $t5, $s4, 2     # t5 = k * 4
	nop
	nop
	nop
    add $t5, $s5, $t5   # t5 = address of temp[k]
	nop
	nop
	nop
    sw $t4, 0($t5)      # temp[k] = arr[j]
	nop
	nop
	nop
    addi $s2, $s2, 1    # j++
	nop
	nop
	nop
    addi $s4, $s4, 1    # k++
	nop
	nop
	nop
    j mergeLoop3
	nop
	nop
	nop
copyBack:
	nop
	nop
	nop
    move $t0, $a1       # i = left
	nop
	nop
	nop
copyBackLoop:
	nop
	nop
	nop
    slt $t1, $a3, $t0   # t1 = 1 if i > right
	nop
	nop
	nop
    bne $t1, $zero, mergeReturn
	nop
	nop
	nop
    sll $t2, $t0, 2     # t2 = i * 4
	nop
	nop
	nop
    add $t3, $s5, $t2   # t3 = address of temp[i]
	nop
	nop
	nop
    lw $t4, 0($t3)      # t4 = temp[i]
	nop
	nop
	nop
    add $t3, $a0, $t2   # t3 = address of arr[i]
	nop
	nop
	nop
    sw $t4, 0($t3)      # arr[i] = temp[i]
	nop
	nop
	nop
    addi $t0, $t0, 1    # i++
	nop
	nop
	nop
    j copyBackLoop
	nop
	nop
	nop
mergeReturn:
	nop
	nop
	nop
    lw $ra, 24($sp)
	nop
	nop
	nop
    lw $s0, 20($sp)
	nop
	nop
	nop
    lw $s1, 16($sp)
	nop
	nop
	nop
    lw $s2, 12($sp)
	nop
	nop
	nop
    lw $s3, 8($sp)
	nop
	nop
	nop
    lw $s4, 4($sp)
	nop
	nop
	nop
    lw $s5, 0($sp)
	nop
	nop
	nop
    addi $sp, $sp, 28
    jr $ra
exit:
    halt
