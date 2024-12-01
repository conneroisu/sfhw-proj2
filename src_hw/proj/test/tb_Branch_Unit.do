set target "tb_Branch_Unit"
set file "${target}.vhd"

vcom -2008 -work work ../src/MIPS_types.vhd
vcom -2008 -work work ../src/LowLevel/*.vhd
vcom -2008 -work work $file

vsim -voptargs=+acc $target
add wave -position insertpoint \ ../$target/*
run 1120
