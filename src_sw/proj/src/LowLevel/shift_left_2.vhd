
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shift_left_2 is
    
    generic (INPUT_WIDTH : integer   := 26;
             RESIZE   : std_logic := '0');
    port (
        i_data             : in  std_logic_vector(INPUT_WIDTH-1 downto 0);
        o_shft_data_resize : out std_logic_vector((INPUT_WIDTH+1) downto 0);
        o_shft_data_norsze : out std_logic_vector(INPUT_WIDTH-1 downto 0)
        );
    
end shift_left_2;

architecture dataflow of shift_left_2 is
    signal s_shifted           : std_logic_vector(INPUT_WIDTH+1 downto 0);
    signal s_shifted_no_resize : std_logic_vector(INPUT_WIDTH-1 downto 0);
begin
    process (all)
    begin
        if RESIZE = '0' then
            -- Cut off the top two bits of the input and then put 0's on the LSB
            s_shifted_no_resize <= i_data(INPUT_WIDTH-3 downto 0) & "00";
            o_shft_data_norsze  <= s_shifted_no_resize;
        else
            -- Concatenate two bits on to the output
            s_shifted          <= i_data & "00";
            o_shft_data_resize <= s_shifted;
        end if;
    end process;
end dataflow;
