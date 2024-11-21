.data
.text

    # Start Test
    # This test is zero test
#       
    # The goal of this very simple test is to ensure that when attempting to add the the zero register, the zero register is unchaged
#       
addi    $8, $8, 1   #$t0 = 1
add     $0, $8, $8  #$0 = $t0 + $t0 ($0 = 1 + 1) This should do nothing to $0
add     $9, $0, $0  #$t1 = $0, $0 -- Verify that the result of this into $t1 is 0, because the zero register should not have been changed
    # End Test

    # Exit program
halt    
