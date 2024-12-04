library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_instruction_decoder is
end entity tb_instruction_decoder;

architecture behavior of tb_instruction_decoder is

    component instruction_decoder is
        port(
            i_Instruction : in  std_logic_vector(31 downto 0);
            o_Opcode      : out std_logic_vector(5 downto 0);
            o_Rs          : out std_logic_vector(4 downto 0);
            o_Rt          : out std_logic_vector(4 downto 0);
            o_Rd          : out std_logic_vector(4 downto 0);
            o_Shamt       : out std_logic_vector(4 downto 0);
            o_Funct       : out std_logic_vector(5 downto 0);
            o_Imm         : out std_logic_vector(15 downto 0);
            o_Addr        : out std_logic_vector(24 downto 0)
        );
    end component;

    signal s_Instruction : std_logic_vector(31 downto 0) := (others => '0');
    signal s_Opcode      : std_logic_vector(5 downto 0);
    signal s_Rs          : std_logic_vector(4 downto 0);
    signal s_Rt          : std_logic_vector(4 downto 0);
    signal s_Rd          : std_logic_vector(4 downto 0);
    signal s_Shamt       : std_logic_vector(4 downto 0);
    signal s_Funct       : std_logic_vector(5 downto 0);
    signal s_Imm         : std_logic_vector(15 downto 0);
    signal s_Addr        : std_logic_vector(24 downto 0);

begin

    UUT: instruction_decoder
        port map(
            i_Instruction => s_Instruction,
            o_Opcode      => s_Opcode,
            o_Rs          => s_Rs,
            o_Rt          => s_Rt,
            o_Rd          => s_Rd,
            o_Shamt       => s_Shamt,
            o_Funct       => s_Funct,
            o_Imm         => s_Imm,
            o_Addr        => s_Addr
        );

    -- Test process
    stimulus_process: process
    begin
        -- R-type Test: add $1, $2, $3
        -- Instruction: 0x00430820
        s_Instruction <= x"00430820";
        wait for 100 ns;
        report "R-type ADD Instruction: 0x00430820";
        report "o_Opcode = " & integer'image(to_integer(unsigned(s_Opcode))) & " (expected 0)";
        report "o_Rs     = " & integer'image(to_integer(unsigned(s_Rs))) & " (expected 2)";
        report "o_Rt     = " & integer'image(to_integer(unsigned(s_Rt))) & " (expected 3)";
        report "o_Rd     = " & integer'image(to_integer(unsigned(s_Rd))) & " (expected 1)";
        report "o_Shamt  = " & integer'image(to_integer(unsigned(s_Shamt))) & " (expected 0)";
        report "o_Funct  = " & integer'image(to_integer(unsigned(s_Funct))) & " (expected 32)";

        -- I-type Test: lw $4, 16($5)
        -- Binary: 100011 00101 00100 0000000000010000
        -- This corresponds to opcode=35 (0x23), rs=5, rt=4, imm=16
        s_Instruction <= b"10001100101001000000000000010000";
        wait for 100 ns;
        report "I-type LW Instruction: 100011 00101 00100 0000000000010000";
        report "o_Opcode = " & integer'image(to_integer(unsigned(s_Opcode))) & " (expected 35)";
        report "o_Rs     = " & integer'image(to_integer(unsigned(s_Rs))) & " (expected 5)";
        report "o_Rt     = " & integer'image(to_integer(unsigned(s_Rt))) & " (expected 4)";
        report "o_Imm    = " & integer'image(to_integer(unsigned(s_Imm))) & " (expected 16)";
        report "o_Addr   = " & integer'image(to_integer(unsigned(s_Addr))) & " (not used for I-type)";

        -- J-type Test: j 0x00000004
        -- Instruction: 0x08000004
        s_Instruction <= x"08000004";
        wait for 100 ns;
        report "J-type J Instruction: 0x08000004";
        report "o_Opcode = " & integer'image(to_integer(unsigned(s_Opcode))) & " (expected 2)";
        report "o_Addr   = " & integer'image(to_integer(unsigned(s_Addr))) & " (expected 4)";
        report "R-type fields, Imm are not used for J-type";

        -- Additional random test:
        -- Let's pick a random 32-bit value: 0xABCDEF01
        -- Just to see how signals split:
        s_Instruction <= x"ABCDEF01";
        wait for 100 ns;
        report "Random Instruction: 0xABCDEF01";
        report "o_Opcode = " & integer'image(to_integer(unsigned(s_Opcode))) & " (check top 6 bits)";
        report "o_Rs     = " & integer'image(to_integer(unsigned(s_Rs)));
        report "o_Rt     = " & integer'image(to_integer(unsigned(s_Rt)));
        report "o_Rd     = " & integer'image(to_integer(unsigned(s_Rd)));
        report "o_Shamt  = " & integer'image(to_integer(unsigned(s_Shamt)));
        report "o_Funct  = " & integer'image(to_integer(unsigned(s_Funct)));
        report "o_Imm    = " & integer'image(to_integer(unsigned(s_Imm)));
        report "o_Addr   = " & integer'image(to_integer(unsigned(s_Addr)));

        wait;
    end process;

end architecture behavior;
