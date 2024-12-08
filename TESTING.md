# Testing

## Project Structure

### Introduction 
Components of the processors are organized into directories:

- `LowLevel/`: The low level components of the project. (e.g. `LowLevel/*.vhd)
- `MidLevel/`:  The mid level components of the project. (e.g. `MidLevel/*.vhd)
- `HighLevel/`: The high level components of the project. (e.g. `HighLevel/*.vhd and HighLevel/**/*.vhd)

Testing is done in the `test/` directory of each processor. 

Each test for a component has a do file that depends on the hierarchy of the component.

### Templates

#### Low Level

```do
# TODO: Replace {component_name} with the name of the component
set target "tb_{component_name}"
set file "${target}.vhd"

vcom -2008 -work work ../src/MIPS_types.vhd
vcom -2008 -work work ../src/LowLevel/*.vhd
vcom -2008 -work work $file

vsim -voptargs=+acc $target
add wave -position insertpoint \ ../$target/*
run 1120
```

#### Mid Level

```do
# TODO: Replace {component_name} with the name of the component
set target "tb_{component_name}"
set file "${target}.vhd"

vcom -2008 -work work ../src/MIPS_types.vhd
vcom -2008 -work work ../src/LowLevel/*.vhd
vcom -2008 -work work ../src/MidLevel/*.vhd
vcom -2008 -work work $file

vsim -voptargs=+acc $target
add wave -position insertpoint \ ../$target/*
run 1120
```

#### High Level

```do
# TODO: Replace {component_name} with the name of the component
set target "tb_{component_name}"
set file "${target}.vhd"

vcom -2008 -work work ../src/MIPS_types.vhd
vcom -2008 -work work ../src/LowLevel/*.vhd
vcom -2008 -work work ../src/MidLevel/*.vhd
vcom -2008 -work work ../src/HighLevel/*.vhd
vcom -2008 -work work $file

vsim -voptargs=+acc $target
add wave -position insertpoint \ ../$target/*
run 1120
```

## Running Tests

To run tests, run the following command from the `test/` directory of the processor:

```bash
./381_tf.sh test {path to assembly test file}
```
