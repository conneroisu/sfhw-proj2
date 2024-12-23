-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--      connerohnesorge 2024-12-05T22:38:28-06:00 better-readibility-in-BarrelShifter-and-ZeroDetector
--      connerohnesorge 2024-12-04T17:23:24-06:00 improved-BarrelShifter-concisitity
--      Conner Ohnesorge 2024-12-04T06:40:31-06:00 latest
--      Conner Ohnesorge 2024-12-04T05:37:20-06:00 more-appropriate-name-for-barrel-shifter-in-the-midlevel
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity BarrelShifter is
    generic (N : integer := 32);

    port (
        i_data             : in  std_logic_vector(N-1 downto 0);
        i_logic_arithmetic : in  std_logic;  -- 0: logical, 1: arithmetic shift
        i_left_right       : in  std_logic;  -- 0: left shift, 1: right shift
        i_shamt            : in  std_logic_vector(4 downto 0);
        o_Out              : out std_logic_vector(N-1 downto 0)
        );

end BarrelShifter;

architecture behavioral of BarrelShifter is
    -- Internal signals for shift stages
    type shift_array is array (0 to 4) of std_logic_vector(N-1 downto 0);
    signal right_shift_stages : shift_array;
    signal left_shift_stages  : shift_array;

    -- Sign bit for arithmetic right shifts
    signal sign_bit : std_logic;

    -- Helper function to replicate a bit N times
    function replicate(bit_val : std_logic; count : natural) return std_logic_vector is
        variable result : std_logic_vector(count-1 downto 0);
    begin
        result := (others => bit_val);
        return result;
    end function;

begin

    sign_bit <= '0' when i_logic_arithmetic = '0' else i_data(N-1);

    -- Main shifting process
    shift_process : process(i_data, i_shamt, sign_bit)
        variable right_temp : std_logic_vector(N-1 downto 0);
        variable left_temp  : std_logic_vector(N-1 downto 0);
    begin
        -- Initialize first stage with input
        right_temp := i_data;
        left_temp  := i_data;

        for i in 0 to 4 loop

            if i_shamt(i) = '1' then
                right_temp := replicate(sign_bit, 2**i) & right_temp(N-1 downto 2**i);
                left_temp  := left_temp(N-1-(2**i) downto 0) & replicate('0', 2**i);
            end if;

            right_shift_stages(i) <= right_temp;
            left_shift_stages(i)  <= left_temp;
        end loop;
    end process;

    output_select : process(i_left_right, right_shift_stages, left_shift_stages)
    begin
        if i_left_right = '1' then
            o_Out <= right_shift_stages(4);
        else
            o_Out <= left_shift_stages(4);
        end if;
    end process;

end behavioral;

