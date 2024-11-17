.data
.text
    .globlmain
main:
    # Start Test
    #This tests that the shift works in each register (besides the $zero register), and each register should be shifted down 1 bit from the one above it.
    lui     $1,     0x8000      #Startng value in $1 is 0x80000000
    srl     $2,     $1,     1   #Value will be 0x40000000
    srl     $3,     $1,     2   #Value will be 0x20000000
    srl     $4,     $1,     3   #Value will be 0x10000000
    srl     $5,     $1,     4   #Value will be 0x08000000
    srl     $6,     $1,     5   #Value will be 0x04000000
    srl     $7,     $1,     6   #Value will be 0x02000000
    srl     $8,     $1,     7   #Value will be 0x01000000
    srl     $9,     $1,     8   #Value will be 0x00800000
    srl     $10,    $1,     9   #Value will be 0x00400000
    srl     $11,    $1,     10  #Value will be 0x00200000
    srl     $12,    $1,     11  #Value will be 0x00100000
    srl     $13,    $1,     12  #Value will be 0x00080000
    srl     $14,    $1,     13  #Value will be 0x00040000
    srl     $15,    $1,     14  #Value will be 0x00020000
    srl     $16,    $1,     15  #Value will be 0x00010000
    srl     $17,    $1,     16  #Value will be 0x00008000
    srl     $18,    $1,     17  #Value will be 0x00004000
    srl     $19,    $1,     18  #Value will be 0x00002000
    srl     $20,    $1,     19  #Value will be 0x00001000
    srl     $21,    $1,     20  #Value will be 0x00000800
    srl     $22,    $1,     21  #Value will be 0x00000400
    srl     $23,    $1,     22  #Value will be 0x00000200
    srl     $24,    $1,     23  #Value will be 0x00000100
    srl     $25,    $1,     24  #Value will be 0x00000080
    srl     $26,    $1,     25  #Value will be 0x00000040
    srl     $27,    $1,     26  #Value will be 0x00000020
    srl     $28,    $1,     27  #Value will be 0x00000010
    srl     $29,    $1,     28  #Value will be 0x00000008
    srl     $30,    $1,     29  #Value will be 0x00000004
    srl     $31,    $1,     30  #Value will be 0x00000002
    srl     $0,     $1,     31  #Value will be 0x00000000 (Hardcoded to be 0)
    # End Test

    # Exit program
    halt    
