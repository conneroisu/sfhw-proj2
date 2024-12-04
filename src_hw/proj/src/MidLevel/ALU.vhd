library IEEE;
use IEEE.std_logic_1164.all;

entity ALU is
    generic (N : integer := 32);

    port (
        i_A        : in  std_logic_vector(N - 1 downto 0);
        i_B        : in  std_logic_vector(N - 1 downto 0);
        i_ALUOP    : in  std_logic_vector(3 downto 0);
        i_shamt    : in  std_logic_vector(4 downto 0);
        o_resultF  : out std_logic_vector(N - 1 downto 0);
        o_CarryOut : out std_logic;
        o_Overflow : out std_logic;
        o_zero     : out std_logic
        );

end ALU;

architecture mixed of ALU is

    component AdderSubtractor is
        generic (N : integer := 32);  -- Generic of type integer for input/output data width. Default value is 32.
        port (
            nAdd_Sub : in  std_logic;
            i_A      : in  std_logic_vector(N - 1 downto 0);
            i_B      : in  std_logic_vector(N - 1 downto 0);
            o_S      : out std_logic_vector(N - 1 downto 0);
            o_C      : out std_logic;
            o_OF     : out std_logic
            );
    end component;
    component Barrel_Shifter is
        generic (N : integer := 32);  -- Generic of type integer for input/output data width. Default value is 32.
        port (
            i_data             : in  std_logic_vector(N - 1 downto 0);
            i_logic_arithmetic : in  std_logic;  -- 0 for logical, 1 for arithmetic (sign bit)
            i_left_right       : in  std_logic;  --0 for shift left, 1 for shift right
            i_shamt            : in  std_logic_vector(4 downto 0);  --shift amount
            o_Out              : out std_logic_vector(N - 1 downto 0)  --output of the shifter
            );
    end component;

    component ZeroDetector is
        port (
            i_F    : in  std_logic_vector(31 downto 0);
            o_zero : out std_logic);
    end component;

    component mux2t1_N is
        generic (N : integer := 32);
        port (
            i_S  : in  std_logic;
            i_D0 : in  std_logic_vector(N - 1 downto 0);
            i_D1 : in  std_logic_vector(N - 1 downto 0);
            o_O  : out std_logic_vector(N - 1 downto 0)
            );
    end component;

    component mux8t1_N is
        generic (N : integer := 32);
        port (
            i_S  : in  std_logic_vector(2 downto 0);
            i_D0 : in  std_logic_vector(31 downto 0);
            i_D1 : in  std_logic_vector(31 downto 0);
            i_D2 : in  std_logic_vector(31 downto 0);
            i_D3 : in  std_logic_vector(31 downto 0);
            i_D4 : in  std_logic_vector(31 downto 0);
            i_D5 : in  std_logic_vector(31 downto 0);
            i_D6 : in  std_logic_vector(31 downto 0);
            i_D7 : in  std_logic_vector(31 downto 0);
            o_O  : out std_logic_vector(31 downto 0));
    end component;

    --computes or, and, xor, and nor
    component logic_N is
        generic(N : integer := 32);
        port (
            i_A                       : in  std_logic_vector(31 downto 0);
            i_B                       : in  std_logic_vector(31 downto 0);
            o_OR, o_AND, o_XOR, o_NOR : out std_logic_vector(31 downto 0));
    end component;

    signal s_Adder_Out,
        s_Barrel_Output,
        s_OR,
        s_AND,
        s_XOR,
        s_NOR,
        s_set : std_logic_vector(31 downto 0);
    signal s_zero,
        s_NOTzero,
        s_addSub_overflow,
        s_lui,
        s_nAdd_Sub,
        s_left_right,
        s_logic_arithmetic,
        s_bne,
        s_unsigned : std_logic;                      --internal control signals
    signal s_shamt  : std_logic_vector(4 downto 0);
    signal s_select : std_logic_vector(2 downto 0);  --final mux select
begin
    -- Select add_sub function
    with i_ALUOP select s_nAdd_Sub <=
        '1' when "1110",                -- sub for beq
        '1' when "1101",                -- sub for bne
        '1' when "0011",                -- subu
        '1' when "1111",                -- sub
        '1' when "1000",                -- slt, use sub
        '0' when others;                -- add for other instructions

    --lui select
    with i_ALUOP select s_lui <=
        '1' when "1001",                --lui instruction
        '0' when others;

    --left or right shift select
    with i_ALUOP select s_left_right <=
        '1' when "1100",                -- sra
        '1' when "1011",                -- srl
        '0' when others;

    --logical or arithmetic shift select
    with i_ALUOP select s_logic_arithmetic <=
        '1' when "1100",                -- sra
        '0' when others;

    --check if branch not equal instruction
    with i_ALUOP select s_bne <=
        '1' when "1101",                -- bne instruction
        '0' when others;

    --check if unsigned instruction
    with i_ALUOP select s_unsigned <=
        '0' when "0001",                -- addu
        '0' when "0011",                -- subu
        '1' when others;                -- consider overflow if not unsigned

    with i_ALUOP select s_select <=
        "000" when "1110",              -- beq, output doesn't matter
        "000" when "1101",              -- bne, output doesn't matter
        "000" when "0001",              -- addu, use adder output
        "000" when "0011",              -- subu, use adder output
        "000" when "0010",              -- add, use adder output
        "000" when "1111",              -- sub, use adder output
        "011" when "0100",              -- and, use and output
        "010" when "0101",              -- or, use or output
        "100" when "0110",              -- xor, use xor output
        "101" when "0111",              -- nor, use nor output
        "001" when "1001",              -- lui, use shifter output
        "110" when "1000",              -- slt, use slt output
        "001" when "1010",              -- sll, use shifter output
        "001" when "1011",              -- srl, use shifter output
        "001" when "1100",              -- sra, use shifter output
        "000" when others;              -- doesn't matter, just use adder output

    --selects shamt or 16(used for lui)
    luiMUX : mux2t1_N
        generic map(N => 5)
        port map(
            i_S  => s_lui,
            i_D0 => i_shamt,
            i_D1 => "10000",
            o_O  => s_shamt
            );

    instShifter : Barrel_Shifter
        port map(
            i_data             => i_B,
            i_shamt            => s_shamt,
            i_left_right       => s_left_right,
            i_logic_arithmetic => s_logic_arithmetic,
            o_Out              => s_Barrel_Output);

    instAdderSub : AdderSubtractor
        generic map(N => 32)
        port map(
            nAdd_Sub => s_nAdd_Sub,
            i_A      => i_A,
            i_B      => i_B,
            o_S      => s_Adder_Out,
            o_C      => o_CarryOut,
            o_OF     => s_addSub_overflow);

    o_Overflow <= s_addSub_overflow and s_unsigned;

    instZeroDetector : ZeroDetector
        port map(
            i_F    => s_Adder_Out,
            o_zero => s_zero);

    s_NOTzero <= not s_zero;
    o_zero    <= s_NOTzero xor s_bne;

    instLogicGates : logic_N
        generic map(N => 32)
        port map(
            i_A   => i_A,
            i_B   => i_B,
            o_OR  => s_OR,
            o_AND => s_AND,
            o_XOR => s_XOR,
            o_NOR => s_NOR);

    -- if 31st bit is negative (1) then set less than, 0 otherwise
    instNegSetMux : mux2t1_N
        port map(
            i_S  => s_Adder_Out(31),
            i_D0 => x"00000000",
            i_D1 => x"00000001",
            o_O  => s_set
            );

    -- select final output from the 7 options
    instOutputMux : mux8t1_N
        port map(
            i_S  => s_select,
            i_D0 => s_Adder_Out,
            i_D1 => s_Barrel_Output,
            i_D2 => s_OR,
            i_D3 => s_AND,
            i_D4 => s_XOR,
            i_D5 => s_NOR,
            i_D6 => s_set,
            i_D7 => x"00000000",  --unused value, never selected for this project
            o_O  => o_resultF);

end mixed;
