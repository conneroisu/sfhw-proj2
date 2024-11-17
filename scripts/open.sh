#!/bin/bash
export PATH=$PATH:/usr/local/mentor/questasim/bin
export SALT_LICENSE_SERVER=$SALT_LICENSE_SERVER:1717@io.ece.iastate.edu
/usr/local/mentor/questasim/bin/vsim -do ./proj/test/tb_muxNtM.do
