    #Test case 3 - revelations: Far jumps

    # For this testcase we want to stress test jumping to a "far" location in memory. We should be able to jump to far19
    # which is far down in program memory without issue. Additionally, t0 should only equal 1.
.data
.text
    .globlmain
main:
    # Start Test
    j       far19                   # t0 should equal 1.


far0:    addi    $t0,    $t0,    1
far1:    addi    $t0,    $t0,    1
far2:    addi    $t0,    $t0,    1
far3:    addi    $t0,    $t0,    1
far4:    addi    $t0,    $t0,    1
far5:    addi    $t0,    $t0,    1
far6:    addi    $t0,    $t0,    1
far7:    addi    $t0,    $t0,    1
far8:    addi    $t0,    $t0,    1
far9:    addi    $t0,    $t0,    1
far10:    addi    $t0,    $t0,    1
far11:    addi    $t0,    $t0,    1
far12:    addi    $t0,    $t0,    1
far13:    addi    $t0,    $t0,    1
far14:    addi    $t0,    $t0,    1
far15:    addi    $t0,    $t0,    1
far16:    addi    $t0,    $t0,    1
far17:    addi    $t0,    $t0,    1
far18:    addi    $t0,    $t0,    1
far19:    addi    $t0,    $t0,    1

    halt    
    # end test





