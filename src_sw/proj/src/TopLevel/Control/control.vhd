library IEEE;
use IEEE.std_logic_1164.all;

entity control_unit is
  port (
    -- Instruction inputs
    i_opcode    : in std_logic_vector(5 downto 0);  -- Opcode from MIPS instruction memory (s_Instr[31-26])
    i_funct     : in std_logic_vector(5 downto 0);  -- Function code for certain instructions with same opcode
    i_rt        : in std_logic_vector(4 downto 0);  -- RT field helps determine branch type   

    -- Control signal outputs
    o_RegWr     : out std_logic;                    -- Register write enable
    o_RegDst    : out std_logic_vector(1 downto 0); -- Register destination
    o_sign_ext_en  : out std_logic;                 -- Sign extension enable
    o_jump      : out std_logic_vector(1 downto 0); -- Controls address for jump
    o_MemSel    : out std_logic_vector(1 downto 0); -- Select write back source, either data memory, ALU, or PC+4
    o_branchCtl : out std_logic;                    -- ANDed with branch signal from ALU to determine if branch is taken
    o_BranchType: out std_logic_vector(2 downto 0); -- Tells Branch control what branch type we want to do
    o_ALUSrc    : out std_logic;                    -- ALU source
    o_ALUOp     : out std_logic_vector(2 downto 0); -- Used by ALU control to determine ALU operation
    o_MemWr     : out std_logic;                    -- Data Memory write enable
    o_Halt      : out std_logic                     --Indicates program execution finished
  );
end control_unit;

architecture dataflow of control_unit is
  signal s_RegWrite : std_logic;
begin

  -- Register destination            
  o_RegDst <= "01" when i_opcode = b"000000" else              -- R-type (rd)          
              "10" when (i_opcode = b"000001" and (i_rt = b"10001" or i_rt = b"10000")) or i_opcode = b"000011" else -- jal or branch and link
              "00"; -- else, use rt

  -- Adjust jump signals based on function code
  -- Jr is an R-type so opcode is 0, but we don't want to set jump for every r-type
  o_jump <= "10" when (i_funct = b"001000" and i_opcode = b"000000") else -- jr
            "01" when i_opcode = b"000010" else --j
            "01" when i_opcode = b"000011" else --jal
            "00"; --Everything else

  -- Register write enable
  --TODO fix this to work right with bgezal, bltzal, and jr
  s_RegWrite <= '0' when i_funct = b"001000" and i_opcode = b"000000" else
                '1' when o_jump = b"01" and o_RegDst = b"10" else
                '0' when o_RegDst = b"10" else
                '0' when i_opcode = b"000010" or 
                  i_opcode = b"000100" or 
                  i_opcode = b"000101" or 
                  i_opcode = b"000110" or 
                  i_opcode = b"000111" or 
                  i_opcode = b"000100" or
                  i_opcode = b"000101" or
                  i_opcode = b"101011" else
                '0' when i_opcode = b"000001" and o_jump = b"00" else
                '1';
o_RegWr <= s_RegWrite;
    
  with i_opcode select
    -- Sign extension enable
    o_sign_ext_en <=  '0' when b"000000" | b"001100" | b"001110" | b"001101" | b"000010" | b"000011",
                      '1' when others;
    
  with i_opcode select
    -- Select write back source, either data memory, ALU, or PC+4          
    o_MemSel <= "11" when b"001111",
                "01" when b"100011",              -- lw
                "10" when b"000011" | b"000001", -- branch and jal
                "00" when others;                 -- else, use ALU result

  p_BranchType: process(i_rt, i_opcode) begin
    case i_opcode is
      when b"000100" => o_BranchType <= b"000";
      when b"000101" => o_BranchType <= b"001";
      when b"000001" =>
        if (i_rt = b"00001" or i_rt = b"10001") then 
          o_BranchType <= b"010";
        elsif (i_rt = b"10000" or i_rt = b"00000") then
          o_BranchType <= b"101";
        end if;
      when b"000111" => o_BranchType <= b"011";
      when b"000110" => o_BranchType <= b"100";
      --Unused value
      when others => o_BranchType <= b"111";
      end case;
  end process;

  with i_opcode select
    -- ALU source
    o_ALUSrc <= '0' when b"000000" | b"000100" | b"000101",
                '1' when others;

  with i_opcode select
    -- Determine ALU operation
    o_ALUOp <= "000" when b"000000",
               "001" when b"001000",
               "010" when b"001001" | b"001111" | b"100011" | b"101011",
               "011" when b"001100",
               "100" when b"001110",
               "101" when b"001101",
               "110" when b"001010",
               "000" when others;
    
  -- Data Memory write enable
  with i_opcode select
    o_MemWr <= '1' when b"101011", -- sw
               '0' when others;

  -- Halt instruction: Stop program execution
  with i_opcode select
    o_Halt <= '1' when b"010100",
              '0' when others;

  p_branch: process(i_opcode, s_RegWrite) begin
    case? i_opcode is 
      when b"000000" =>
        if s_RegWrite = '0' then
          o_branchCtl <= '1';
        else
          o_branchCtl <= '0';
        end if;
      when b"000001" => o_branchCtl <= '1';
      when b"0001--" => o_branchCtl <= '1';
      when b"00001-" => o_branchCtl <= '1';
      when others => o_branchCtl <= '0';
    end case?;
  end process;
end architecture;
