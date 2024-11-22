# CPR E 381 Toolflow Manual

## 1 Overview

The enclosed toolflow implements a testing and synthesis workflow using Modelsim 
(Questasim) and Quartus Prime. Both the testing and synthesis portions are 
necessary to ensure proper completion of all phases of the CPR E 381 Course
project - a MIPS processor. This tool is divided into 2 tools: ‘test’ and 
‘synth’. The test tool optionally compiles your processor, simulates 1 or more 
assembly programs on MARS, initializes a Modelsim simulation with your 
processor, loading in a test program, and then compares the simulation results of your processor with MARS.
The synth tool synthesizes your processor for an Altera FPGA, and then
outputs a timing summary that should indicate your critical path.

## 2 Usage

`381_tf.sh`: 

This runner provides some environment setup and actually calls the test scripts. 
It may be run like
```zsh 
./381_tf.sh < new | test | synth | submit > [ options ]
```

### 2.1 Running 381 tf.sh new

The first mode for running the tool flow, new, initializes a new project in the
directory `proj/`. This directory contains several subdirectories.
• mips
– This directory will contain all of your required mips source code for
the project. Several sample programs are provided.
– Add additional MIPS test files here as needed.
• `proj/src`
    – This directory contains your processor source code. You may structure the directory however you wish, however, the base structure we provide is as follows.

    ∗ `MIPS_types.vhd`
        · This file is guaranteed to be compiled first by the toolflow
        · Place all type declarations and global constants in here
        · You may include this file in any other source
    ∗ `TopLevel/MIPS_Processor.vhd`
        · This file contains the skeleton processor. Be mindful of all the required signal names.
    ∗ `TopLevel/mem.vhd`
        · This contains a complete memory entity. This is the same module tested in Lab 2
• `proj/test`
    – Place your VHDL test benches in here.
    – Required for submission

### 2.2 Running 381 tf.sh test [options] file...

This command is what you will use the majority of the time to test your processor’s integration functionality. 
The command will compile your code, assemble one or more MIPS programs, simulate the MIPS programs on both MARS and
your processor, and then compare the output. This framework is very similar
to the one that will be used to grade the correctness of your processor.

• `--help` Prints a help message displaying these options

• `--summary #` Print a tabular output

• `--max-mismatches #` Allow # mismatches (default 30)

• `--nocompile` Don’t recompile VHDL (default compiles)

• `--sim-timeout #` Number of seconds to simulate for (Default 30)

• `--config CONFIG` Selects an alternate system configuration

Example 1: Running 1 file

```zsh 
./381_tf.sh test proj/mips/addiseq.s
```

#### Example 2: Running 1 file, no compile

```zsh
./381_tf.sh test proj/mips/*.s
```
Examples 1 and 2 run a single file, `proj/mips/addiseq.s`. 
The results of this run will be stored in the output directory.
In general, the output directory contains all the output, intermediate files,
and logs of a single run. The toolflow will create a new directory for each test.
However, after re-running a test, the old output will be thrown away.

#### Example 3: Running a directory

```zsh
./381_tf.sh test proj/mips/*
```
The test failures.txt file generated for batch runs may also be fed back into the toolflow to rerun failures.

#### Example 5: Running failures via a file

```zsh 
./381_tf.sh test @output/test_failures.txt
```

The above command can be run again and again, with each run only running
the failures, then overwriting the test failures.txt file with new failures.

### 2.3 Running `381_tf.sh synth`

Synthesis can be run via:
```zsh
./381_tf.sh synth
```

Synthesis output, such as timings files, can be found in the temp directory.
Be aware – synthesis may take several hours, particularly for Project 1.


##### Example 6: Running Synthesis

2.4
Running 381 tf.sh submit
Lastly, configure your `proj/` file structure to match the submission guidelines.
This should look like:

```txt 
proj
|---mips
|      |---file.s
|      \---file2.s
|---src
|      |---proc...
|---test
|      |---tb_1.vhd
|      \---tb_2.vhd
\---report.pdf
```

#### Example 7: Generating Project 1 submission
```zsh
./381_tf.sh submit
```
Your submission will be sanity checked, and a final zip and report PDF will
be placed in the submissions directory. Please make sure to upload both the zip
and the report PDF to Canvas.

For project 2, add the option ‘hw’ or ‘sw’ to create a submission for either
the hardware scheduled or software scheduled pipeline. Ultimately, you should
create 2 zip folders, and submit both.

#### Example 8 : Generating Project 2 Software Pipeline submission

```zsh 
./381_tf.sh submit sw
```

#### Example 9 : Generating Project 2 Hardware Pipeline submission

```zsh
./381_tf.sh submit hw
```

## B Configuration 

### B.1 Motivation

To run the toolflow on a non-lab machine, you may need to use an alternate
configuration. Configuration is handled via a file config.ini, placed in the root
of the toolflow directory. A sample of this file may be found in the internal
directory.

### B.2 Format

The file consists of one or more configurations organized into sections. Sections are denoted using brackets, “[MySectionTitle]”. Key value pairs are then
inserted underneath the section block using the form “key = value”. There
are 3 user configurable parameters - “modelsim paths”, “quartus paths”, and
“needs license”. In general, “needs license” should always be set to false unless
you are using an univerisity licensed version of quartus. The two path parameters
each accept a list of quoted *nix style paths, separated by commas and enclosed
in brackets. If multiple paths are provided, then each path will be checked in
order until a valid option is found.

#### Example 10 : Example Configuration

```ini
[ Config ]
modelsim_paths =[ "/path/to/modelsim/bin" , "/path2/to/modelsim/bin" ]
quartus_paths =[ "/path/to/quartus/bin" ]
needs_license = false
[ AnotherConfig ]
modelsim_paths =[ "/another/path/to/modelsim/bin" ]
quartus_paths =[ "/another/path/to/quartus/bin" ]
needs_license = false
```

### B.3 Using the configuration

To use a non-default configuration, you must specify to both the test and synthesis frameworks which configuration you would like to use. The name of the configuration that is passed to the toolflow must match a section in the config.ini
file.

#### Example 11 : Running with New Configurations

```zsh 
./381_tf test -- asm - file file . s -- config Config
./381_tf test -- asm - file file . s -- config AnotherConfig
./381_tf synth -- config Config
./381_tf synth -- config AnotherConfig
```
