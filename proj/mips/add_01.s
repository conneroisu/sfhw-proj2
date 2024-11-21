.data

.text

lui     $t0,    0xFFFF          #load upper bits
addi    $t0,    $t0,    0xFFFF  #loads rest of word

addi    $t2,    $0,     2       #used to show overflow above

add     $t1,    $t0,    $t0     #this should result in overflow, ends up with 0xFFFFFFFE
add     $t3,    $t0,    $t2     #this should result in overflow, ends up with 1 in register $t3

halt    
