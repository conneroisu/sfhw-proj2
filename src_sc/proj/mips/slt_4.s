.data
.text
    .globlmain
main:
    #test for set less than
    #common case, maybe its used for a branch condition in a loop or something
    #ensure that a normal positive int behaves as expected

    #will use $s0 to hold output of SLT cause why not
    lui     $t0,    10
    slt     $s0,    $t0,    $zero   #expect false

    #included syscalls, remove the comments if you want to use them. IDK if they're necessary
    #add $v0, $s0, $zero
    #syscall

    #check that flipping the values causes the opposite effect, unless the values are equal ofc
    slt     $s0,    $zero,  $t0     #expect true

    #add $v0, $s0, $zero
    #syscall

    # End Test

    # Exit program
    halt    
