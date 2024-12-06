set target "tb_MipsProcessor"
set file "${target}.vhd"

vcom -2008 -work work ../src/MIPS_types.vhd
vcom -2008 -work work ../src/LowLevel/*.vhd
vcom -2008 -work work ../src/MidLevel/*.vhd
vcom -2008 -work work ../src/


vcom -2008 -work work $file

vsim -debugDB -voptargs=+acc $target
add wave -position insertpoint \ ../$target/*
run 3000
