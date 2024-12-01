    #Test case 1 - Rise of the testcases: Arbitrary/nested jumping.

    # This is a kind of weird instruction to test.
    # Our program counter should be the address of the label we jump to. In addition, no instructions after jump should execute unless they are
    # at or after the label or we later jump to them.

    # My first test case is jumping to test1 and asserting we do not jump to the failstate.
    # We will be using t0 to confirm final values. t0 should be 1. After jump test1.
    # We then immediately jump to test3. test2 should not execute yet. t0 = 1 still
    # Immediately jump to test4. t0 should still equal 1.
    # t0 will now equal 1001. jump back to test2.
    # t0 should now equal 1011. Jump to exit
    # Program should now halt.


    # In a much better written fashion test1 => test3 => test4 => test2 => exit
    # t0 should be 1011(decimal) at program end.
    # Code immediately after jump should not execute. And program counter after jump should equal the specified label to jump.

.data
.text
    .globlmain
main:
    # Start Test 1
    j       test1
    j       failstate                   #should NOT jump here.

    # End Test


    # Exit program, load t0 with weird values.
failstate:
    addiu   $t0,        $t0,    8234
    halt    

test1:
    addiu   $t0,        $zero,  1       # Testing value, t0 should equal 1.
    j       test3
test2:
    addiu   $t0,        $t0,    10
    j       exit
test3:
    j       test4                       # Code below should be unreachable.
    addiu   $t0,        $t0,    100
test4:
    addiu   $t0,        $t0,    1000
    j       test2

exit:
    halt    
