# src_hw

## Introduction
This is the an implementation of the hardware scheduled multicycle MIPS processor in VHDL.

## Directory Structure

Signals that help with instruction decoding/execution

Basically booleans (std_logic) if the given instruction is that instruction.

X = {i,s,o}
- X_Bne (Is BNE instruction?)
- X_Jump (Is jump instruction?)
- X_JumpOrBranch (Is branch or jump instruction?)
- X_Branch (Is branch instruction?)
