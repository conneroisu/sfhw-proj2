# This test program validates all required instructions for the single-cycle processor
.data
    test_val: .word 15    # Test value for memory operations

.text
# Memory and immediate load operations
# Testing lui, lasw (pseudo-instruction), and lw
lui $12, 0x1234          # Load upper immediate to set up base address
lasw $10, test_val       # Load address of test_val (breaks into lui and ori)
nop                      # Prevent data hazard
lw $11, 0($10)          # Load value 15 from memory into $11
nop                      # Prevent data hazard

# Logical operations testing block
# Testing all bitwise operations with both register and immediate variants
lui $8, 0x0FFF          # Load test value 1
lui $9, 0x0FF0          # Load test value 2
nop                      # Prevent data hazard
nop
xor $14, $8, $9         # Test XOR between registers
or $15, $8, $9          # Test OR between registers
and $16, $8, $9         # Test AND between registers
nor $17, $8, $9         # Test NOR between registers
xori $18, $8, 0x0FF0    # Test immediate XOR
ori $19, $8, 0x0FF0     # Test immediate OR
andi $20, $9, 0x2F0     # Test immediate AND

# Arithmetic operations testing block
# Testing all add and subtract variants
addi $21, $0, 0x123     # Test immediate add
addiu $22, $21, 0x7F    # Test immediate add unsigned (no overflow)
nop                     # Prevent data hazard
addu $23, $21, $22      # Test add unsigned between registers
nop                     # Prevent data hazard
sub $24, $23, $21       # Test subtract
subu $25, $24, $24      # Test subtract unsigned (should result in 0)

# Shift operations testing block
# Testing all shift types (logical and arithmetic)
sll $8, $8, 3          # Test shift left logical
nop                    # Prevent data hazard
nop
srl $8, $8, 2          # Test shift right logical
nop
lui $8, 0x8FFF         # Load negative number for arithmetic shift
nop
sra $8, $8, 5          # Test shift right arithmetic (sign extension)
nop
sw $8, 4($10)          # Store shift result to memory

# Set less than testing block
slt $26, $8, $9        # Test set less than between registers
slti $27, $8, 0x1FFF   # Test set less than immediate

# Branch instructions testing block
# Testing all equality and inequality branches
lui $1, 0x0020         # Load identical values for branch testing
lui $2, 0x0020
nop
nop
nop
beq $1, $2, equal_branch    # Should branch (values are equal)
nop
nop
addi $3, $3, 0x1111        # Should not execute
equal_branch:
bne $1, $2, not_equal      # Should not branch (values are equal)
nop
nop
nop

# Zero comparison branch testing block
bgez $0, gez_branch        # Should branch ($0 ≥ 0)
nop
nop
addi $3, $3, 0x2222        # Should not execute
gez_branch:
bgtz $1, gtz_branch        # Should branch ($1 > 0)
nop
nop
addi $3, $3, 0x3333        # Should not execute
gtz_branch:
blez $0, lez_branch        # Should branch ($0 ≤ 0)
nop
nop
addi $3, $3, 0x4444        # Should not execute
lez_branch:

# Negative number branch testing
lui $4, 0x8FFF             # Load negative number
nop
nop
bltz $4, ltz_branch        # Should branch ($4 < 0)
nop
nop
addi $3, $3, 0x5555        # Should not execute
ltz_branch:

# Jump instructions testing block
j jump_target              # Test direct jump
nop
nop
addi $3, $3, 0x6666        # Should not execute
jump_target:

# Jump and link testing block
jal jal_target            # Test jump and link
nop
nop
addi $3, $3, 0x7777       # Should not execute
jal_target:
addu $28, $0, $31         # Save return address to verify jal worked

# Branch and link testing block
bgezal $0, gezal_target   # Test branch greater/equal zero and link
nop
nop
bltzal $4, ltzal_target   # Test branch less than zero and link
nop
nop
halt                      # End program execution

# Return targets for branches and jumps
not_equal:
gezal_target:
ltzal_target:
jr $31                    # Return from subroutine
nop
nop
nop
