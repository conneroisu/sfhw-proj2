.data

.text

    .globlmain

    #Tests sra with maximum shift amount (31)

main:

    #Start Test

    #Check to make sure can sra shift 31 and put back into same register

    sra     $1,     $1,     31  # verify that one can shift reg 1 31 bits right

    sra     $4,     $4,     31  # verify that one can shift reg 4 31 bits right

    sra     $7,     $7,     31  # verify that one can shift reg 7 31 bits right

    sra     $10,    $10,    31  # verify that one can shift reg 10 31 bits right

    sra     $14,    $14,    31  # verify that one can shift reg 14 31 bits right

    #Check to make sure can sra shfit 31 and put back into different register

    sra     $12,    $11,    31  # reg 11 Shift Right 31bits ->12

    sra     $13,    $15,    31  # reg 15 Shift Right 31bits->13

    sra     $25,    $24,    31  # reg 24 Shift Right 31bits->25

    sra     $20,    $23,    31  # reg 23 Shift Right 31bits->20


    #End Test

    # Exit Program

    halt    