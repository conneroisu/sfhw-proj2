set target "tb_instruction_decoder"
set file "${target}.vhd"

vcom -2008 -work work ../src/MIPS_types.vhd
vcom -2008 -work work ../src/MidLevel/instruction_decoder.vhd
vcom -2008 -work work $file

vsim -debugDB -voptargs=+acc $target
add wave -position insertpoint \ ../$target/*
run 1120
