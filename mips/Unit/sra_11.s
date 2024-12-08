.data

.text

    .globlmain

    #Tests sra with shift amount equal to 0

main:

    #Start Test

    #Check to make sure can sra shift 31 and put back into same register

    sra     $1,     $1,     0   # verify that one can shift reg 1 0 bits right

    sra     $4,     $4,     0   # verify that one can shift reg 4 0 bits right

    sra     $7,     $7,     0   # verify that one can shift reg 7 0 bits right

    sra     $10,    $10,    0   # verify that one can shift reg 10 0 bits right

    sra     $14,    $14,    0   # verify that one can shift reg 14 0 bits right

    #Check to make sure can sra shfit 31 and put back into different register

    sra     $12,    $11,    0   # reg 11 Shift Right 0 bits ->12

    sra     $13,    $15,    0   # reg 15 Shift Right 0 bits->13

    sra     $25,    $24,    0   # reg 24 Shift Right 0 bits->25

    sra     $20,    $23,    0   # reg 23 Shift Right 0 bits->20


    #End Test

    # Exit Program

    halt    