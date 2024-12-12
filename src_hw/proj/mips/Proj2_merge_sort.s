.data
    array: .space 400    # Space for 100 integers
    size:  .word  10     # Size of array

.text
.globl main

main:
    # Initialize registers for array loading
    lui $t0, 0x1001     # Load upper immediate for array address
    li  $t1, 0          # Counter
    li  $t2, 10         # Array size

    # Load sample values into array
    sw   $zero, 0($t0)   # array[0] = 0
    addi $t3, $zero, 9
    sw   $t3, 4($t0)     # array[1] = 9
    addi $t3, $zero, 8
    sw   $t3, 8($t0)     # array[2] = 8
    addi $t3, $zero, 7
    sw   $t3, 12($t0)    # array[3] = 7
    addi $t3, $zero, 6
    sw   $t3, 16($t0)    # array[4] = 6
    addi $t3, $zero, 5
    sw   $t3, 20($t0)    # array[5] = 5
    addi $t3, $zero, 4
    sw   $t3, 24($t0)    # array[6] = 4
    addi $t3, $zero, 3
    sw   $t3, 28($t0)    # array[7] = 3
    addi $t3, $zero, 2
    sw   $t3, 32($t0)    # array[8] = 2
    addi $t3, $zero, 1
    sw   $t3, 36($t0)    # array[9] = 1

    # Call mergeSort
    add  $a0, $t0, $zero  # First argument: array address
    add  $a1, $zero, $zero # Second argument: left = 0
    addi $a2, $t2, -1     # Third argument: right = size-1
    jal  mergeSort

    # Exit program
    li   $v0, 10
    syscall

mergeSort:
    # Save return address and registers
    addi $sp, $sp, -16
    sw   $ra, 0($sp)
    sw   $s0, 4($sp)
    sw   $s1, 8($sp)
    sw   $s2, 12($sp)

    # Check if left < right
    slt  $t0, $a1, $a2
    beq  $t0, $zero, mergeSortReturn

    # Calculate mid = (left + right)/2
    add  $s0, $a1, $a2    # left + right
    srl  $s0, $s0, 1      # Divide by 2

    # Save arguments
    add  $s1, $a1, $zero  # Save left
    add  $s2, $a2, $zero  # Save right

    # First recursive call: mergeSort(arr, left, mid)
    add  $a2, $s0, $zero  # Set right = mid
    jal  mergeSort

    # Second recursive call: mergeSort(arr, mid+1, right)
    addi $a1, $s0, 1      # Set left = mid + 1
    add  $a2, $s2, $zero  # Restore right
    jal  mergeSort

    # Merge the sorted halves
    add  $a1, $s1, $zero  # Restore left
    add  $a2, $s2, $zero  # right is already restored
    add  $a3, $s0, $zero  # Pass mid as third argument
    jal  merge

mergeSortReturn:
    # Restore registers and return
    lw   $ra, 0($sp)
    lw   $s0, 4($sp)
    lw   $s1, 8($sp)
    lw   $s2, 12($sp)
    addi $sp, $sp, 16
    jr   $ra

merge:
    # Save registers
    addi $sp, $sp, -40
    sw   $ra, 0($sp)
    sw   $s0, 4($sp)    # Original array address
    sw   $s1, 8($sp)    # Left index for left subarray
    sw   $s2, 12($sp)   # Right index for right subarray
    sw   $s3, 16($sp)   # Index for merged array
    sw   $s4, 20($sp)   # Left array end
    sw   $s5, 24($sp)   # Right array end
    sw   $s6, 28($sp)   # Temporary storage
    sw   $s7, 32($sp)   # Temporary storage
    sw   $t0, 36($sp)   # Temporary array address

    # Initialize variables
    add  $s0, $a0, $zero  # Save array address
    add  $s1, $a1, $zero  # i = left
    addi $s2, $a3, 1     # j = mid + 1
    add  $s3, $a1, $zero  # k = left
    add  $s4, $a3, $zero  # leftEnd = mid
    add  $s5, $a2, $zero  # rightEnd = right

mergeLoop:
    # Check if either subarray is exhausted
    slt  $t0, $s4, $s1    # Check if left subarray is exhausted
    bne  $t0, $zero, copyRight
    slt  $t0, $s5, $s2    # Check if right subarray is exhausted
    bne  $t0, $zero, copyLeft

    # Compare elements from both subarrays
    sll  $t1, $s1, 2      # Calculate offset for left element
    add  $t1, $s0, $t1
    lw   $t2, 0($t1)      # Load left element
    sll  $t3, $s2, 2      # Calculate offset for right element
    add  $t3, $s0, $t3
    lw   $t4, 0($t3)      # Load right element

    # Compare and copy smaller element
    slt  $t0, $t4, $t2    # if right < left
    bne  $t0, $zero, copyRightElement

copyLeftElement:
    sll  $t5, $s3, 2      # Calculate destination offset
    add  $t5, $s0, $t5
    sw   $t2, 0($t5)      # Store element
    addi $s1, $s1, 1      # Increment left index
    addi $s3, $s3, 1      # Increment destination index
    j    mergeLoop

copyRightElement:
    sll  $t5, $s3, 2      # Calculate destination offset
    add  $t5, $s0, $t5
    sw   $t4, 0($t5)      # Store element
    addi $s2, $s2, 1      # Increment right index
    addi $s3, $s3, 1      # Increment destination index
    j    mergeLoop

copyLeft:
    # Copy remaining elements from left subarray
    slt  $t0, $s4, $s1    # Check if left subarray is exhausted
    bne  $t0, $zero, mergeEnd
    sll  $t1, $s1, 2
    add  $t1, $s0, $t1
    lw   $t2, 0($t1)
    sll  $t3, $s3, 2
    add  $t3, $s0, $t3
    sw   $t2, 0($t3)
    addi $s1, $s1, 1
    addi $s3, $s3, 1
    j    copyLeft

copyRight:
    # Copy remaining elements from right subarray
    slt  $t0, $s5, $s2    # Check if right subarray is exhausted
    bne  $t0, $zero, mergeEnd
    sll  $t1, $s2, 2
    add  $t1, $s0, $t1
    lw   $t2, 0($t1)
    sll  $t3, $s3, 2
    add  $t3, $s0, $t3
    sw   $t2, 0($t3)
    addi $s2, $s2, 1
    addi $s3, $s3, 1
    j    copyRight

mergeEnd:
    # Restore registers and return
    lw   $ra, 0($sp)
    lw   $s0, 4($sp)
    lw   $s1, 8($sp)
    lw   $s2, 12($sp)
    lw   $s3, 16($sp)
    lw   $s4, 20($sp)
    lw   $s5, 24($sp)
    lw   $s6, 28($sp)
    lw   $s7, 32($sp)
    lw   $t0, 36($sp)
    addi $sp, $sp, 40
    jr   $ra
    halt
