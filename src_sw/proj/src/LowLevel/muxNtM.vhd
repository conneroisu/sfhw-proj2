-- <header>
-- Author(s): Kariniux, aidanfoss, Conner Ohnesorge
-- Name: proj/src/LowLevel/muxNtM.vhd
-- Notes:
--      Kariniux 2024-11-21T09:09:28-06:00 Merge-pull-request-63-from-conneroisu-New_IFIDSTAGE
--      Kariniux 2024-11-21T09:04:48-06:00 pushing-pulling
--      aidanfoss 2024-11-21T08:32:03-06:00 unused-declarations
--      Conner Ohnesorge 2024-11-16T17:36:04-06:00 finish-setup-of-muxNtM-and-test-bench
--      Conner Ohnesorge 2024-11-16T17:33:34-06:00 set-up-muxNtM-component-and-testbench
--      Conner Ohnesorge 2024-11-16T17:31:19-06:00 test-new-metavalue-detection-in-muxNtM
--      Conner Ohnesorge 2024-11-16T17:28:51-06:00 update-muxNtM-and-test-bench
--      connero 2024-11-16T17:22:38-06:00 Merge-branch-main-into-component-forward-unit
--      Conner Ohnesorge 2024-11-16T17:13:40-06:00 update-to-latest-implementation-of-muxNtM
--      Conner Ohnesorge 2024-11-13T10:12:57-06:00 save-stage-progess
--      Conner Ohnesorge 2024-11-11T14:08:03-06:00 added-generic-mux-muxNtM
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
    --constant SEL_WIDTH : integer := integer(ceil(log2(real(INPUT_COUNT))));

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

