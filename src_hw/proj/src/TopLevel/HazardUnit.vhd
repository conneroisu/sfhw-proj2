-- <header>
-- Author(s): Conner Ohnesorge
-- Name: proj/src/TopLevel/HazardUnit.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-21T10:20:49-06:00 added-HazardUnit-and-Updated-testbench-for-the-Units-Execute
-- </header>

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity HazardUnit is
    port (
        i_IFID_rs            : in  std_logic_vector(4 downto 0);
        i_IFID_rt            : in  std_logic_vector(4 downto 0);
        i_IFID_RegWr         : in  std_logic_vector(4 downto 0);
        i_IDEX_rd            : in  std_logic_vector(4 downto 0);
        i_IDEX_rt            : in  std_logic_vector(4 downto 0);
        i_EXMEM_rd           : in  std_logic_vector(4 downto 0);
        i_IDEX_RegWr         : in  std_logic;
        i_EXMEM_RegWr        : in  std_logic;
        i_MEMWB_branch_taken : in  std_logic;
        o_IDEX_data_stall    : out std_logic;
        o_IFID_squash        : out std_logic;
        o_IDEX_squash        : out std_logic;
        o_EXMEM_squash       : out std_logic;
        o_PC_pause           : out std_logic
        );
end HazardUnit;

architecture mixed of HazardUnit is
begin

    --Conditions that trigger data hazard avoidance
    o_IDEX_data_stall <= '1' when (
        i_EXMEM_rd /= b"00000" and  -- Detect Load Instr - Unlike an ALU instruction whose calculated value is known and can be forwarded, a load instruction must get data from memory. No forwarding can speed up that data access. 
        (i_IDEX_rt = i_IFID_rs  -- next instruction's first read operand is the register being written by load, a stall is needed
         or i_IDEX_rt = i_IFID_rt)  -- next instruction's second read operand is the register being written by load, a stall is needed.
        and i_EXMEM_RegWr /= '0')
                         else '0';

    o_PC_pause <= '1' when (i_EXMEM_rd /= b"00000"  -- Detect Load Instr - Unlike an ALU instruction whose calculated value is known and can be forwarded, a load instruction must get data from memory. No forwarding can speed up that data access. 
                            and ((i_IFID_rs = i_EXMEM_rd) or (i_IFID_rt = i_EXMEM_rd))
                            and i_EXMEM_RegWr /= '0'
                            and i_IDEX_RegWr /= '0')
                  else '0';

    -- Conditions that trigger control hazard avoidance
    -- If we are detecting the branch in the writeback stage, we will need to squash IFID/IDEX/EXMEM
    -- We will also need the branchCtl signal from the writeback stage to tell us if we have a control flow instruction about to go through the pipeline.
    -- Since the instruction is in the writeback stage, the next rising edge will upadte the PC with the correct value and then all preceding instructions in pipeline will be squashed
    o_IFID_squash  <= '1' when i_MEMWB_branch_taken = '1' else '0';
    o_IDEX_squash  <= o_IFID_squash;
    o_EXMEM_squash <= o_IFID_squash;
end architecture;

