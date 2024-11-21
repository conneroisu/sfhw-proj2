.data   
N:          .word   5
a_array:    .word   0, 0, 0, 0, 0, 0
c_array:    .word   0, 1, 2, 3, 4, 5
.text   
            .globl  main
main:       
    # Setup example with some static data
    lui     $t0,    0x1001              # load address of N (0x10000000)
    lw      $s3,    0($t0)              # load N
    ori     $s0,    $t0,    0x0004      # load lower value of a -- &a[0]
    ori     $s1,    $t0,    0x001c      # load lower value of c -- &c[0]

    # $s0:a 	$s1:c 		$s2:i 		$s3:N
    ori     $s2,    $zero,  1           # i=1
    j       cond                        # get to i<=N evaluation
loop:       
    sll     $t2,    $s2,    2           # i*4 to load words
    addu    $t0,    $t2,    $s1         # &c[i]
    lw      $t0,    0($t0)              # c[i]
    sll     $t0,    $t0,    4           # c[i]*16
    addu    $t2,    $t2,    $s0         # &a[i]
    sw      $t0,    0($t2)              # a[i] = c[i]*16
    addiu   $s2,    $s2,    1           # i++
cond:       
    slt     $t0,    $s3,    $s2         # $t0 is 1 if N < i (i.e., when i <= N is false and we want to fall through)
    beq     $t0,    $zero,  loop        # execute loop body when i <= N
    # End answer portion --> you should now be able to check the data memory values and see that the behavior is correct

    # Exit program
    halt    
    addi    $v0,    $zero,  10
    syscall 
