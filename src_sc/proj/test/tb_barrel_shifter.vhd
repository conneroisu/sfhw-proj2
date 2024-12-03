-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T16:24:07-06:00 update-barrel_shifter-name
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_barrelShifter is
    generic (
        halfClk : time    := 50 ns;
        N       : integer := 32);
end tb_barrelShifter;

architecture behavior of tb_barrelShifter is
    constant ClkHelper : time := halfClk * 2;
    component barrelShifter is
        generic (N : integer := 32);
        port (
            i_data        : in  std_logic_vector(N - 1 downto 0);
            i_shamt       : in  std_logic_vector(4 downto 0);  --01001 would do shift 3 and shift 0, mux each bit to decide how much to shift
            i_leftOrRight : in  std_logic;  --0=right, 1=left
            i_shiftType   : in  std_logic;  --0 for logicical shift, 1 for arithmetic shift
            o_O           : out std_logic_vector(N - 1 downto 0)  --shifted output
            );
    end component;
    signal s_data, s_O                : std_logic_vector(N-1 downto 0);
    signal s_shamt                    : std_logic_vector(4 downto 0);
    signal s_leftOrRight, s_shiftType : std_logic;
    signal s_debug                    : std_logic_vector(N-1 downto 0);  --debug value is genius, will show correct value hand calculated in the waveform
begin
    shifter1 : barrelShifter
        port map(
            i_data        => s_data,
            i_shamt       => s_shamt,
            i_leftOrRight => s_leftOrRight,
            i_shiftType   => s_shiftType,
            o_O           => s_O);
    shiftTest : process
    begin
--temporary tests
        s_shiftType <= '1';

        wait for ClkHelper;
        s_leftOrRight <= '1';           --sra 1 16 to 8
        s_data        <= x"00000010";  --0000 0000 0000 0000 0000 0000 0001 0000       to      0000 0000 0000 0000 0000 0000 0000 1000
        s_debug       <= x"00000008";  --00000010                                     to      00000008
        s_shamt       <= "00001";
        wait for ClkHelper;
        s_leftOrRight <= '1';           --sra 3 64 to 8
        s_data        <= x"00000040";  --0000 0000 0000 0000 0000 0000 0100 0000       to      0000 0000 0000 0000 0000 0000 0000 1000
        s_debug       <= x"00000008";  --00000040                                     to      00000008
        s_shamt       <= "00011";

        wait for ClkHelper;
        s_leftOrRight <= '1';           --sra 1 -16 to -8
        s_data        <= x"FFFFFFF0";  --1111 1111 1111 1111 1111 1111 1111 0000       to      1111 1111 1111 1111 1111 1111 1111 1000
        s_debug       <= x"FFFFFFF8";  --FFFFFFDF                                     to      FFFFFFF8
        s_shamt       <= "00001";
        wait for ClkHelper;
        s_leftOrRight <= '1';           --sra 3 -64 to -8
        s_data        <= x"FFFFFFC0";  --1111 1111 1111 1111 1111 1111 1100 0000       to      1111 1111 1111 1111 1111 1111 1111 1000
        s_debug       <= x"FFFFFFF8";  --FFFFFFBF                                     to      FFFFFFF8
        s_shamt       <= "00011";
----------------------------------------------------------------------------------------------------------
--Begin logical tests, look for improper sign extension
---------------------------------------------------------------------------------------------------------- 
        wait for ClkHelper;
        s_shiftType   <= '0';           --logical shift tests firsts
        s_leftOrRight <= '0';           --sll 0
        s_data        <= x"30303030";  -- 00110000001100000011000000110000 to 00110000001100000011000000110000
        s_debug       <= x"30303030";   -- 30303030 to 30303030
        s_shamt       <= "00000";

        wait for ClkHelper;
        s_leftOrRight <= '0';           --sll 1
        s_data        <= x"30303030";  -- 00110000001100000011000000110000 to 01100000011000000110000001100000
        s_debug       <= x"60606060";   -- 30303030 to 60606060
        s_shamt       <= "00001";
        wait for ClkHelper;
        s_leftOrRight <= '1';           --srl 1
        s_data        <= x"40404040";  -- 0100 0000 0100 0000 0100 0000 0100 0000      to      0010 0000 0010 0000 0010 0000 0010 0000
        s_debug       <= x"20202020";  -- 30303030                                    to      20202020
        s_shamt       <= "00001";       --works, srl 1 works

        wait for ClkHelper;
        s_leftOrRight <= '1';           --srl 2 (RIGHT 2)
        s_data        <= x"30303030";  -- 0011 0000 0011 0000 0011 0000 0011 0000      to      0000 1100 0000 1100 0000 1100 0000 1100
        s_debug       <= x"0C0C0C0C";  -- 30303030                                    to      0C0C0C0C
        s_shamt       <= "00010";

        wait for ClkHelper;             --wrong, outputs 0C0C0C0C rn
        s_leftOrRight <= '1';           --srl 3 (RIGHT 3)
        s_data        <= x"30303030";  -- 0011 0000 0011 0000 0011 0000 0011 0<000>    to      <000>0 0110 0000 0110 0000 0110 0000 0110
        s_debug       <= x"06060606";  -- 30303030                                    to      06060606 (0C0C0C0C???)
        s_shamt       <= "00011";

        wait for ClkHelper;
        s_leftOrRight <= '1';           --srl 4 (RIGHT 4)
        s_data        <= x"30303030";  -- 0011 0000 0011 0000 0011 0000 0011 0000      to      0000 0011 0000 0011 0000 0011 0000 0011
        s_debug       <= x"03030303";  -- 30303030                                    to      03030303
        s_shamt       <= "00100";       --4

        wait for ClkHelper;
        s_leftOrRight <= '0';           --sll 4 (left 4)
        s_data        <= x"30303030";  -- 0011 0000 0011 0000 0011 0000 0011 0000      to      0000 0011 0000 0011 0000 0011 0000 0000
        s_debug       <= x"03030300";  -- 30303030                                    to      03030300
        s_shamt       <= "00100";       --4
        wait for ClkHelper;             --wrong, outputs 04040400
        s_leftOrRight <= '0';           --sll 5 (left 5)
        s_data        <= x"40404040";  -- <0100 0>000 0100 0000 0100 0000 0100 0000    to      0000 1000 0000 1000 0000 1000 000<0 0000>
        s_debug       <= x"08080800";  -- 40404040                                    to      08080800
        s_shamt       <= "00101";       --5

        wait for ClkHelper;
        s_leftOrRight <= '1';           --srl 8 (RIGHT 8)
        s_data        <= x"30303030";  -- 0011 0000 0011 0000 0011 0000 0011 0000      to      0000 0000 0011 0000 0011 0000 0011 0000
        s_debug       <= x"00303030";  -- 30303030                                    to      00303030
        s_shamt       <= "01000";

        wait for ClkHelper;
        s_leftOrRight <= '0';           --sll 8
        s_data        <= x"40404040";  --0100 0000 0100 0000 0100 0000 0100 0000       to      0100 0000 0100 0000 0100 0000 0000 0000
        s_debug       <= x"40404000";  --40404040                                     to      40404000
        s_shamt       <= "01000";
----------------------------------------------------------------------------------------------------------
--Begin arithmetic tests, look for proper sign extension
----------------------------------------------------------------------------------------------------------                              

        wait for ClkHelper;
        s_shiftType   <= '1';           --set to arithmetic
        s_leftOrRight <= '0';           --sla 0
        s_data        <= x"ABCDEF12";  --1010 1011 1100 1101 1110 1111 0001 0010       to      1010 1011 1100 1101 1110 1111 0001 0010
        s_debug       <= x"ABCDEF12";  --ABCDEF12                                     to      ABCDEF12
        s_shamt       <= "00000";

        wait for ClkHelper;
        s_leftOrRight <= '0';  --sla 1 (this one should maintain negative value, -522133280 to -1044266560)
        s_data        <= x"E0E0E0E0";  --(1)110 0000 1110 0000 1110 0000 1110 0000     to      (1)100 0001 1100 0001 1100 0001 1100 0000
        s_debug       <= x"C1C1C1C0";  --E0E0E0E0                                     to      C1C1C1C0
        s_shamt       <= "00001";
        wait for ClkHelper;
        s_leftOrRight <= '0';  --sla 1 (this one should maintain positive value, 235802126 to 471604252)
        s_data        <= x"0E0E0E0E";  --(0)000 1110 0000 1110 0000 1110 0000 1110     to      (0)001 1100 0001 1100 0001 1100 0001 1100
        s_debug       <= x"1C1C1C1C";  --E0E0E0E0                                     to      1C1C1C1C
        s_shamt       <= "00001";

        wait for ClkHelper;
        s_leftOrRight <= '1';           --sra 2
        s_data        <= x"ABCDEF12";  --(1)010 1011 1100 1101 1110 1111 0001 0010     to      (1)110 1010 1111 0011 0111 1011 1100 0100
        s_debug       <= x"EAF37BC4";  --ABCDEF12                                     to      EAF37BC4
        s_shamt       <= "00010";

        wait for ClkHelper;
        s_leftOrRight <= '1';           --sra 3
        s_data        <= x"ABCDEF12";  --(1)010 1011 1100 1101 1110 1111 0001 0010     to      (1)111 0101 0111 1001 1011 1101 1110 0010
        s_debug       <= x"F579BDE2";  --ABCDEF12                                     to      F579BDE2
        s_shamt       <= "00011";  --wrong, outputs EAF37BC4 ?????? as if sra 1 didnt work

        wait for ClkHelper;
        s_leftOrRight <= '1';  --sra 4 (-1412567278 sra 4 = -88285455), which is pretty much (-1412567278 / 16 = -88285454.875) 
        s_data        <= x"ABCDEF12";  --(1)010 1011 1100 1101 1110 1111 0001 0010     to      (1)111 1010 1011 1100 1101 1110 1111 0001
        s_debug       <= x"FABCDEF1";  --ABCDEF12                                     to      FABCDEF1
        s_shamt       <= "00100";

        wait for ClkHelper;
        s_leftOrRight <= '0';           --sla 4
        s_data        <= x"ABCDEF12";  --(1)010 1011 1100 1101 1110 1111 0001 0010     to      (1)011 1100 1101 1110 1111 0001 0010 0000
        s_debug       <= x"BCDEF120";  --ABCDEF12                                     to      BCDEF120
        s_shamt       <= "00100";

        wait for ClkHelper;
        s_leftOrRight <= '1';           --sra 8
        s_data        <= x"ABCDEF12";  --(1)010 1011 1100 1101 1110 1111 0001 0010     to      (1)111 1111 1010 1011 1100 1101 1110 1111       
        s_debug       <= x"FFABCDEF";  --ABCDEF12                                     to      FFABCDEF
        s_shamt       <= "01000";

        wait for ClkHelper;
        s_leftOrRight <= '0';           --sla 8
        s_data        <= x"ABCDEF12";  --(1)010 1011 1100 1101 1110 1111 0001 0010     to      (1)100 1101 1110 1111 0001 0010 0000 0000
        s_debug       <= x"CDEF1200";  --ABCDEF12                                     to      CDEF1200
        s_shamt       <= "01000";
----------------------------------------------------------------------------------------------------------
--Begin human readable tests, look for improper/proper sign extension
---------------------------------------------------------------------------------------------------------- 
        wait for ClkHelper;  --human x2 positive arithmetic (should maintain signage)
        s_leftOrRight <= '0';  --sla 1 (this one should maintain positive value, 5 to 10)
        s_data        <= x"00000005";  --(0)000 0000 0000 0000 0000 0000 0000 0101     to      (0)000 0000 0000 0000 0000 0000 0000 1010
        s_debug       <= x"0000000A";  --00000005                                     to      0000000A
        s_shamt       <= "00001";
        wait for ClkHelper;  --human x2 negative arithmetic (should maintain signage)
        s_leftOrRight <= '0';  --sla 1 (this one should maintain negative value, -5 to -10)
        s_data        <= x"FFFFFFFA";  --(1)011 1111 1111 1111 1111 1111 1111 1010     to      (1)111 1111 1111 1111 1111 1111 1111 0100
        s_debug       <= x"FFFFFFF4";  --FFFFFFFA                                     to      FFFFFFF5 (7FFFFFF4?)
        s_shamt       <= "00001";
        s_shiftType   <= '0';           --set shift type back to logical
        wait for ClkHelper;  --human x2 positive logical (shouldnt purposefully maintain signage)
        s_leftOrRight <= '0';  --sll 1 (this one should maintain positive value, 5 to 10)
        s_data        <= x"00000005";  --(0)000 0000 0000 0000 0000 0000 0000 0101     to      (0)000 0000 0000 0000 0000 0000 0000 1010
        s_debug       <= x"0000000A";  --00000005                                     to      0000000A
        s_shamt       <= "00001";
        wait for ClkHelper;  --human x2 negative logical (shouldnt purposefully maintain signage)
        s_leftOrRight <= '0';  --sll 1 (this one shouldnt maintain negative value, -1073741830 to 2147483637)
        s_data        <= x"BFFFFFFA";  --1011 1111 1111 1111 1111 1111 1111 1010       to      0111 1111 1111 1111 1111 1111 1111 0100
        s_debug       <= x"7FFFFFF4";  --BFFFFFFA                                     to      7FFFFFF4
        s_shamt       <= "00001";

    end process;
end behavior;

