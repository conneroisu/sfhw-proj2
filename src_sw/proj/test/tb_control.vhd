-- <header>
-- Author(s): Conner Ohnesorge
-- Name: src_sw/proj/test/tb_control.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-21T09:31:56-06:00 removed-unused-uncompleted-files-and-implemented-control-unit-for-software-pipeline
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_control_unit is
end tb_control_unit;

architecture structural of tb_control_unit is
    component control_unit is
        port (
            -- Instruction inputs
            i_opcode : in std_logic_vector(5 downto 0);  -- Opcode from MIPS instruction memory (s_Instr[31-26])
            i_funct  : in std_logic_vector(5 downto 0);  -- Function code for certain instructions with same opcode
            i_rt     : in std_logic_vector(4 downto 0);  -- RT field helps determine branch type   

            -- Control signal outputs
            o_RegWr       : out std_logic;  -- Register write enable
            o_RegDst      : out std_logic_vector(1 downto 0);  -- Register destination
            o_sign_ext_en : out std_logic;  -- Sign extension enable
            o_jump        : out std_logic_vector(1 downto 0);  -- Controls address for jump
            o_MemSel      : out std_logic_vector(1 downto 0);  -- Select write back source, either data memory, ALU, or PC+4
            o_branchCtl   : out std_logic;  -- ANDed with branch signal from ALU to determine if branch is taken
            o_BranchType  : out std_logic_vector(2 downto 0);  -- Tells Branch control what branch type we want to do
            o_ALUSrc      : out std_logic;  -- ALU source
            o_ALUOp       : out std_logic_vector(2 downto 0);  -- Used by ALU control to determine ALU operation
            o_MemWr       : out std_logic;  -- Data Memory write enable
            o_Halt        : out std_logic  --Indicates program execution finished
            );
    end component;

    -- Instruction inputs
    signal s_iOpcode : std_logic_vector(5 downto 0);  -- 6-bit MIPS opcode from instruction memory
    signal s_iFunct  : std_logic_vector(5 downto 0);  -- 6-bit MIPS function code from instr memory
    signal s_iRt     : std_logic_vector(4 downto 0);

    -- Control signals
    signal s_oRegWr      : std_logic;
    signal s_oRegDst     : std_logic_vector(1 downto 0);
    signal s_oSignExtEn  : std_logic;
    signal s_oJump       : std_logic_vector(1 downto 0);
    signal s_oMemSel     : std_logic_vector(1 downto 0);
    signal s_oBranchCtl  : std_logic;
    signal s_oBranchType : std_logic_vector(2 downto 0);
    signal s_oALUSrc     : std_logic;
    signal s_oALUOp      : std_logic_vector(2 downto 0);
    signal s_oMemWr      : std_logic;
    signal s_oHalt       : std_logic;


begin
    DUT0 : control_unit port map(
        i_opcode      => s_iOpcode,
        i_funct       => s_iFunct,
        i_rt          => s_iRt,
        o_RegWr       => s_oRegWr,
        o_RegDst      => s_oRegDst,
        o_sign_ext_en => s_oSignExtEn,
        o_jump        => s_oJump,
        o_MemSel      => s_oMemSel,
        o_branchCtl   => s_oBranchCtl,
        o_BranchType  => s_oBranchType,
        o_ALUSrc      => s_oALUSrc,
        o_ALUOp       => s_oALUOp,
        o_MemWr       => s_oMemWr,
        o_Halt        => s_oHalt
        );

    -- Testbench process - Opcodes from Processor Spreadsheet
    P_TEST : process
    begin
        -- add
        s_iOpcode <= "000000";
        s_iFunct  <= "100000";
        wait for 5 ns;

        -- addi 
        s_iOpcode <= "001000";
        wait for 5 ns;

        -- addiu
        s_iOpcode <= "001001";
        wait for 5 ns;

        -- addu
        s_iOpcode <= "000000";
        s_iFunct  <= "100001";
        wait for 5 ns;

        -- and
        s_iOpcode <= "000000";
        s_iFunct  <= "100100";
        wait for 5 ns;

        -- andi
        s_iOpcode <= "001100";
        wait for 5 ns;

        -- lui
        s_iOpcode <= "001111";
        wait for 5 ns;

        -- lw
        s_iOpcode <= "100011";
        wait for 5 ns;

        -- nor
        s_iOpcode <= "000000";
        s_iFunct  <= "100111";
        wait for 5 ns;

        -- xor
        s_iOpcode <= "000000";
        s_iFunct  <= "100110";
        wait for 5 ns;

        -- xori
        s_iOpcode <= "001110";
        wait for 5 ns;

        -- or
        s_iOpcode <= "000000";
        s_iFunct  <= "100101";
        wait for 5 ns;

        -- ori
        s_iOpcode <= "001101";
        wait for 5 ns;

        -- slt
        s_iOpcode <= "000000";
        s_iFunct  <= "101010";
        wait for 5 ns;

        -- slti
        s_iOpcode <= "001010";
        wait for 5 ns;

        -- sll
        s_iOpcode <= "000000";
        s_iFunct  <= "000000";
        wait for 5 ns;

        -- srl
        s_iOpcode <= "000000";
        s_iFunct  <= "000010";
        wait for 5 ns;

        -- sra
        s_iOpcode <= "000000";
        s_iFunct  <= "000011";
        wait for 5 ns;

        -- sw
        s_iOpcode <= "101011";
        wait for 5 ns;

        -- sub
        s_iOpcode <= "000000";
        s_iFunct  <= "100010";
        wait for 5 ns;

        -- subu
        s_iOpcode <= "000000";
        s_iFunct  <= "100011";
        wait for 5 ns;

        -- beq
        s_iOpcode <= "000100";
        wait for 5 ns;

        -- bne
        s_iOpcode <= "000101";
        wait for 5 ns;

        -- j
        s_iOpcode <= "000010";
        wait for 5 ns;

        -- jal
        s_iOpcode <= "000011";
        wait for 5 ns;

        -- jr
        s_iOpcode <= "000000";
        s_iFunct  <= "001000";
        wait for 5 ns;

        -- bgez
        s_iOpcode <= "000001";
        s_iRt     <= "00001";
        wait for 5 ns;

        -- bgezal
        s_iOpcode <= "000001";
        s_iRt     <= "10001";
        wait for 5 ns;

        -- bgtz
        s_iOpcode <= "000111";
        s_iRt     <= "00000";
        wait for 5 ns;

        -- blez
        s_iOpcode <= "000110";
        s_iRt     <= "00000";
        wait for 5 ns;

        -- bltzal
        s_iOpcode <= "000001";
        s_iRt     <= "00000";
        wait for 5 ns;

        -- bltz
        s_iOpcode <= "000001";
        s_iRt     <= "00000";
        wait for 5 ns;

        -- halt
        s_iOpcode <= "010100";
        wait for 5 ns;
        wait;
    end process;
end structural;

