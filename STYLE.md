# Style Guide

## Naming Conventions

### File Names

- All files should be named with the following format: `<module_name>.vhd`
- All files should be CamelCase with spaces replaced with underscores.
- All diagram level module files should be in the `src/TopLevel` directory

### Signal Names

- All signals should be named with the following format: `s_<signal_name>`
- All signals should be lowercase
- All signals should be in the `src/TopLevel` directory

### Constant Names

- All constants should be named with the following format: `<constant_name>`
- All constants should be uppercase.
- All constants should be in the `src/MIPS_types.vhd` directory.

### Port Names

- All input ports should be named with the following format: `i_<port_name>`
- All output ports should be named with the following format: `o_<port_name>`
- All ports should be CamelCase with spaces replaced with underscores.

## Designing with VHDL

Making the port declarations of a component with a new line above and below the port declarations is a good practice as it allows for the easy copying of the ports with vim and text-editors into test files and instatiations in other components.

Example:

```vhdl
component my_component is

    port (
        i_CLK        : in  std_logic;
        i_RST        : in  std_logic;
        i_WE         : in  std_logic;
        i_PC         : in  std_logic_vector(N-1 downto 0);
        -- Control Signals (From Control Unit) [begin]
        --= Stage Specific Signals [begin]
        --         RegDst  ALUOp  ALUSrc
        -- R-Type:   1      10      00
        -- lw    :   0      00      01
        -- sw    :   x      00      01
        -- beq   :   x      01      00
        i_RegDst     : in  std_logic;   -- Control Unit Destination Register
        i_ALUOp      : in  std_logic_vector(2 downto 0);  -- ALU operation from control unit.
        i_ALUSrc     : in  std_logic_vector(1 downto 0);  -- ALU source from control unit.
        i_MemRead    : in  std_logic;   -- Memory Read control
        i_MemWrite   : in  std_logic;   -- Memory Write control
        i_MemtoReg   : in  std_logic;   -- Memory to Register control
        i_RegWrite   : in  std_logic;   -- Register Write control
        i_Branch     : in  std_logic   -- Branch control
    );

end component;
```
