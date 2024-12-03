-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-11-21T11:05:34-06:00 added-old-single-cycle-processor-and-added-documentation-for-the
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;          -- For logic types I/O
use IEEE.numeric_std.all;               -- For to_usnigned
library std;
use std.env.all;                        -- For hierarchical/external signals
use std.textio.all;                     -- For basic I/O
entity tb_control_unit is
    generic
        (gCLK_HPER : time := 50 ns);
end tb_control_unit;
architecture behavior of tb_control_unit is
    constant cCLK_PER : time := gCLK_HPER * 2;
    component control_unit
        port (
            i_opcode    : in  std_logic_vector(5 downto 0);  --opcode value, indicates a J or I type instruction (usually)
            i_funct     : in  std_logic_vector(5 downto 0);  --funct value, indicates an R type instruction
            o_Ctrl_Unit : out std_logic_vector(20 downto 0)  --output/control signals fetched correlating to function
            );
    end component;
    signal s_CLK        : std_logic                     := '0';
    signal s_opcode     : std_logic_vector(5 downto 0)  := (others => '0');
    signal s_funct      : std_logic_vector(5 downto 0)  := (others => '0');
    signal s_Ctrl_Unit  : std_logic_vector(20 downto 0);
    signal expected_out : std_logic_vector(20 downto 0) := (others => '0');
begin
    <<<<<<< HEAD
        --constant running background clock
        P_CLK : process
        begin
            s_CLK <= '0';
            wait for gCLK_HPER;
            s_CLK <= '1';
            wait for gCLK_HPER/2;
        end process;
        DUT : control_unit
            port map(
                i_opcode    => s_opcode,
                i_funct     => s_funct,
                o_Ctrl_Unit => s_Ctrl_Unit
                );
        -- Testbench process  
        P_TB : process
        begin
            -- test add
            s_opcode     <= "000000";
            s_funct      <= "100000";
            expected_out <= "000000000111000110100";
            wait for cCLK_PER/2;
            -- test addu
            s_opcode     <= "000000";
            s_funct      <= "100001";
            expected_out <= "000000000000000110100";
            wait for cCLK_PER/2;
            -- test and
            s_opcode     <= "000000";
            s_funct      <= "100100";
            expected_out <= "000000000001000110100";
            wait for cCLK_PER/2;
            -- test nor
            s_opcode     <= "000000";
            s_funct      <= "100111";
            expected_out <= "000000000010100110100";
            wait for cCLK_PER/2;
            -- test xor
            s_opcode     <= "000000";
            s_funct      <= "100110";
            expected_out <= "000000000010000110100";
            wait for cCLK_PER/2;
            -- test or
            s_opcode     <= "000000";
            s_funct      <= "100101";
            expected_out <= "000000000001100110100";
            wait for cCLK_PER/2;
            -- test slt
            s_opcode     <= "000000";
            s_funct      <= "101010";
            expected_out <= "000000000011100110100";
            wait for cCLK_PER/2;
            -- test sll
            s_opcode     <= "000000";
            s_funct      <= "000000";
            expected_out <= "000000000100100110100";
            wait for cCLK_PER/2;
            -- test srl
            s_opcode     <= "000000";
            s_funct      <= "000010";
            expected_out <= "000000000100000110000";
            wait for cCLK_PER/2;
            -- test sra
            s_opcode     <= "000000";
            s_funct      <= "000011";
            expected_out <= "000000000101000110100";
            wait for cCLK_PER/2;
            -- test sub
            s_opcode     <= "000000";
            s_funct      <= "100010";
            expected_out <= "000000000111100110100";
            wait for cCLK_PER/2;
            -- test subu
            s_opcode     <= "000000";
            s_funct      <= "100011";
            expected_out <= "000000000000100110100";
            wait for cCLK_PER/2;
            -- test addi
            s_opcode     <= "001000";
            s_funct      <= "000000";
            expected_out <= "000000001111000100100";
            wait for cCLK_PER/2;
            -- test addiu
            s_opcode     <= "001001";
            expected_out <= "000000001000000100100";
            wait for cCLK_PER/2;
            -- test andi
            s_opcode     <= "001100";
            expected_out <= "000000001001000100000";
            wait for cCLK_PER/2;
            -- test xori
            s_opcode     <= "001110";
            expected_out <= "000000001010000100000";
            wait for cCLK_PER/2;
            -- test ori
            s_opcode     <= "001101";
            expected_out <= "000000001001100100000";
            wait for cCLK_PER/2;
            -- test slti
            s_opcode     <= "001010";
            expected_out <= "000000001011100100100";
            wait for cCLK_PER/2;
            -- test lui
            s_opcode     <= "001111";
            expected_out <= "000000001011000100100";
            wait for cCLK_PER/2;
            -- test beq
            s_opcode     <= "000100";
            expected_out <= "000000000101100001100";
            wait for cCLK_PER/2;
            -- test bne
            s_opcode     <= "000101";
            expected_out <= "000000000110000001100";
            wait for cCLK_PER/2;
            -- test lw
            s_opcode     <= "100011";
            expected_out <= "000000001000010100100";
            wait for cCLK_PER/2;
            -- test sw
            s_opcode     <= "101011";
            expected_out <= "000000001000001000100";
            wait for cCLK_PER/2;
            -- test j
            s_opcode     <= "000010";
            expected_out <= "000000000000000000110";
            wait for cCLK_PER/2;
            -- test jal
            s_opcode     <= "000011";
            expected_out <= "000000010000000100110";
            wait for cCLK_PER/2;
            -- test jr
            s_opcode     <= "000000";
            s_funct      <= "001000";
            expected_out <= "000000100000000000110";
            wait for cCLK_PER/2;
            -- test halt
            s_opcode     <= "010100";
            s_funct      <= "000000";
            expected_out <= "000000000000000000001";
            wait for cCLK_PER/2;
            wait;
        end process;
        =======
            --constant running background clock
            P_CLK : process
            begin
                s_CLK <= '0';
                wait for gCLK_HPER;
                s_CLK <= '1';
                wait for gCLK_HPER/2;
            end process;
            DUT : control_unit
                port map(
                    i_opcode    => s_opcode,
                    i_funct     => s_funct,
                    o_Ctrl_Unit => s_Ctrl_Unit
                    );
            -- Testbench process  
            P_TB : process
            begin
                -- test add
                s_opcode     <= "000000";
                s_funct      <= "100000";
                expected_out <= "000000000001000110100";  --X"000234"--"000000000111000110100";
                wait for cCLK_PER/2;
                -- test addu
                s_opcode     <= "000000";
                s_funct      <= "100001";
                expected_out <= "000000000000000110100";
                wait for cCLK_PER/2;
                -- test and
                s_opcode     <= "000000";
                s_funct      <= "100100";
                expected_out <= "000000000010100110100";  --X"000534"(20 downto 0);--"000000000001000110100";
                wait for cCLK_PER/2;
                -- test nor
                s_opcode     <= "000000";
                s_funct      <= "100111";
                expected_out <= "000000000100000110100";  --X"000834"(20 downto 0);--"000000000010100110100";
                wait for cCLK_PER/2;
                -- test xor
                s_opcode     <= "000000";
                s_funct      <= "100110";
                expected_out <= "000000000101000110100";  --X"000A34"(20 downto 0);--"000000000010000110100";
                wait for cCLK_PER/2;
                -- test or
                s_opcode     <= "000000";
                s_funct      <= "100101";
                expected_out <= "000000000100100110100";  --X"000934"(20 downto 0);--"000000000001100110100";
                wait for cCLK_PER/2;
                -- test slt
                s_opcode     <= "000000";
                s_funct      <= "101010";
                expected_out <= "000000000011100110100";
                wait for cCLK_PER/2;
                -- test sll
                s_opcode     <= "000000";
                s_funct      <= "000000";
                expected_out <= "000000000010000110100";  --X"000434"(20 downto 0);--"000000000100100110100";
                wait for cCLK_PER/2;
                -- test srl
                s_opcode     <= "000000";
                s_funct      <= "000010";
                expected_out <= "000000000110000110000";  --X"000C30"(20 downto 0);--"000000000100000110000";
                wait for cCLK_PER/2;
                -- test sra
                s_opcode     <= "000000";
                s_funct      <= "000011";
                expected_out <= "000000000111000110100";  --X"000E34"(20 downto 0);--"000000000101000110100";
                wait for cCLK_PER/2;
                -- test sub
                s_opcode     <= "000000";
                s_funct      <= "100010";
                expected_out <= "000000000001100110100";  --X"000334"(20 downto 0);--"000000000111100110100";
                wait for cCLK_PER/2;
                -- test subu
                s_opcode     <= "000000";
                s_funct      <= "100011";
                expected_out <= "000000000000100110100";
                wait for cCLK_PER/2;
                -- test addi
                s_opcode     <= "001000";
                s_funct      <= "000000";
                expected_out <= "000000001001000100100";  --X"001224"(20 downto 0);--"000000001111000100100";
                wait for cCLK_PER/2;
                -- test addiu
                s_opcode     <= "001001";
                expected_out <= "000000001000000100100";
                wait for cCLK_PER/2;
                -- test andi
                s_opcode     <= "001100";
                expected_out <= "000000001010100100000";  --X"001520"(20 downto 0);--"000000001001000100000";
                wait for cCLK_PER/2;
                -- test xori
                s_opcode     <= "001110";
                expected_out <= "000000001101000100000";  --001A20"000000001010000100000";
                wait for cCLK_PER/2;
                -- test ori
                s_opcode     <= "001101";
                expected_out <= "000000001100100100000";  --1920"000000001001100100000";
                wait for cCLK_PER/2;
                -- test slti
                s_opcode     <= "001010";
                expected_out <= "000000001011100100100";
                wait for cCLK_PER/2;
                -- test lui
                s_opcode     <= "001111";
                expected_out <= "000001001010000100100";  --009424"000000001011000100100";
                wait for cCLK_PER/2;
                -- test beq
                s_opcode     <= "000100";
                expected_out <= "000000000000100001100";  --10c"000000000101100001100";
                wait for cCLK_PER/2;
                -- test bne
                s_opcode     <= "000101";
                expected_out <= "000100000000100000100";  --20104"000000000110000001100";
                wait for cCLK_PER/2;
                -- test lw
                s_opcode     <= "100011";
                expected_out <= "000000001000010100100";
                wait for cCLK_PER/2;
                -- test sw
                s_opcode     <= "101011";
                expected_out <= "000000001000001000100";
                wait for cCLK_PER/2;
                -- test j
                s_opcode     <= "000010";
                expected_out <= "000000000000000000110";
                wait for cCLK_PER/2;
                -- test jal
                s_opcode     <= "000011";
                expected_out <= "000000010000000100110";
                wait for cCLK_PER/2;
                -- test jr
                s_opcode     <= "000000";
                s_funct      <= "001000";
                expected_out <= "000000100000000000110";
                wait for cCLK_PER/2;
                -- test halt
                s_opcode     <= "010100";
                s_funct      <= "000000";
                expected_out <= "000000000000000000001";
                wait for cCLK_PER/2;
                wait;
            end process;
            >>>>>>> 7725d5d (making the tb look like it was right, potentially undo this later)
            end behavior;

