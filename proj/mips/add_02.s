.data   
dst:    .word   0xffffffff
.text   


    #load initial values into registers
addi    $1,     $0,     1       # Place 1 in $1
addi    $2,     $0,     2       # Place 2 in $2
addi    $3,     $0,     3       # Place 3 in $3
addi    $4,     $0,     4       # Place 4 in $4
addi    $5,     $0,     5       # Place 5 in $5
addi    $6,     $0,     6       # Place 6 in $6
addi    $7,     $0,     7       # Place 7 in $7
addi    $8,     $0,     8       # Place 8 in $8
addi    $9,     $0,     9       # Place 9 in $9
addi    $10,    $0,     10      # Place 10 in $10


    #do some adds
add     $1,     $1,     $2      #store 3 in 1
add     $2,     $2,     $3      #store 5 in 2
add     $3,     $3,     $4      #store 7 in 3
add     $4,     $4,     $5      #store 9 in 4
add     $5,     $5,     $6      #store 11 in 5
add     $6,     $6,     $7      #store 13 in 6
add     $7,     $7,     $8      #store 15 in 7
add     $8,     $8,     $9      #store 17 in 8
add     $9,     $9,     $10     #store 19 in 9

    #do some adds on those adds
add     $1,     $1,     $2      #store 8 in 1
add     $2,     $2,     $3      #store 12 in 2
add     $3,     $3,     $4      #store 16 in 3
add     $4,     $4,     $5      #store 30 in 4
add     $5,     $5,     $6      #store 24 in 5
add     $6,     $6,     $7      #store 28 in 6
add     $7,     $7,     $8      #store 32 in 7
add     $8,     $8,     $9      #store 36 in 8
add     $9,     $9,     $10     #store 39 in 9

    #set the register back to zero
add     $at,    $zero,  $zero
add     $v0,    $zero,  $zero
add     $v1,    $zero,  $zero

add     $a0,    $zero,  $zero
add     $a1,    $zero,  $zero
add     $a2,    $zero,  $zero
add     $a3,    $zero,  $zero

add     $t0,    $zero,  $zero
add     $t1,    $zero,  $zero
add     $t2,    $zero,  $zero
add     $t3,    $zero,  $zero
add     $t4,    $zero,  $zero
add     $t5,    $zero,  $zero
add     $t6,    $zero,  $zero
add     $t7,    $zero,  $zero

add     $s0,    $zero,  $zero
add     $s1,    $zero,  $zero
add     $s2,    $zero,  $zero
add     $s3,    $zero,  $zero
add     $s4,    $zero,  $zero
add     $s5,    $zero,  $zero
add     $s6,    $zero,  $zero
add     $s7,    $zero,  $zero

    #zero out temp registers
add     $t0,    $zero,  $zero
add     $t1,    $zero,  $zero
add     $t2,    $zero,  $zero

halt    