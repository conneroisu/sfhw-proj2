.data

.text

lui     $0,    0xFFFF          #load upper bits
addi    $0,    $t0,    0xFFFF  #loads rest of word

or    $t1,    $0,      $0       #used to show overflow above

addiu $2,     $0,      10

halt    
