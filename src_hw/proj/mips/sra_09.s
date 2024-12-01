.data

.text

    .globlmain

    #Tests basic functionality of sra

main:

    #Start Test

    #Check to make sure can sra and put back into same register

    sra     $1,     $1,     2   # verify that one can shift reg 1 2 bits right

    sra     $4,     $4,     2   # verify that one can shift reg 4 2 bits right

    sra     $7,     $7,     2   # verify that one can shift reg 7 2 bits right

    sra     $10,    $10,    2   # verify that one can shift reg 10 2 bits right

    sra     $14,    $14,    2   # verify that one can shift reg 14 2 bits right

    #Check to make sure can sra and put back into different register

    sra     $12,    $11,    2   # reg 11 Shift Right 2bits ->12

    sra     $13,    $15,    2   # reg 15 Shift Right 2bits->13

    sra     $25,    $24,    2   # reg 24 Shift Right 2bits->25

    sra     $20,    $23,    2   # reg 23 Shift Right 2bits->20


    #End Test

    # Exit Program

    halt    

