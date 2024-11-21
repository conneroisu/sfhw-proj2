# This is essentially a script file for ModelSim which loads memory and adds waves to vsim.wlf

log -r *
add wave -r -position insertpoint sim:/tb/MyMips/*
add wave -r -position insertpoint sim:/tb/P_DUMP_STATE/*

# We reccommend you add any additional signals that you want to see in your waveform below.
# Common choices are your register file and your alu. You can use the following line as a template
# add wave -position insertpoint sim:/tb/MyMips/yourcomponent/*



# Students should not modify below this point.
mem load -infile imem.hex -format hex /MyMips/IMem
mem load -infile dmem.hex -format hex /MyMips/DMem
run 10000000
quit
