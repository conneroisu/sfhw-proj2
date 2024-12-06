.data
.text
    .globlmain
main:

    # Start Test 2: Makes sure that jr can use any register type given to set the program counter
    # This test is less common because usually you are not writing a program counter value yourself, but it will
    # prove that jr writes a program counter value and takes you there.
    lui     $t0,    0x0040
    addiu   $t0,    $t0,    0x0024  #address of next jr
    lui     $a0,    0x0040
    addiu   $a0,    $a0,    0x0028  #address of next jr
    lui     $s0,    0x0040
    addiu   $s0,    $s0,    0x002c  #address of next jr
    lui     $ra,    0x0040
    addiu   $ra,    $ra,    0x0030  #address of next jr

    jr      $t0
    jr      $a0
    jr      $s0
    jr      $ra
    # End Test 2

    # Exit program
    halt    