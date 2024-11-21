-- <header>
-- Author(s): Conner Ohnesorge
-- Name: src_sw/proj/src/LowLevel/muxNtM.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-21T09:00:59-06:00 added-start-of-sf-pipeline-folder
-- </header>

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.all;
use IEEE.NUMERIC_STD.all;

entity muxNtM is
    generic (
        DATA_WIDTH  : positive := 8;    -- Width of each input/output
        INPUT_COUNT : positive := 4     -- Number of inputs
        );
    port (
        inputs : in  std_logic_vector(INPUT_COUNT * DATA_WIDTH - 1 downto 0);
        sel    : in  std_logic_vector(integer(ceil(log2(real(INPUT_COUNT)))) - 1 downto 0);
        output : out std_logic_vector(DATA_WIDTH - 1 downto 0)
        );
end muxNtM;

architecture Behavioral of muxNtM is
    constant SEL_WIDTH : integer := integer(ceil(log2(real(INPUT_COUNT))));

    -- Function to check if vector contains any metavalues
    function has_metavalue(vec : std_logic_vector) return boolean is
    begin
        for i in vec'range loop
            if vec(i) /= '0' and vec(i) /= '1' then
                return true;
            end if;
        end loop;
        return false;
    end function;
begin
    process(inputs, sel)
        variable sel_int : integer;
    begin
        -- Check for metavalues in select lines
        if has_metavalue(sel) then
            -- If select has metavalues, propagate 'X' to outputs
            output <= (others => 'X');
        else
            -- Convert select lines to integer
            sel_int := to_integer(unsigned(sel));

            -- Check if selection is valid
            if sel_int < INPUT_COUNT then
                -- Extract the selected input from the input array
                output <= inputs((sel_int + 1) * DATA_WIDTH - 1 downto sel_int * DATA_WIDTH);
            else
                -- Invalid selection
                output <= (others => '0');
            end if;
        end if;
    end process;
end Behavioral;

