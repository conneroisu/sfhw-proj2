.data

.text

    .globlmain

main:
    # start test
    jal     test


test:
    addi    $t1,    $0, 25  # testing basic functionaly of jumpting to correct section and loading $ra
    halt                    # end program