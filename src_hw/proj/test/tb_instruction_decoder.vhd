library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity instruction_decoder_tb is
end instruction_decoder_tb;

architecture behavior of instruction_decoder_tb is
    component instruction_decoder
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

    -- Test Signals
    signal s_Instruction : std_logic_vector(31 downto 0) := (others => '0');
    signal s_Opcode     : std_logic_vector(5 downto 0);
    signal s_Rs         : std_logic_vector(4 downto 0);
    signal s_Rt         : std_logic_vector(4 downto 0);
    signal s_Rd         : std_logic_vector(4 downto 0);
    signal s_Shamt      : std_logic_vector(4 downto 0);
    signal s_Funct      : std_logic_vector(5 downto 0);
    signal s_Imm        : std_logic_vector(15 downto 0);
    signal s_Addr       : std_logic_vector(24 downto 0);

    -- Test Status
    signal test_pass    : boolean := true;
    signal test_count   : integer := 0;
    signal error_count  : integer := 0;

    -- Reporting procedure
    procedure report_test(
        signal instruction  : in std_logic_vector(31 downto 0);
        expected_opcode    : in std_logic_vector(5 downto 0);
        expected_rs        : in std_logic_vector(4 downto 0);
        expected_rt        : in std_logic_vector(4 downto 0);
        expected_rd        : in std_logic_vector(4 downto 0);
        expected_shamt     : in std_logic_vector(4 downto 0);
        expected_funct     : in std_logic_vector(5 downto 0);
        expected_imm       : in std_logic_vector(15 downto 0);
        expected_addr      : in std_logic_vector(24 downto 0);
        signal test_pass   : out boolean;
        signal error_count : inout integer;
        test_name          : in string
    ) is
        variable pass : boolean := true;
    begin
        if s_Opcode /= expected_opcode then
            report "Test " & test_name & ": Opcode mismatch. Expected " & 
                   to_hstring(expected_opcode) & " but got " & to_hstring(s_Opcode);
            pass := false;
        end if;
        if s_Rs /= expected_rs then
            report "Test " & test_name & ": Rs mismatch. Expected " & 
                   to_hstring(expected_rs) & " but got " & to_hstring(s_Rs);
            pass := false;
        end if;
        if s_Rt /= expected_rt then
            report "Test " & test_name & ": Rt mismatch. Expected " & 
                   to_hstring(expected_rt) & " but got " & to_hstring(s_Rt);
            pass := false;
        end if;
        if s_Rd /= expected_rd then
            report "Test " & test_name & ": Rd mismatch. Expected " & 
                   to_hstring(expected_rd) & " but got " & to_hstring(s_Rd);
            pass := false;
        end if;
        if s_Shamt /= expected_shamt then
            report "Test " & test_name & ": Shamt mismatch. Expected " & 
                   to_hstring(expected_shamt) & " but got " & to_hstring(s_Shamt);
            pass := false;
        end if;
        if s_Funct /= expected_funct then
            report "Test " & test_name & ": Funct mismatch. Expected " & 
                   to_hstring(expected_funct) & " but got " & to_hstring(s_Funct);
            pass := false;
        end if;
        if s_Imm /= expected_imm then
            report "Test " & test_name & ": Imm mismatch. Expected " & 
                   to_hstring(expected_imm) & " but got " & to_hstring(s_Imm);
            pass := false;
        end if;
        if s_Addr /= expected_addr then
            report "Test " & test_name & ": Addr mismatch. Expected " & 
                   to_hstring(expected_addr) & " but got " & to_hstring(s_Addr);
            pass := false;
        end if;

        if not pass then
            error_count <= error_count + 1;
        end if;
        test_pass <= pass;
    end procedure;

begin
    
    UUT: instruction_decoder
        port map(
            i_Instruction => s_Instruction,
            o_Opcode      => s_Opcode,
            o_Rs          => s_Rs,
            o_Rt          => s_Rt,
            o_Rd          => s_Rd,
            o_Shamt      => s_Shamt,
            o_Funct      => s_Funct,
            o_Imm        => s_Imm,
            o_Addr       => s_Addr
        );

    -- Test Process
    test_proc: process
        -- Test vectors
        type test_vector is record
            instruction : std_logic_vector(31 downto 0);
            opcode     : std_logic_vector(5 downto 0);
            rs         : std_logic_vector(4 downto 0);
            rt         : std_logic_vector(4 downto 0);
            rd         : std_logic_vector(4 downto 0);
            shamt      : std_logic_vector(4 downto 0);
            funct      : std_logic_vector(5 downto 0);
            imm        : std_logic_vector(15 downto 0);
            addr       : std_logic_vector(24 downto 0);
            test_name  : string(1 to 20);
        end record;

        type test_vector_array is array (natural range <>) of test_vector;
        constant test_vectors : test_vector_array := (
            -- R-format instruction (ADD)
            (X"00851020", "000000", "00100", "00101", "00010", "00000", "100000", X"0000", "0000000000000000000000000", "R-format ADD         "),
            -- J-format instruction (J)
            (X"08000100", "000010", "00000", "00000", "00000", "00000", "000000", X"0000", "0000000000000100000000000", "J-format Jump        "),
            -- I-format instruction (ADDI)
            (X"20850064", "001000", "00100", "00101", "00000", "00000", "000000", X"0064", "0000000000000000000000000", "I-format ADDI        "),
            -- JAL instruction
            (X"0C000200", "000011", "00000", "00000", "00000", "00000", "000000", X"0000", "0000000000001000000000000", "J-format JAL         "),
            -- I-format instruction (LW)
            (X"8C050004", "100011", "00000", "00101", "00000", "00000", "000000", X"0004", "0000000000000000000000000", "I-format LW          ")
        );

    begin
        -- Print test header
        report "Starting Instruction Decoder Tests...";
        
        -- Run through all test vectors
        for i in test_vectors'range loop
            test_count <= test_count + 1;
            
            -- Apply test vector
            s_Instruction <= test_vectors(i).instruction;
            wait for 10 ns;  -- Allow for propagation
            
            -- Check results
            report_test(
                s_Instruction,
                test_vectors(i).opcode,
                test_vectors(i).rs,
                test_vectors(i).rt,
                test_vectors(i).rd,
                test_vectors(i).shamt,
                test_vectors(i).funct,
                test_vectors(i).imm,
                test_vectors(i).addr,
                test_pass,
                error_count,
                test_vectors(i).test_name
            );
            
            wait for 10 ns;
        end loop;

        -- Report final results
        if error_count = 0 then
            report "All tests passed successfully!";
        else
            report "Tests completed with " & integer'image(error_count) & 
                   " errors out of " & integer'image(test_count) & " tests.";
        end if;
        
        wait;  -- End simulation
    end process;

end architecture behavior;
