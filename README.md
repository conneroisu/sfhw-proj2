> ### Report 2: https://docs.google.com/document/d/10988V4THck_VjlVM9gS4_aE0piDJ1uK7xjHn-jshYB0/edit?usp=sharing
>
> ### Report 3: https://docs.google.com/document/d/1hJhPtRldxlXI_4oFnUUbPWrZCSYvQJh55qMWHaacnJQ/edit?usp=sharing
>
> ### Spreadsheet: https://docs.google.com/spreadsheets/d/1RUNOOiJ3DZ2heZ5_la7ENw52pGrtweVW7ax-dkXzsRU/edit?usp=sharing
>
> ### WhenToMeet: https://www.when2meet.com/?27331718-g3Ah7
>
> ### Discord: https://discord.gg/JrZtEWpW
# sfhw-proj2

## Introduction

This project aims to implement a MIPS processor using different scheduling techniques. The project is divided into three main parts: hardware scheduled multicycle MIPS processor, single cycle MIPS processor, and software scheduled pipelined multi-cycle MIPS processor. Each part is implemented in a separate directory with its own set of source files and documentation.

## Project Goals

The main goals of this project are:
1. To understand and implement different scheduling techniques for MIPS processors.
2. To compare the performance and complexity of hardware scheduled, single cycle, and software scheduled pipelined multi-cycle MIPS processors.
3. To provide a comprehensive documentation and testbench for each implementation.

## Directory Structure

```bash
.
├── LICENSE
├── README.md
├── README.png
├── src_sc (the source code of the single cycle implementation)
│   ├── LICENSE
│   ├── README.md
│   ├── README.png
├── src_sf (the source code of the software scheduled pipelined multi-cycle implementation)
│   ├── LICENSE
│   ├── README.md
│   ├── README.png
└── src_hw (the source code of the hardware scheduled pipelined multi-cycle implementation)
    ├── LICENSE
    ├── README.md
    └── README.png
```

## Key Features and Functionalities

### Hardware Scheduled Multicycle MIPS Processor
The hardware scheduled multicycle MIPS processor is implemented in the `src_hw` directory. It uses VHDL to describe the hardware components and their interactions. The processor is designed to execute instructions in multiple cycles, with each cycle performing a specific task such as instruction fetch, decode, execute, memory access, and write-back.

### Single Cycle MIPS Processor
The single cycle MIPS processor is implemented in the `src_sc` directory. It also uses VHDL to describe the hardware components. Unlike the multicycle processor, the single cycle processor executes each instruction in a single clock cycle. This simplifies the control logic but may result in lower performance due to the longer critical path.

### Software Scheduled Pipelined Multi-Cycle MIPS Processor
The software scheduled pipelined multi-cycle MIPS processor is implemented in the `src_sf` directory. This implementation uses software techniques to schedule instructions and manage pipeline hazards. The processor is designed to execute multiple instructions simultaneously, with each instruction at a different stage of the pipeline.

## Provided Links

The following links are provided for additional resources and collaboration:
- [Report 2](https://docs.google.com/document/d/10988V4THck_VjlVM9gS4_aE0piDJ1uK7xjHn-jshYB0/edit?usp=sharing)
- [Report 3](https://docs.google.com/document/d/1hJhPtRldxlXI_4oFnUUbPWrZCSYvQJh55qMWHaacnJQ/edit?usp=sharing)
- [Spreadsheet](https://docs.google.com/spreadsheets/d/1RUNOOiJ3DZ2heZ5_la7ENw52pGrtweVW7ax-dkXzsRU/edit?usp=sharing)
- [WhenToMeet](https://www.when2meet.com/?27331718-g3Ah7)
- [Discord](https://discord.gg/JrZtEWpW)
