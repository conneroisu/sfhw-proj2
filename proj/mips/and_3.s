.data
.text
    .globlmain

main:
    addi    $t1,    $0,     0x87654321
    addi    $t2,    $0,     0x12345678

    and     $a0,    $t1,    $t2         # should load 0x02244220 into $a0
    and     $t1,    $0,     $0          #should load 0x00000000 into $t1
    and     $t2,    $0,     $0          #should load 0x00000000 into $t0

    addi    $t1,    $0,     0x44444444
    addi    $t2,    $0,     0x55555555

    and     $a0,    $t1,    $t2         #should load 0x44444444 into $a0
    and     $a0,    $t1,    $0          #should set all bit sin a0 to 0

    addi    $t1,    $0,     0x0000FFFF
    addi    $t2,    $0,     0x11110000

    and     $a0,    $t1,    $t2         #should load 0x00000000 into $a0
    and     $a0,    $t1,    $0          #should set all bit sin a0 to 0

    addi    $t1,    $0,     0x18008118
    addi    $t2,    $0,     0x18181818

    and     $a0,    $t1,    $t2         #should load 0x18000018 into $a0
    and     $a0,    $t1,    $0          #should set all bit sin a0 to 0
    halt    