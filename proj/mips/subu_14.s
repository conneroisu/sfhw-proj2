.data
.text
    .globlmain
main:

    # Test case 3: Underflows
    # Initialize values
    or      $t0,    $0,     $0
    ori     $t1,    $0,     0x100

    subu    $t2,    $t0,    $t1     # 0 - 256
    # Expected: $t2 is -128 (0xffffff80)

    # Subtract larger value from smaller nonzero value
    ori     $t0,    $0,     4000
    ori     $t1,    $0,     5000

    subu    $t2,    $t0,    $t1     # 4000 - 5000
    # Expected: $t2 is -1000 (0xfffffc18)

    halt    
