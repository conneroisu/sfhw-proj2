.data
.text
    .globlmain
main:

    # Start Test 1: Makes sure that jr can use the $ra register after jal updates it
    # This is a common usage of jr, so it is a good base test to make sure it is working.
    # If successful, register $t0 should have a 1 in it.
    j       Test1a

Test1b:
    addiu   $t0,    $0, 1
    jr      $ra

Test1a:
    jal     Test1b
    # End Test 1


    # Exit program
    halt    