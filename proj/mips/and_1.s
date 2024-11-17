.data
.text
.globl main

main:
addi $t1, $0, 0x00000000
addi $t2, $0, 0x00000000

and $a0, $t1, $t2 # should load 0x00000000 into $a0
and $t1, $0, $0 #should load 0x00000000 into $t1
and $t2, $0, $0 #should load 0x00000000 into $t0

addi $t1, $0, 0x21345120
addi $t2, $0, 0x10141000

and $a0, $t1, $t2 #should load 0x00141000 into $a0
and $a0, $t1, $0 #should set all bit sin a0 to 0

addi $t1, $0, 0xAFEDCBDE
addi $t2, $0, 0x88888888

and $a0, $t1, $t2 #should load 0x88888888 into $a0
and $a0, $t1, $0 #should set all bit sin a0 to 0


halt