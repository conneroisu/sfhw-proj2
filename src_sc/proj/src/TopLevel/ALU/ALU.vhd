-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--	connerohnesorge 2024-12-13T13:15:36-06:00 updaate-single-cycle-processor-structure
--	connerohnesorge 2024-12-10T09:22:24-06:00 assert-that-all-of-the-single-cycle-implementation-fits-styleguide
--	Conner Ohnesorge 2024-12-01T16:27:54-06:00 update-fix-barrel_shifter-declarations
--	Conner Ohnesorge 2024-11-21T11:05:34-06:00 added-old-single-cycle-processor-and-added-documentation-for-the
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MIPS_Types.all;
-- Entity declaration of the ALU
entity alu is
    
    port
        (
            CLK        : in  std_logic;      -- Clock signal
            i_Data1    : in  std_logic_vector(31 downto 0);  -- 32-bit input data 1
            i_Data2    : in  std_logic_vector(31 downto 0);  -- 32-bit input data 2
            i_shamt    : in  std_logic_vector(4 downto 0);  -- 5-bit shift amount
            i_aluOp    : in  std_logic_vector(3 downto 0);  -- 4-bit ALU operation code
            o_F        : out std_logic_vector(31 downto 0);  -- 32-bit ALU result
            o_Overflow : out std_logic;      -- Overflow flag
            o_Zero     : out std_logic  -- Zero flag
            );
        
end alu;

architecture structural of alu is
    component adderSubtractor is
        generic
            (N : integer := 32);
        port
            (
                i_A        : in  std_logic_vector(N - 1 downto 0);
                i_B        : in  std_logic_vector(N - 1 downto 0);
                i_S        : in  std_logic;  -- signed or unsigned operations
                nAdd_Sub   : in  std_logic;  -- add or subtract
                o_Y        : out std_logic_vector(N - 1 downto 0);
                o_Cout     : out std_logic;
                o_Overflow : out std_logic
                );
    end component;
    component barrel_shifter is
        generic
            (N : integer := 32);
        port
            (
                i_shamt       : in  std_logic_vector(4 downto 0);
                i_data        : in  std_logic_vector(N - 1 downto 0);
                i_leftOrRight : in  std_logic;  -- 0=right, 1=left
                i_shiftType   : in  std_logic;  -- 0 for logical shift, 1 for arithmetic shift
                o_O           : out std_logic_vector(N - 1 downto 0)  -- shifted output
                );
    end component;
    component mux2t1_N is
        generic
            (N : integer := 16);
        port
            (
                i_S  : in  std_logic;
                i_D0 : in  std_logic_vector(31 downto 0);
                i_D1 : in  std_logic_vector(31 downto 0);
                o_O  : out std_logic_vector(31 downto 0)
                );
    end component;
    component andg32 is
        port
            (
                i_A : in  std_logic_vector(31 downto 0);
                i_B : in  std_logic_vector(31 downto 0);
                o_F : out std_logic_vector(31 downto 0)
                );
    end component;
    component org32 is
        port
            (
                i_A : in  std_logic_vector(31 downto 0);
                i_B : in  std_logic_vector(31 downto 0);
                o_F : out std_logic_vector(31 downto 0)
                );
    end component;
    component xorg32 is
        port
            (
                i_A : in  std_logic_vector(31 downto 0);
                i_B : in  std_logic_vector(31 downto 0);
                o_F : out std_logic_vector(31 downto 0)
                );
    end component;
    component nandg32 is
        port
            (
                i_A : in  std_logic_vector(31 downto 0);
                i_B : in  std_logic_vector(31 downto 0);
                o_F : out std_logic_vector(31 downto 0)
                );
    end component;
    component norg32 is
        port
            (
                i_A : in  std_logic_vector(31 downto 0);
                i_B : in  std_logic_vector(31 downto 0);
                o_F : out std_logic_vector(31 downto 0)
                );
    end component;
    component mux16t1 is
        port
            (
                i_I : in  array_16x32;
                i_S : in  std_logic_vector(3 downto 0);
                o_O : out std_logic_vector(31 downto 0)
                );
    end component;
    signal s_AddSub_res, s_shift_res, s_Mux_res                                          : std_logic_vector(31 downto 0);
    signal s_overflow, s_alu_cout                                                        : std_logic;
    signal s_o_andg32, s_o_org32, s_o_xorg32, s_o_nandg32, s_o_norg32, s_o_slt, s_o_sltu : std_logic_vector(31 downto 0);
    signal s_mux_input                                                                   : array_16x32;
begin
    -- Arithmetic Unit (Addition and Subtraction)
    G_ADD_SUB : adderSubtractor
        port map
        (
            i_a        => i_Data1,
            i_b        => i_Data2,
            i_s        => i_aluOp(1),   -- signed/unsigned arithmetic selector
            nadd_sub   => i_aluOp(0),   -- add/sub selector
            o_y        => s_AddSub_res,
            o_cout     => s_alu_cout,
            o_overflow => s_overflow
            );
    o_Overflow <= s_overflow;
    -- Zero Output
    o_Zero     <= '1' when s_AddSub_res = x"00000000" else '0';
    -- Barrel Shifting Unit (Shift operations)
    G_SHIFTER : barrel_shifter
        port map
        (
            i_data        => i_Data2,
            i_shamt       => i_shamt,
            i_leftOrRight => i_aluOp(3),     -- 0 = left shift, 1 = right shift
            i_shiftType   => i_aluOp(1),     -- 1 = arithmetic, 0 = logical
            o_O           => s_shift_res
            );
    -- Logical Operations (AND, OR, XOR, NAND, NOR)
    G_AND32  : andg32 port map(i_A  => i_Data1, i_B => i_Data2, o_F => s_o_andg32);
    G_OR32   : org32 port map(i_A   => i_Data1, i_B => i_Data2, o_F => s_o_org32);
    G_XOR32  : xorg32 port map(i_A  => i_Data1, i_B => i_Data2, o_F => s_o_xorg32);
    G_NAND32 : nandg32 port map(i_A => i_Data1, i_B => i_Data2, o_F => s_o_nandg32);
    G_NOR32  : norg32 port map(i_A  => i_Data1, i_B => i_Data2, o_F => s_o_norg32);
    -- SLT and SLTU Generation
    s_o_slt(0) <= s_AddSub_res(31);
    G2       : for i in 1 to 31 generate
        s_o_slt(i) <= '0';
    end generate;
    s_o_sltu(0) <= (not s_alu_cout);
    G3 : for i in 1 to 31 generate
        s_o_sltu(i) <= '0';
    end generate;
    -- Multiplexer to Select Final Output
    G_MUX_RES : mux16t1
        port map
        (
            i_I(0)  => s_AddSub_res,    -- unsigned add
            i_I(1)  => s_AddSub_res,    -- unsigned sub
            i_I(2)  => s_AddSub_res,    -- signed add
            i_I(3)  => s_AddSub_res,    -- signed sub
            i_I(4)  => s_shift_res,     -- SLL
            i_I(5)  => s_o_andg32,
            i_I(6)  => s_o_nandg32,
            i_I(7)  => s_o_slt,         -- SLT signed
            i_I(8)  => s_o_norg32,
            i_I(9)  => s_o_org32,
            i_I(10) => s_o_xorg32,
            i_I(11) => x"00000000",
            i_I(12) => s_shift_res,     -- SRL
            i_I(13) => s_o_sltu,        -- SLTU unsigned
            i_I(14) => s_shift_res,     -- SRA
            i_I(15) => x"00000000",
            i_S     => i_aluOp(3 downto 0),
            o_O     => o_F              -- ALU final output
            );
end structural;

