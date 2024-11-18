set target "tb_Execute"
set file "${target}.vhd"

vcom -2008 -work work ../src/MIPS_types.vhd
vcom -2008 -work work ../src/TopLevel/low_level/*.vhd

vcom -2008 -work work ../src/TopLevel/barrel_shifter/*.vhd

vcom -2008 -work work ../src/TopLevel/alu/*.vhd
vcom -2008 -work work $file

vsim -voptargs=+acc $target
add wave -position insertpoint \ ../$target/*
run 1120
