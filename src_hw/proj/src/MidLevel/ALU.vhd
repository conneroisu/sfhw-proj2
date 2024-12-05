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
        generic (N : integer := 32);
        port (
            nAdd_Sub : in  std_logic;
            i_A      : in  std_logic_vector(N - 1 downto 0);
            i_B      : in  std_logic_vector(N - 1 downto 0);
            o_S      : out std_logic_vector(N - 1 downto 0);
            o_C      : out std_logic;
            o_OF     : out std_logic
            );
    end component;

    component BarrelShifter is
        generic (N : integer := 32);
        port (
            i_data             : in  std_logic_vector(N - 1 downto 0);
            i_logic_arithmetic : in  std_logic;  -- 0 for logical, 1 for arithmetic (sign bit)
            i_left_right       : in  std_logic;  -- 0 for shift left, 1 for shift right
            i_shamt            : in  std_logic_vector(4 downto 0);  -- Shift amount.
            o_Out              : out std_logic_vector(N - 1 downto 0)  -- Output of the shifter
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
            o_O  : out std_logic_vector(31 downto 0)
            );
    end component;

    component logic_N is
        generic(N : integer := 32);
        port (
            i_A                       : in  std_logic_vector(31 downto 0);
            i_B                       : in  std_logic_vector(31 downto 0);
            o_OR, o_AND, o_XOR, o_NOR : out std_logic_vector(31 downto 0)
            );
    end component;

    signal s_Adder_Out,
        s_Barrel_Output,
        s_OR,
        s_AND,
        s_XOR,
        s_NOR,
        s_set : std_logic_vector(31 downto 0);
    signal s_zero,
        s_NotZero,
        s_AdderSubtractorOverflow,
        s_Lui,
        s_Operator,                     -- 0: add, 1: sub
        s_ShiftDirection,               -- 0: left shift, 1: right shift
        s_ShiftType,                    -- 0: logical, 1: arithmetic
        s_Bne,
        s_ShiftUnsigned : std_logic;
    signal s_Shamt  : std_logic_vector(4 downto 0);
    signal s_Select : std_logic_vector(2 downto 0);  --final mux select
begin

    process(i_ALUOp)
    begin
        -- Default values to avoid latches
        s_Operator       <= '0';
        s_Lui            <= '0';
        s_ShiftDirection <= '0';
        s_ShiftType      <= '0';
        s_Bne            <= '0';
        s_ShiftUnsigned       <= '1';
        s_Select         <= "000";

        case i_ALUOp is
            when "1110" =>              -- beq
                s_Operator <= '1';
                s_ShiftUnsigned <= '1';
                s_Select   <= "000";

            when "1101" =>              -- bne
                s_Operator <= '1';
                s_Bne      <= '1';
                s_ShiftUnsigned <= '1';
                s_Select   <= "000";

            when "0001" =>              -- addu
                s_ShiftUnsigned <= '0';
                s_Select   <= "000";

            when "0011" =>              -- subu
                s_Operator <= '1';
                s_ShiftUnsigned <= '0';
                s_Select   <= "000";

            when "0010" =>              -- add
                s_ShiftUnsigned <= '1';
                s_Select   <= "000";

            when "1111" =>              -- sub
                s_Operator <= '1';
                s_ShiftUnsigned <= '1';
                s_Select   <= "000";

            when "0100" =>              -- and
                s_ShiftUnsigned <= '1';
                s_Select   <= "011";

            when "0101" =>              -- or
                s_ShiftUnsigned <= '1';
                s_Select   <= "010";

            when "0110" =>              -- xor
                s_ShiftUnsigned <= '1';
                s_Select   <= "100";

            when "0111" =>              -- nor
                s_ShiftUnsigned <= '1';
                s_Select   <= "101";

            when "1001" =>              -- lui
                s_Lui      <= '1';
                s_ShiftUnsigned <= '1';
                s_Select   <= "001";

            when "1000" =>              -- slt
                s_Operator <= '1';
                s_ShiftUnsigned <= '1';
                s_Select   <= "110";

            when "1010" =>              -- sll
                s_ShiftUnsigned <= '1';
                s_Select   <= "001";

            when "1011" =>              -- srl
                s_ShiftUnsigned       <= '1';
                s_ShiftDirection <= '1';
                s_Select         <= "001";

            when "1100" =>              -- sra
                s_ShiftUnsigned       <= '1';
                s_ShiftDirection <= '1';
                s_ShiftType      <= '1';
                s_Select         <= "001";

            when others =>
                -- Defaults already assigned
                null;
        end case;
    end process;

    -- selects shamt or 16(used for lui)
    instLuiMux : mux2t1_N
        generic map(N => 5)
        port map(
            i_S  => s_Lui,
            i_D0 => i_shamt,
            i_D1 => "10000",
            o_O  => s_Shamt
            );

    instBarrelShifter : BarrelShifter
        port map(
            i_data             => i_B,
            i_shamt            => s_Shamt,
            i_left_right       => s_ShiftDirection,
            i_logic_arithmetic => s_ShiftType,
            o_Out              => s_Barrel_Output);

    instAdderSub : AdderSubtractor
        generic map(N => 32)
        port map(
            nAdd_Sub => s_Operator,
            i_A      => i_A,
            i_B      => i_B,
            o_S      => s_Adder_Out,
            o_C      => o_CarryOut,
            o_OF     => s_AdderSubtractorOverflow);

    o_Overflow <= s_AdderSubtractorOverflow and s_ShiftUnsigned;

    instZeroDetector : ZeroDetector
        port map(
            i_F    => s_Adder_Out,
            o_zero => s_zero);

    s_NotZero <= not s_zero;
    o_zero    <= s_NotZero xor s_Bne;

    instLogicGates : logic_N
        generic map(N => 32)
        port map(
            i_A   => i_A,
            i_B   => i_B,
            o_OR  => s_OR,
            o_AND => s_AND,
            o_XOR => s_XOR,
            o_NOR => s_NOR
            );

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
            i_S  => s_Select,
            i_D0 => s_Adder_Out,
            i_D1 => s_Barrel_Output,
            i_D2 => s_OR,
            i_D3 => s_AND,
            i_D4 => s_XOR,
            i_D5 => s_NOR,
            i_D6 => s_set,
            i_D7 => x"00000000",
            o_O  => o_resultF
            );

end mixed;
