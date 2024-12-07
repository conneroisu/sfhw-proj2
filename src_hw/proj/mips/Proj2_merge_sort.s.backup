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
    addi $a2, $a2, -1   # Right index = size-1
    jal mergeSort
    j exit

mergeSort:
    # Save return address and registers we'll use
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $s0, 8($sp)      # For left index
    sw $s1, 4($sp)      # For right index
    sw $s2, 0($sp)      # For mid point

    # If left >= right, return (base case)
    slt $t0, $a1, $a2   # t0 = 1 if left < right
    beq $t0, $zero, mergeSortReturn

    # Calculate mid point: mid = (left + right) / 2
    add $s2, $a1, $a2   # mid = left + right
    srl $s2, $s2, 1     # mid = (left + right) / 2

    # Save arguments
    move $s0, $a1       # Save left
    move $s1, $a2       # Save right

    # Call mergeSort(arr, left, mid)
    move $a2, $s2       # right = mid
    jal mergeSort

    # Call mergeSort(arr, mid+1, right)
    addi $a1, $s2, 1    # left = mid + 1
    move $a2, $s1       # right = original right
    jal mergeSort

    # Call merge(arr, left, mid, right)
    move $a1, $s0       # Restore original left
    move $a2, $s2       # mid
    move $a3, $s1       # Restore original right
    jal merge

mergeSortReturn:
    # Restore registers and return
    lw $ra, 12($sp)
    lw $s0, 8($sp)
    lw $s1, 4($sp)
    lw $s2, 0($sp)
    addi $sp, $sp, 16
    jr $ra

merge:
    # Save registers
    addi $sp, $sp, -28
    sw $ra, 24($sp)
    sw $s0, 20($sp)     # Left index for first subarray
    sw $s1, 16($sp)     # Right index for first subarray (mid)
    sw $s2, 12($sp)     # Left index for second subarray
    sw $s3, 8($sp)      # Right index for second subarray
    sw $s4, 4($sp)      # Index for temp array
    sw $s5, 0($sp)      # Base address of temp array

    # Initialize indices
    move $s0, $a1       # i = left
    move $s1, $a2       # mid
    addi $s2, $a2, 1    # j = mid + 1
    move $s3, $a3       # right
    move $s4, $a1       # k = left
    la $s5, temp        # Load temp array address

mergeLoop1:
    # While there are elements in both arrays
    slt $t0, $s1, $s0   # t0 = 1 if i > mid
    bne $t0, $zero, mergeLoop2
    slt $t0, $s3, $s2   # t0 = 1 if j > right
    bne $t0, $zero, mergeLoop2

    # Load elements from both subarrays
    sll $t1, $s0, 2     # t1 = i * 4
    add $t1, $a0, $t1   # t1 = address of arr[i]
    lw $t3, 0($t1)      # t3 = arr[i]

    sll $t2, $s2, 2     # t2 = j * 4
    add $t2, $a0, $t2   # t2 = address of arr[j]
    lw $t4, 0($t2)      # t4 = arr[j]

    # Compare elements
    slt $t0, $t4, $t3   # t0 = 1 if arr[j] < arr[i]
    beq $t0, $zero, copyFromFirst

copyFromSecond:
    # temp[k] = arr[j]
    sll $t5, $s4, 2     # t5 = k * 4
    add $t5, $s5, $t5   # t5 = address of temp[k]
    sw $t4, 0($t5)      # temp[k] = arr[j]
    addi $s2, $s2, 1    # j++
    j incrementK

copyFromFirst:
    # temp[k] = arr[i]
    sll $t5, $s4, 2     # t5 = k * 4
    add $t5, $s5, $t5   # t5 = address of temp[k]
    sw $t3, 0($t5)      # temp[k] = arr[i]
    addi $s0, $s0, 1    # i++

incrementK:
    addi $s4, $s4, 1    # k++
    j mergeLoop1

mergeLoop2:
    # Copy remaining elements from first subarray
    slt $t0, $s1, $s0   # t0 = 1 if i > mid
    bne $t0, $zero, mergeLoop3

    sll $t1, $s0, 2     # t1 = i * 4
    add $t1, $a0, $t1   # t1 = address of arr[i]
    lw $t3, 0($t1)      # t3 = arr[i]

    sll $t5, $s4, 2     # t5 = k * 4
    add $t5, $s5, $t5   # t5 = address of temp[k]
    sw $t3, 0($t5)      # temp[k] = arr[i]

    addi $s0, $s0, 1    # i++
    addi $s4, $s4, 1    # k++
    j mergeLoop2

mergeLoop3:
    # Copy remaining elements from second subarray
    slt $t0, $s3, $s2   # t0 = 1 if j > right
    bne $t0, $zero, copyBack

    sll $t2, $s2, 2     # t2 = j * 4
    add $t2, $a0, $t2   # t2 = address of arr[j]
    lw $t4, 0($t2)      # t4 = arr[j]

    sll $t5, $s4, 2     # t5 = k * 4
    add $t5, $s5, $t5   # t5 = address of temp[k]
    sw $t4, 0($t5)      # temp[k] = arr[j]

    addi $s2, $s2, 1    # j++
    addi $s4, $s4, 1    # k++
    j mergeLoop3

copyBack:
    # Copy from temp back to original array
    move $t0, $a1       # i = left
copyBackLoop:
    slt $t1, $a3, $t0   # t1 = 1 if i > right
    bne $t1, $zero, mergeReturn

    sll $t2, $t0, 2     # t2 = i * 4
    add $t3, $s5, $t2   # t3 = address of temp[i]
    lw $t4, 0($t3)      # t4 = temp[i]

    add $t3, $a0, $t2   # t3 = address of arr[i]
    sw $t4, 0($t3)      # arr[i] = temp[i]

    addi $t0, $t0, 1    # i++
    j copyBackLoop

mergeReturn:
    # Restore registers
    lw $ra, 24($sp)
    lw $s0, 20($sp)
    lw $s1, 16($sp)
    lw $s2, 12($sp)
    lw $s3, 8($sp)
    lw $s4, 4($sp)
    lw $s5, 0($sp)
    addi $sp, $sp, 28
    jr $ra

exit:
    # Exit program
    halt
