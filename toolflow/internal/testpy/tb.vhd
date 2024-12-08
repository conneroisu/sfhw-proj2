-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T12:19:14-06:00 moved-all-files-into-the-hardware-directory
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;          -- For logic types I/O
library std;
use std.env.all;                        -- For hierarchical/external signals
use std.textio.all;                     -- For basic I/O
entity tb is
--Generic for half of the clock cycle period
    generic(gCLK_HPER    : time    := 10 ns;
            N            : integer := 32;
            OUTPUT_TRACE : string  := "dump.txt");
end tb;
architecture mixed of tb is
--Define the total clock period time
    constant cCLK_PER : time := gCLK_HPER * 2;
--We will be making an instance of the file that we are testing
--The appropriate port declarations for your processor component MIPS_processor are
    component MIPS_processor is
        generic (N : integer);
        port(iCLK      : in  std_logic;
             iRST      : in  std_logic;
             iInstLd   : in  std_logic;
             iInstAddr : in  std_logic_vector(N-1 downto 0);
             iInstExt  : in  std_logic_vector(N-1 downto 0);
             oALUOut   : out std_logic_vector(N-1 downto 0));
    end component;
-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
    signal CLK, reset : std_logic := '0';
    signal reset_done : std_logic := '0';
    signal alu_out    : std_logic_vector(N-1 downto 0);
begin
-- Make an instance of the component to test and wire all signals to the corresponding
-- input or output.
    MyMips : MIPS_processor
        generic map(N => N)
        port map(
            iCLK      => CLK,
            iRST      => reset,
            iInstLd   => '0',
            iInstAddr => "--------------------------------",
            iInstExt  => "--------------------------------",
            oALUOut   => alu_out);
    --You can also do the above port map in one line using the below format: http://www.ics.uci.edu/~jmoorkan/vhdlref/compinst.html
    --port map(CLK, reset, rs_sel, rt_sel, reg_we, w_addr, reg_dest, immediate, sel_imm, ALU_OP, shamt, mem_we, rs_data, rt_data, ALU_out, dmem_out);
    --This first process is to automate the clock for the test bench
    P_CLK : process
    begin
        CLK <= '1';
        wait for gCLK_HPER;
        CLK <= '0';
        wait for gCLK_HPER;
    end process;
    -- This process resets the processor.
    P_RST : process
    begin
        reset      <= '0';
        wait for gCLK_HPER/2;
        reset      <= '1';
        wait for gCLK_HPER*2;
        reset      <= '0';
        reset_done <= '1';
        wait;
    end process;
    -- Dumps modifications to the state of the processor to trace file
    P_DUMP_STATE : process (CLK)
        file my_dump                                    : text open write_mode is OUTPUT_TRACE;
        variable my_line                                : line;
        variable cycle_cnt                              : integer := 0;
        -- Setup hierarchical/external names
        -- Reference for external names: https://www.doulos.com/knowhow/vhdl_designers_guide/vhdl_2008/vhdl_200x_ease/#hierarchicalnames
        alias memWr is << signal MyMips.s_DMemWr        : std_logic >>;
        alias memAddr is << signal MyMips.s_DMemAddr    : std_logic_vector(N-1 downto 0) >>;
        alias memData is << signal MyMips.s_DMemData    : std_logic_vector(N-1 downto 0) >>;
        alias regWr is << signal MyMips.s_RegWr         : std_logic >>;
        alias regWrAddr is << signal MyMips.s_RegWrAddr : std_logic_vector(4 downto 0) >>;
        alias regWrData is << signal MyMips.s_RegWrData : std_logic_vector(N-1 downto 0) >>;
        alias halt is << signal MyMips.s_Halt           : std_logic >>;
        alias ovfl is << signal MyMips.s_Ovfl           : std_logic >>;
    begin
        if (rising_edge(CLK) and (reset_done = '1')) then
            if (regWr) then
                write(my_line, string'("In clock cycle: "));
                write(my_line, cycle_cnt);
                writeline(my_dump, my_line);
                write(my_line, string'("Register Write to Reg: 0x"));
                hwrite(my_line, regWrAddr);
                write(my_line, string'(" Val: 0x"));
                hwrite(my_line, regWrData);
                writeline(my_dump, my_line);
            end if;
            if (memWr) then
                write(my_line, string'("In clock cycle: "));
                write(my_line, cycle_cnt);
                writeline(my_dump, my_line);
                write(my_line, string'("Memory Write to Addr: 0x"));
                hwrite(my_line, memAddr);
                write(my_line, string'(" Val: 0x"));
                hwrite(my_line, memData);
                writeline(my_dump, my_line);
            end if;
            if (ovfl = '1') then
                write(my_line, string'("Arithmetic Overflow Detected"));
                writeline(my_dump, my_line);
            end if;
            if (halt = '1') then
                write(my_line, string'("Execution is stopping! Clock Cycle: "));
                write(my_line, cycle_cnt);
                writeline(my_dump, my_line);
                file_close(my_dump);
                stop(2);
            end if;
            cycle_cnt := cycle_cnt + 1;
        end if;
    end process;
end mixed;

