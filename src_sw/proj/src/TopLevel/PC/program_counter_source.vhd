library IEEE;
use IEEE.std_logic_1164.all;

entity program_counter_source is
  
  port (
        i_do_branch : in std_logic;
        i_jump      : in std_logic_vector(1 downto 0);
        o_PCSrcSel  : out std_logic
  );

end program_counter_source;

architecture dataflow of program_counter_source is
  signal s_input_concat : std_logic_vector(2 downto 0);
begin
  
  s_input_concat <= i_do_branch & i_jump;
  with s_input_concat select
    o_PCSrcSel <= '0' when b"000",
                  '1' when others;

end dataflow;
