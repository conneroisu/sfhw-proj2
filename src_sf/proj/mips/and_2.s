.data
.text
    .globlmain

main:
    #begin test
    addi    $t1,    $0,     0xFFFFFFFF
    addi    $t2,    $0,     0xFFFFFFFF

    and     $a0,    $t1,    $t2         # should load 0xFFFFFFFF into $a0
    and     $t1,    $0,     $0          #should load 0x00000000 into $t1
    and     $t2,    $0,     $0          #should load 0x00000000 into $t0

    addi    $t1,    $0,     0x01010101
    addi    $t2,    $0,     0x11111111

    and     $a0,    $t1,    $t2         #should load 0x01010101 into $a0
    and     $a0,    $t1,    $0          #should set all bit sin a0 to 0

    addi    $t1,    $0,     0xFFFFFFFF
    addi    $t2,    $0,     0x11111111

    and     $a0,    $t1,    $t2         #should load 0x11111111 into $a0
    and     $a0,    $t1,    $0          #should set all bit sin a0 to 0

    addi    $t1,    $0,     0x01010101
    addi    $t2,    $0,     0x01250481

    and     $a0,    $t1,    $t2         #should load 0x01010101 into $a0
    and     $a0,    $t1,    $0          #should set all bit sin a0 to 0

    halt    
