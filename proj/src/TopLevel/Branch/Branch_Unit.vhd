library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use work.MIPS_types.all;

entity Branch_Unit is
    port (
        i_clk   : in  std_logic;
        i_rst   : in  std_logic;
        i_flush : in  std_logic;
        i_stall : in  std_logic;
        i_sctrl : in  std_logic;  --sign control signal
        o_regw  : out std_logic;  --register write signal
        i_addr  : in  std_logic_vector(31 downto 0);
        i_instr : in  std_logic_vector(31 downto 0);
        o_instr : out std_logic_vector(31 downto 0);
        o_addr  : out std_logic_vector(31 downto 0);
        o_d1    : out std_logic_vector(31 downto 0);
        o_d2    : out std_logic_vector(31 downto 0);
        o_sign  : out std_logic_vector(31 downto 0);
        o_branch_ctrl : out std_logic_vector(5 downto 0);
        o_branch_addr : out std_logic_vector(31 downto 0);
        o_branch_taken : out std_logic
        );
end entity Branch_Unit;

architecture structural of Branch_Unit is
    begin

end architecture structural;
