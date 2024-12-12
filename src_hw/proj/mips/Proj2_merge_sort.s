        .data
array:  .word 7, 2, 5, 3, 1, 8, 6, 4   # The array to sort
n:      .word 8                        # Array length

        .text
        .globl main
main:
        # Load address of array into $s0
        lui     $s0, %hi(array)
        ori     $s0, $s0, %lo(array)

        # Load n into $s1
        lui     $t0, %hi(n)
        ori     $t0, $t0, %lo(n)
        lw      $s1, 0($t0)

        # left = 0
        addu    $a0, $zero, $zero
        # right = n - 1
        addu    $a1, $s1, $zero
        addi    $a1, $a1, -1

        jal     mergesort

done:
        j       done    # Infinite loop to end

####################################################
# mergesort(int left, int right)
# if left < right:
#    mid = (left+right)/2
#    mergesort(left, mid)
#    mergesort(mid+1, right)
#    merge(left, mid, right)
####################################################

mergesort:
        # Stack frame: 32 bytes
        # [sp+28] = ra
        # [sp+24] = s0
        # [sp+20] = s1
        # [sp+16] = left
        # [sp+12] = right
        addi    $sp, $sp, -32
        sw      $ra, 28($sp)
        sw      $s0, 24($sp)
        sw      $s1, 20($sp)
        sw      $a0, 16($sp)
        sw      $a1, 12($sp)

        lw      $t0, 16($sp)  # left
        lw      $t1, 12($sp)  # right

        # if (left < right)?
        slt     $t2, $t0, $t1
        beq     $t2, $zero, m_end

        # mid = (left+right)/2
        addu    $t3, $t0, $t1
        sra     $t3, $t3, 1

        # mergesort(left, mid)
        addu    $a0, $t0, $zero
        addu    $a1, $t3, $zero
        jal     mergesort

        # mergesort(mid+1, right)
        addi    $t4, $t3, 1
        addu    $a0, $t4, $zero
        addu    $a1, $t1, $zero
        jal     mergesort

        # merge(left, mid, right)
        addu    $a0, $t0, $zero
        addu    $a1, $t3, $zero
        addu    $a2, $t1, $zero
        jal     merge

m_end:
        lw      $ra, 28($sp)
        lw      $s0, 24($sp)
        lw      $s1, 20($sp)
        addi    $sp, $sp, 32
        jr      $ra

####################################################
# merge(int left, int mid, int right)
#
# Uses a temporary buffer B on the stack to hold merged
# elements, then copies them back to A.
# i = left, j = mid+1
# For k from left to right:
#   if j>right or (i<=mid and A[i]<=A[j]):
#       B[k]=A[i]; i++
#     else:
#       B[k]=A[j]; j++
# Copy B[left..right] back to A.
####################################################

merge:
        # Stack frame: 64 bytes
        # [sp+60] = ra
        # [sp+56] = s0
        # [sp+52] = s1
        # [sp+48] = left
        # [sp+44] = mid
        # [sp+40] = right
        # The remaining space will be used for B.
        addi    $sp, $sp, -64
        sw      $ra, 60($sp)
        sw      $s0, 56($sp)
        sw      $s1, 52($sp)
        sw      $a0, 48($sp)
        sw      $a1, 44($sp)
        sw      $a2, 40($sp)

        lw      $t0, 48($sp)  # left
        lw      $t1, 44($sp)  # mid
        lw      $t2, 40($sp)  # right

        addi    $t3, $t1, 1   # j = mid+1
        addu    $t4, $t0, $zero  # i = left
        addu    $t6, $t0, $zero  # k = left start

m_loop_k:
        # if k > right break
        # Check if right < k
        slt     $t7, $t2, $t6
        bne     $t7, $zero, m_copy_back

        # Check if j > right?
        slt     $t8, $t2, $t3
        bne     $t8, $zero, use_i  # If j>right, must take from i

        # Check if i > mid?
        slt     $t9, $t1, $t4
        bne     $t9, $zero, use_j  # If i>mid, must take j
        # A[i] <= A[j]?
        # Load A[i]
        # Originally used $t10, $t11; now using $v0, $v1
        sll     $v0, $t4, 2
        addu    $v0, $v0, $s0
        lw      $v1, 0($v0)

        # Load A[j]
        # Originally used $t12, $t13; now using $a3, $a2
        sll     $a3, $t3, 2
        addu    $a3, $a3, $s0
        lw      $a2, 0($a3)

        # slt $t14, $t11, $t13 => now slt $s2, $v1, $a2
        slt     $s2, $v1, $a2
        bne     $s2, $zero, use_i
        # If equal, also use i
        beq     $v1, $a2, use_i

use_j:
        # B[k] = A[j]
        # Originally used $t15, $t16, $t17; now $s3, $s4, $s5
        sub     $s3, $t6, $t0
        sll     $s3, $s3, 2
        addu    $s4, $sp, $s3
        lw      $s5, 0($a3)
        sw      $s5, 0($s4)
        addi    $t3, $t3, 1
        j       cont_k

use_i:
        # B[k] = A[i]
        # Same register mapping as above
        sub     $s3, $t6, $t0
        sll     $s3, $s3, 2
        addu    $s4, $sp, $s3
        lw      $s5, 0($v0)
        sw      $s5, 0($s4)
        addi    $t4, $t4, 1

cont_k:
        addi    $t6, $t6, 1
        j       m_loop_k

m_copy_back:
        # Copy B[left..right] back to A
        # Originally used $t15, $t16, $t17, $t18; now using $s3, $s4, $s5, $s6
        addu    $t6, $t0, $zero
c_loop:
        slt     $t7, $t2, $t6
        bne     $t7, $zero, m_end_merge

        sub     $s3, $t6, $t0
        sll     $s3, $s3, 2
        addu    $s4, $sp, $s3
        lw      $s5, 0($s4)

        sll     $s6, $t6, 2
        addu    $s6, $s6, $s0
        sw      $s5, 0($s6)

        addi    $t6, $t6, 1
        j       c_loop
