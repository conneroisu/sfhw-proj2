set target "tb_dffg_n"
set file "${target}.vhd"

#This line should be in every .do file!
vcom -2008 -work work ../src/MIPS_types.vhd

vcom -2008 -work work ../src/**/*.vhd

vcom -2008 -work work $file

vsim -voptargs=+acc $target
add wave -position insertpoint \ ../$target/*
run 1700
