-- <header>
-- Author(s): Conner Ohnesorge
-- Name: proj/src/TopLevel/ForwardUnit.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-17T00:16:33-06:00 more-documented-and-cleaned-up-the-forwarding-unit-to-match-with-other-implementations-in-repo
--      Conner Ohnesorge 2024-11-13T13:00:43-06:00 made-initial-structure-and-basic-logic-for-forward-unit
-- </header>

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ForwardUnit is
    port (
        i_CLK         : in  std_logic;
        i_RST         : in  std_logic;
        i_forwarding  : in  std_logic;
        i_exRs        : in  std_logic_vector (4 downto 0);
        i_exRt        : in  std_logic_vector (4 downto 0);
        i_memRd       : in  std_logic_vector (4 downto 0);
        i_wbRd        : in  std_logic_vector (4 downto 0);
        i_memMemRead  : in  std_logic_vector (4 downto 0);
        i_memMemWrite : in  std_logic_vector (4 downto 0);
        i_memPCSrc    : in  std_logic_vector (1 downto 0);
        i_wbRegWrite  : in  std_logic_vector (4 downto 0);
        i_wbMemToReg  : in  std_logic_vector (4 downto 0);
        o_exForwardA  : out std_logic_vector (1 downto 0);  -- forwarding 1st mux signal to EX stage
        o_exForwardB  : out std_logic_vector (1 downto 0)  -- forwarding 2nd mux signal to EX stage
        );
end ForwardUnit;

architecture Behavioral of ForwardUnit is
    signal memRegWrite : std_logic;
begin

    process(i_exRs, i_exRt, i_memRd, i_wbRd, i_memMemRead, i_memMemWrite, i_memPCSrc, i_wbRegWrite, i_forwarding)
        variable exRs     : unsigned(4 downto 0);
        variable exRt     : unsigned(4 downto 0);
        variable memRd    : unsigned(4 downto 0);
        variable wbRd     : unsigned(4 downto 0);
        variable memPCSrc : std_logic_vector(1 downto 0);
    begin
        exRs     := unsigned(i_exRs);
        exRt     := unsigned(i_exRt);
        memRd    := unsigned(i_memRd);
        wbRd     := unsigned(i_wbRd);
        memPCSrc := i_memPCSrc;

        -- Initialize outputs
        o_exForwardA <= "00";
        o_exForwardB <= "00";

        -- Determine memRegWrite
        if (i_memMemWrite = "0") and (memPCSrc = "00") then
            memRegWrite <= '1';
        else
            memRegWrite <= '0';
        end if;

        if (i_forwarding = '1') then
            -- Forward from MEM stage
            if (memRegWrite = '1') and (memRd /= to_unsigned(0, 5)) and (memRd = exRs) then
                o_exForwardA <= "10";
            end if;

            if (memRegWrite = '1') and (memRd /= to_unsigned(0, 5)) and (memRd = exRt) then
                o_exForwardB <= "10";
            end if;

            -- Forward from WB stage
            if (i_wbRegWrite = "1")
                and (wbRd /= to_unsigned(0, 5))
                and not ((memRegWrite = '1')
                         and (memRd /= to_unsigned(0, 5))
                         and (memRd = exRs))
                and (wbRd = exRs) then
                o_exForwardA <= "01";
            end if;

            if (i_wbRegWrite = "1")
                and (wbRd /= to_unsigned(0, 5))
                and not ((memRegWrite = '1')
                         and (memRd /= to_unsigned(0, 5))
                         and (memRd = exRt))
                and (wbRd = exRt) then
                o_exForwardB <= "01";
            end if;
        end if;
    end process;

end Behavioral;
