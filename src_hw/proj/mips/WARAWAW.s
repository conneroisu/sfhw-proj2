.text
main:
    add $t1, $t2, $t3       # RAW with $t1
    sub $t3, $t1, $t4       # WAR with $t3, RAW with $t1
    or $t5, $t6, $t1        # WAW with $t1
    and $t7, $t1, $t8       # RAW with $t1
    xor $t3, $t9, $t2       # WAW with $t3

