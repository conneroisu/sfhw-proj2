set target "tb_ID_EX"
set file "${target}.vhd"

vcom -2008 -work work ../src/MIPS_types.vhd
vcom -2008 -work work ../src/LowLevel/*.vhd
vcom -2008 -work work ../src/MidLevel/*.vhd
vcom -2008 -work work ../src/TopLevel/ALU/*.vhd
vcom -2008 -work work ../src/TopLevel/Pipeline/ID_EX.vhd

vcom -2008 -work work $file

vsim -voptargs=+acc -debugDB $target
add wave -position insertpoint \ ../$target/*
run 1120
