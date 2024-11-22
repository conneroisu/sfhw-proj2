    #test calling jal multiple times

    #addi pc, $0, x1000000 TAEDIT

    jal     second

second:
    #store the first value of $ra
    add     $t0,    $ra,    $0
    jal     exit

exit:
    #store the second value of $ra
    add     $t1,    $ra,    $0
    halt    

    # Why am I including this test
    # I am including this test to ensure that calling multiple jals in a row, will overwrite the $ra from the first jal with
    # the pc + 4 of the second jal
    #why does the text have value
    #this test has value, becasue it ensures that you can use recursive statements, and that each time you call jal you
    #overwrite $ra
