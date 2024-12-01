set target "tb_dffg"
set file "${target}.vhd"

vcom -2008 -work work ../src/MIPS_types.vhd
vcom -2008 -work work ../src/TopLevel/Pipeline/MEM_WB.vhd
vcom -2008 -work work ../src/LowLevel/*.vhd
vcom -2008 -work work $file

vsim -debugDB -voptargs=+acc $target
add wave -position insertpoint \ ../$target/*
run 1120
