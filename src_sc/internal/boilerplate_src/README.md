# src directory

### Description

This directory should contain all source code needed to build and run your
processor. You may use subdirectories as you see fit, however, be aware that
compile order is not guarenteed. The file MIPS\_types.vhd will be compiled
1st, so it is encouraged that all students declare any additional types they
may want (ie. register file array, record types for Pipeline registers,
constants, etc.) in this file.

A top level file, TopLevel/MIPS\_processor is included. Please be mindful
of signals in this processor that are required for the toolflow.

