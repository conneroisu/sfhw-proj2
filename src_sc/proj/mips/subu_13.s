.data
.text
    .globlmain
main:

    # Test case 1: Edge case: Subtracting unsigned integer from zero register

    # initialize values
    ori     $t0,    $t0,    1

    subu    $t1,    $0,     $t0 # 0 - 11
    # Expected: $t1 is -1

    halt    
