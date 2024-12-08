.data
.text
    .globlmain
main:
    # Checks general functionality of slti

    # Start Test
    addi    $2, $0, 5
    addi    $3, $0, -5

    slti    $1, $0, -5  # 0 < -5         (shows general test case of zero less than a negative number)
    slti    $1, $0, 5   # 0 < 5          (shows general test case of zero less than a positive number)

    slti    $1, $2, 0   # 5 < 0          (shows general test case of a positive number less than zero)
    slti    $1, $3, 0   # -5 < 0         (shows general test case of a negative number less than zero)

    slti    $1, $2, -5  # 5 < -5         (shows general test case of a positive number less than a negative number)
    slti    $1, $3, 5   # -5 < 5         (shows general test case of a negative number less than a positive number)
    # End Test

    # Exit program
    halt    
