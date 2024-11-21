-- <header>
-- Author(s): Conner Ohnesorge
-- Name: src_sw/proj/src/TopLevel/BarrelShifter/barrelShifter.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-21T10:30:54-06:00 added-alu-barrel-shifter-and-fetch-modules-to-the-top-level-of-the
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use work.MIPS_types.all;

entity barrelShifter is
    generic
        (N : integer := 32);
    port
        (
            i_data        : in  std_logic_vector(N - 1 downto 0);
            i_shamt       : in  std_logic_vector(4 downto 0);  --01001 would do shift 3 and shift 0, mux each bit to decide how much to shift
            i_leftOrRight : in  std_logic;  --0=right, 1=left
            i_shiftType   : in  std_logic;  --0 for logicical shift, 1 for arithmetic shift
            o_O           : out std_logic_vector(N - 1 downto 0)  --shifted output
            );
end barrelShifter;
architecture structure of barrelShifter is

    component mux2t1_N
        generic
            (N : integer := 32);
        port
            (
                i_D0 : in  std_logic_vector(N - 1 downto 0);         --input 1
                i_D1 : in  std_logic_vector(N - 1 downto 0);         --input 2
                i_S  : in  std_logic;   --shift toggle
                o_O  : out std_logic_vector(N - 1 downto 0)          --output
                );
    end component;
-- mux signals (i think i need 5 or 6 for outputs, 5 or 6 for r/l, and 1 for carrying 16 bits)
    signal s_mux0, s_mux1, s_mux2, s_mux3, s_muxUnflip            : std_logic_vector(N -1 downto 0);  --shamt mux
    signal s_mux0t, s_mux1t, s_mux2t, s_mux3t, s_mux4t, s_muxFlip : std_logic_vector(N -1 downto 0);
    signal s_b                                                    : std_logic_vector(15 downto 0);
    signal s_muxFlip_shifted1                                     : std_logic_vector(N-1 downto 0);
    signal s_muxFlip_arith1                                       : std_logic_vector(N-1 downto 0);
    signal s_muxFlip_shifted2                                     : std_logic_vector(N-1 downto 0);
    signal s_muxFlip_arith2                                       : std_logic_vector(N-1 downto 0);
    signal s_muxFlip_shifted3                                     : std_logic_vector(N-1 downto 0);
    signal s_muxFlip_arith3                                       : std_logic_vector(N-1 downto 0);
    signal s_muxFlip_shifted4                                     : std_logic_vector(N-1 downto 0);
    signal s_muxFlip_arith4                                       : std_logic_vector(N-1 downto 0);
    signal s_muxFlip_shifted0                                     : std_logic_vector(N-1 downto 0);
    signal s_muxFlip_arith0                                       : std_logic_vector(N-1 downto 0);
begin
--flip
    mux_flip : mux2t1_N
        port
        map(
            i_D0 => i_data,
            i_D1 => bit_reverse(i_data),
            i_S  => i_leftOrRight,
            o_O  => s_muxFlip
            );
    s_b                <= (others => i_data(31) and i_leftOrRight);  --copies MSB
--part 0: shift 1
    s_muxFlip_shifted0 <= s_muxFlip(30 downto 0) & "0";
    s_muxFlip_arith0   <= s_muxFlip(30 downto 0) & s_b(0 downto 0);
    mux0_t : mux2t1_N  -- this mux either lets the arithmetic or logical shift through
        port
        map(
            i_D0 => s_muxFlip_shifted0,  --logical shift
            i_D1 => s_muxFlip_arith0,   --arithmetic shift
            i_S  => i_shiftType,
            o_O  => s_mux0t             -- output
            );
    mux0_o : mux2t1_N  -- this mux decides whether the shift from mux0_t should go through
        port
        map(
            i_D0 => s_muxFlip,          --non shifted
            i_D1 => s_mux0t,            --shifted value
            i_S  => i_shamt(0),         --shift or not
            o_O  => s_mux0              --output
            );
--part 1: shift 2
    s_muxFlip_shifted1 <= s_mux0(29 downto 0) & "00";
    s_muxFlip_arith1   <= s_mux0(29 downto 0) & s_b(1 downto 0);
    mux1_t : mux2t1_N  -- this mux either lets the arithmetic or logical shift through
        port
        map(
            i_D0 => s_muxFlip_shifted1,
            i_D1 => s_muxFlip_arith1,
            i_S  => i_shiftType,
            o_O  => s_mux1t
            );
    mux1_o : mux2t1_N
        port
        map(
            i_D0 => s_mux0,             --non shifted
            i_D1 => s_mux1t,            --shifted value
            i_S  => i_shamt(1),         --shift or not
            o_O  => s_mux1              --output
            );
--part 2: shift 4
    s_muxFlip_shifted2 <= s_mux1(27 downto 0) & "0000";
    s_muxFlip_arith2   <= s_mux1(27 downto 0) & s_b(3 downto 0);
    mux2_t : mux2t1_N  -- this mux either lets the arithmetic or logical shift through
        port
        map(
            i_D0 => s_muxFlip_shifted2,
            i_D1 => s_muxFlip_arith2,
            i_S  => i_shiftType,
            o_O  => s_mux2t             -- output
            );
    mux2_o : mux2t1_N
        port
        map(
            i_D0 => s_mux1,             --non shifted
            i_D1 => s_mux2t,            --shifted value
            i_S  => i_shamt(2),         --shift or not
            o_O  => s_mux2              --output
            );
--part 3: shift 8
    s_muxFlip_shifted3 <= s_mux2(23 downto 0) & "00000000";
    s_muxFlip_arith3   <= s_mux2(23 downto 0) & s_b(7 downto 0);
    mux3_t : mux2t1_N  -- this mux either lets the arithmetic or logical shift through
        port
        map(
            i_D0 => s_muxFlip_shifted3,
            i_D1 => s_muxFlip_arith3,
            i_S  => i_shiftType,
            o_O  => s_mux3t             -- output
            );
    mux3_o : mux2t1_N
        port
        map(
            i_D0 => s_mux2,             --non shifted
            i_D1 => s_mux3t,            --shifted value
            i_S  => i_shamt(3),         --shift or not
            o_O  => s_mux3              --output
            );
--part 4: shift 16
    s_muxFlip_shifted4 <= s_mux3(15 downto 0) & "0000000000000000";
    s_muxFlip_arith4   <= s_mux3(15 downto 0) & s_b(15 downto 0);
    mux4_t : mux2t1_N  -- this mux either lets the arithmetic or logical shift through
        port
        map(
            i_D0 => s_muxFlip_shifted4,  --sl 16
            i_D1 => s_muxFlip_arith4,   --sa 16
            i_S  => i_shiftType,
            o_O  => s_mux4t             -- output
            );
    mux4_o : mux2t1_N
        port
        map(
            i_D0 => s_mux3,             --non shifted
            i_D1 => s_mux4t,            --shifted value
            i_S  => i_shamt(4),         --shift or not
            o_O  => s_muxUnflip         --output
            );
--unflip
    mux_unflip : mux2t1_N
        port
        map(
            i_D0 => s_muxUnflip,        --sll
            i_D1 => bit_reverse(s_muxUnflip),                        --sra/srl
            i_S  => i_leftOrRight,      --0 for right, 1 for left shift
            o_O  => o_O                 --final output
            );
end structure;

