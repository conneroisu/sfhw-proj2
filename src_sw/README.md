# Software Pipelined MIPS Processor

## Introduction

This directory contains the software pipelined MIPS processor implementation.

![diagram](DIAGRAM.png)

## Directory Structure

```bash
.
├── 381_tf.sh
├── DIAGRAM.png
├── Makefile
├── README.md
├── internal (toolflow dependencies)
│   └── version.txt
├── proj
│   ├── mips (assembly files)
│   ├── src  (VHDL files)
│   │   ├── LowLevel (Low-level VHDL files)
│   │   │   ├── andg2.vhd
│   │   │   ├── andg32.vhd
│   │   │   ├── comp1_N.vhd
│   │   │   ├── decoder_5t32.vhd
│   │   │   ├── dffg.vhd
│   │   │   ├── dffg_n.vhd
│   │   │   ├── extender16t32.vhd
│   │   │   ├── full_adder.vhd
│   │   │   ├── full_adder_N.vhd
│   │   │   ├── inverter_N.vhd
│   │   │   ├── invg.vhd
│   │   │   ├── logic_N.vhd
│   │   │   ├── mux2t1.vhd
│   │   │   ├── mux2t1_N.vhd
│   │   │   ├── mux32t1.vhd
│   │   │   ├── mux32t1_N.vhd
│   │   │   ├── mux4t1.vhd
│   │   │   ├── mux4t1_N.vhd
│   │   │   ├── mux8t1.vhd
│   │   │   ├── mux8t1_N.vhd
│   │   │   ├── nandg32.vhd
│   │   │   ├── norg32.vhd
│   │   │   ├── org2.vhd
│   │   │   ├── org32.vhd
│   │   │   ├── xorg2.vhd
│   │   │   └── xorg32.vhd
│   │   ├── MIPS_types.vhd (types for MIPS processor)
│   │   ├── MidLevel (VHDL files for the middle level)
│   │   │   ├── ALU.vhd
│   │   │   ├── AdderSubtractor.vhd
│   │   │   ├── BarrelShifter.vhd
│   │   │   ├── ControlUnit.vhd
│   │   │   ├── Pipeline_EX_MEM.vhd
│   │   │   ├── Pipeline_ID_EX.vhd
│   │   │   ├── Pipeline_IF_ID.vhd
│   │   │   ├── Pipeline_MEM_WB.vhd
│   │   │   ├── RegisterFile.vhd
│   │   │   └── ZeroDetector.vhd
│   │   └── TopLevel (VHDL files for the top level)
│   │       ├── MIPS_Processor.vhd
│   │       └── mem.vhd
│   └── test (testbench files)
│       ├── tb_ALU.do
│       ├── tb_ALU.vhd
│       ├── tb_BarrelShifter.do
│       ├── tb_BarrelShifter.vhd
│       ├── tb_BranchUnit.do
│       ├── tb_BranchUnit.vhd
│       ├── tb_ForwardUnit.do
│       ├── tb_ForwardUnit.vhd
│       ├── tb_FullHardware.vhd
│       ├── tb_dffg.do
│       ├── tb_dffg.vhd
│       ├── tb_logic_N.do
│       ├── tb_logic_N.vhd
│       ├── tb_register_file.do
│       └── tb_register_file.vhd
└── temp (synthesis outputs)
    ├── synth_error.log
    ├── timing.txt
    └── timing_dump.txt
```


