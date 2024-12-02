-- <header>
-- Author(s): Conner Ohnesorge
-- Name: src_sc/proj/src/TopLevel/MIPS_Processor.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-21T11:05:34-06:00 added-old-single-cycle-processor-and-added-documentation-for-the
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.MIPS_types.all;

entity MIPS_Processor is
    generic(N : integer := DATA_WIDTH);
    
    port(
         iCLK      : in  std_logic;
         iRST      : in  std_logic;
         iInstLd   : in  std_logic;
         iInstAddr : in  std_logic_vector(N-1 downto 0);
         iInstExt  : in  std_logic_vector(N-1 downto 0);
         oALUOut   : out std_logic_vector(N-1 downto 0)
     );  
    
end MIPS_Processor;

architecture structure of MIPS_Processor is
 type state_type is (Fetch, Decode, Execute, Memory, WriteBack);
    signal current_state, next_state : state_type;
    -- Required data memory signals
    signal s_DMemWr       : std_logic;
    signal s_DMemAddr     : std_logic_vector(N-1 downto 0);
    signal s_DMemData     : std_logic_vector(N-1 downto 0);
    signal s_DMemOut      : std_logic_vector(N-1 downto 0);
    -- Required register file signals 
    signal s_RegWr        : std_logic;  -- TODO: use this signal as the final active high write enable input to the register file
    signal s_RegWrAddr    : std_logic_vector(4 downto 0);  -- TODO: use this signal as the final destination register address input
    signal s_RegWrData    : std_logic_vector(N-1 downto 0);  -- TODO: use this signal as the final data memory data input
    -- Required instruction memory signals
    signal s_IMemAddr     : std_logic_vector(N-1 downto 0);  -- Do not assign this signal, assign to s_NextInstAddr instead
    signal s_NextInstAddr : std_logic_vector(N-1 downto 0);  -- TODO: use this signal as your intended final instruction memory address input.
    signal s_Inst         : std_logic_vector(N-1 downto 0);  -- TODO: use this signal as the instruction signal 
    -- Required halt signal -- for simulation
    signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)
    -- Required overflow signal -- for overflow exception detection
    signal s_Ovfl         : std_logic;  -- TODO: this signal indicates an overflow exception would have been initiated
    component mem is
        generic(
            ADDR_WIDTH : integer;
            DATA_WIDTH : integer
            );
        port(
            clk  : in  std_logic;
            addr : in  std_logic_vector((ADDR_WIDTH-1) downto 0);
            data : in  std_logic_vector((DATA_WIDTH-1) downto 0);
            we   : in  std_logic := '1';
            q    : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;
    component register_file is
        port(
            clk   : in  std_logic;      --------------------- Clock.
            i_wA  : in  std_logic_vector(4 downto 0);      -- Write address.
            i_wD  : in  std_logic_vector(31 downto 0);     -- Write data.
            i_wC  : in  std_logic;      --------------------- Write control.
            i_r1  : in  std_logic_vector(4 downto 0);      -- Read address 1.
            i_r2  : in  std_logic_vector(4 downto 0);      -- Read address 2.
            reset : in  std_logic;      --------------------- Reset.
            o_d1  : out std_logic_vector(31 downto 0);     -- Read data 1.
            o_d2  : out std_logic_vector(31 downto 0)      -- Read data 2.
            );
    end component;
    component program_counter is
        port (
            i_CLK : in  std_logic;      --------------------- Clock.
            i_RST : in  std_logic;      --------------------- Reset.
            i_D   : in  std_logic_vector(31 downto 0);     -- Data.
            o_Q   : out std_logic_vector(31 downto 0)      -- Output.
            );
    end component;
    component adderSubtractor is
        generic
            (N : integer := 32);
        port (
            nAdd_Sub : in  std_logic;  ------------------------- 0 for add, 1 for subtract
            i_S      : in  std_logic;  ------------------------- signed or unsigned operations
            i_A      : in  std_logic_vector(N - 1 downto 0);  -- input a
            i_B      : in  std_logic_vector(N - 1 downto 0);  -- input b
            o_Y      : out std_logic_vector(N - 1 downto 0);  -- output y
            o_Cout   : out std_logic    ------------------------ carry out
            );
    end component;
    component extender16t32 is
        port (
            i_I : in  std_logic_vector(15 downto 0);       -- Input.
            i_C : in  std_logic;  --------------------------- 0 for zero, 1 for signextension.
            o_O : out std_logic_vector(31 downto 0)  -- Output.
            );
    end component;
    component extender8t32 is
        port (
            i_I : in  std_logic_vector(7 downto 0);  -- Data value input
            i_C : in  std_logic;  --------------------- 0 for zero, 1 for signextension
            o_O : out std_logic_vector(31 downto 0)  -- Data value output
            );
    end component;
    component mux2t1_N is
        generic (N : integer := 32);
        port (
            i_S  : in  std_logic;       --------------------- Select input
            i_D0 : in  std_logic_vector(N - 1 downto 0);   -- Data input 0
            i_D1 : in  std_logic_vector(N - 1 downto 0);   -- Data input 1
            o_O  : out std_logic_vector(N - 1 downto 0)    -- Output data
            );
    end component;
    component alu is
        port(
            CLK        : in  std_logic;
            i_Data1    : in  std_logic_vector(31 downto 0);
            i_Data2    : in  std_logic_vector(31 downto 0);
            i_shamt    : in  std_logic_vector(4 downto 0);
            i_aluOp    : in  std_logic_vector(3 downto 0);
            o_F        : out std_logic_vector(31 downto 0);
            o_Overflow : out std_logic;
            o_Zero     : out std_logic
            );
    end component;
    component control_unit is
        port
            (
                i_opcode    : in  std_logic_vector(5 downto 0);  -- in std_logic_vector(5 downto 0);
                i_funct     : in  std_logic_vector(5 downto 0);  -- in std_logic_vector(5 downto 0);
                o_Ctrl_Unit : out std_logic_vector(20 downto 0)  -- out std_logic_vector(14 downto 0)); (all the control signals needed lumped into 1 vector)
                );
    end component;
    -- ==========================================================================
    -- Internal Signals
    -- ==========================================================================
    signal s_RegOutReadData1, s_DMemOut1              : std_logic_vector(N - 1 downto 0);
    signal s_RegInReadData1, s_RegInReadData2, s_RegD : std_logic_vector(4 downto 0);
    signal s_shamt, s_lui_shamt, s_alu_shamt          : std_logic_vector(4 downto 0);
    signal s_imm16                                    : std_logic_vector(15 downto 0);  -- instruction bits [15-0]
    signal s_imm32                                    : std_logic_vector(31 downto 0);  -- after extension
    signal s_imm32x4                                  : std_logic_vector(31 downto 0);  -- after multiplication
    signal s_immMuxOut                                : std_logic_vector(N - 1 downto 0);  -- output of Immediate Mux (ALU 2nd input)
    signal s_opCode                                   : std_logic_vector(5 downto 0);  --instruction bits[31-26] 
    signal s_funcCode                                 : std_logic_vector(5 downto 0);  --instruction bits[5-0]
    signal s_inputPC                                  : std_logic_vector(31 downto 0);  -- wire from the jump mux
    signal s_Ctrl                                     : std_logic_vector(20 downto 0);  -- control brick output, each bit is a different switch
    signal s_ALUSrc                                   : std_logic;  -- alu source
    signal s_jr, s_shamt_s, s_lui                     : std_logic;
    signal s_jal                                      : std_logic;  -- jump and link
    signal s_ALUOp                                    : std_logic_vector(3 downto 0);  -- alu code
    signal s_MemtoReg                                 : std_logic;  -- memory to register
    signal s_RegDst                                   : std_logic;  -- register destination
    signal s_Branch, s_BranchNE                       : std_logic;  -- branch
    signal s_SignExt                                  : std_logic;  -- sign extend
    signal s_jump                                     : std_logic;  -- jump
    signal s_PCPlusFour                               : std_logic_vector(N - 1 downto 0);  -- pc + 4
    signal s_jumpAddress                              : std_logic_vector(N - 1 downto 0);  -- jump address
    signal s_branchAddress                            : std_logic_vector(N - 1 downto 0);  -- branch address
    signal s_MemToReg0                                : std_logic_vector(31 downto 0);  -- memory to register 0
    signal s_RegDst0                                  : std_logic_vector(4 downto 0);  -- register destination 0
    signal s_normalOrBranch, s_finalJumpAddress       : std_logic_vector(31 downto 0);
    signal s_ALUBranch, s_abnormal, s_HorBExt, s_HorB : std_logic;
    signal s_lb1or0, s_lb3or2, s_lbUorL               : std_logic_vector(7 downto 0);  -- lb and lbu raw signals
    signal s_lhUorL                                   : std_logic_vector(15 downto 0);  -- lh and lhu raw signals
    signal s_bSelect                                  : std_logic_vector(1 downto 0);  --lb & lh selectors
    signal s_lb_word, s_lh_word, s_lbOrlh             : std_logic_vector(31 downto 0);  --extended selected signal
    signal s_nil1, s_nil2                             : std_logic;
  -- Internal signals for multicycle operation
    signal IR            : std_logic_vector(N-1 downto 0); -- Instruction Register
    signal MDR           : std_logic_vector(N-1 downto 0); -- Memory Data Register
    signal A, B          : std_logic_vector(N-1 downto 0); -- Register operands
    signal ALUOut        : std_logic_vector(N-1 downto 0); -- ALU output register
    signal PC            : std_logic_vector(N-1 downto 0); -- Program Counter
    signal s_PCWrite     : std_logic;
    signal s_IRWrite     : std_logic;
    signal s_MemRead     : std_logic;
    signal s_MemWrite    : std_logic;
begin
    -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
    with iInstLd select
        s_IMemAddr <= s_NextInstAddr when '0',
        iInstAddr                    when others;
    IMem : mem
        generic map(ADDR_WIDTH => 10,
                    DATA_WIDTH => N)
        port map(clk  => iCLK,
                 addr => s_IMemAddr(11 downto 2),
                 data => iInstExt,
                 we   => iInstLd,
                 q    => s_Inst);
    DMem : mem
        generic
        map(
            ADDR_WIDTH => ADDR_WIDTH,   -- 1024 words
            DATA_WIDTH => N             -- 32 bits
            )
        port
        map(
            clk  => iCLK,               -- Clock.
            addr => s_DMemAddr(11 downto 2),  -- Address
            data => s_DMemData,         -- Data.
            we   => s_DMemWr,           -- Write enable.
            q    => s_DMemOut           -- Output.
            );

    -- Program Counter logic
    process(iCLK, iRST)
    begin
        if iRST = '1' then
            PC <= (others => '0');
        elsif rising_edge(iCLK) then
            if s_PCWrite = '1' then
                PC <= s_NextInstAddr;
            end if;
        end if;
    end process;

    -- Instruction Fetch and Decode logic
    process(iCLK, iRST)
    begin
        if iRST = '1' then
            current_state <= Fetch;
        elsif rising_edge(iCLK) then
            current_state <= next_state;
        end if;
    end process;

    -- State Machine for Multicycle Operation
    process(current_state)
    begin
        -- Default control signal values
        s_PCWrite   <= '0';
        s_IRWrite   <= '0';
        s_MemRead   <= '0';
        s_MemWrite  <= '0';
        s_RegWr     <= '0';
        s_DMemWr    <= '0';
        s_DMemData  <= (others => '0');
        s_DMemAddr  <= (others => '0');
        s_RegWrAddr <= (others => '0');
        s_RegWrData <= (others => '0');
        s_NextInstAddr <= PC + 4;

        case current_state is

            when Fetch =>
                s_MemRead <= '1';
                s_IRWrite <= '1';
                s_PCWrite <= '1';
                next_state <= Decode;

            when Decode =>
                -- No control signals asserted
                -- In software-scheduled, the compiler ensures correct operand availability
                next_state <= Execute;

            when Execute =>
                -- Execute instruction based on opcode
                -- ALU operations, branch calculations, etc.
                -- Control signals would be set based on instruction type
                next_state <= Memory;

            when Memory =>
                -- Memory access if needed
                -- s_MemRead or s_MemWrite would be asserted
                next_state <= WriteBack;

            when WriteBack =>
                -- Write results back to registers if needed
                s_RegWr <= '1';
                next_state <= Fetch;

            when others =>
                next_state <= Fetch;

        end case;
    end process;

    -- Instruction Register
    process(iCLK)
    begin
        if rising_edge(iCLK) then
            if s_IRWrite = '1' then
                IR <= s_Inst;
            end if;
        end if;
    end process;

    -- Memory Data Register
    process(iCLK)
    begin
        if rising_edge(iCLK) then
            if s_MemRead = '1' then
                MDR <= s_DMemOut;
            end if;
        end if;
    end process;

    -- ALU and Register Operations
    -- Similar to single-cycle but operations are distributed over multiple cycles

    -- Register File
    registers : register_file
        port map(
            clk   => iCLK,
            i_wA  => s_RegWrAddr,
            i_wD  => s_RegWrData,
            i_wC  => s_RegWr,
            i_r1  => IR(25 downto 21), -- rs
            i_r2  => IR(20 downto 16), -- rt
            reset => iRST,
            o_d1  => A,
            o_d2  => B
        );

    -- ALU Operations
    arithmeticLogicUnit : alu
        port map(
            CLK        => iCLK,
            i_Data1    => A,
            i_Data2    => B, -- Or immediate value based on instruction
            i_aluOp    => "0000", -- ALU operation code determined by instruction
            i_shamt    => IR(10 downto 6),
            o_F        => ALUOut,
            o_OverFlow => s_Ovfl,
            o_Zero     => open
        );

    -- Update output
    oALUOut <= ALUOut;
    -- ==========================================================================
    -- Instruction Fetch (IF)
    -- ==========================================================================
    programCounter : program_counter
        port map(
            i_CLK => iCLK,              -- Clock.
            i_RST => iRST,              -- Reset.
            i_D   => s_inputPC,         -- Data.
            o_Q   => s_NextInstAddr     -- Output.
            );
    -- addFour adds 4 to the instruction address.
    addFour : adderSubtractor
        generic map(N => 32)
        port map(
            i_S      => '1',
            nAdd_Sub => '0',
            i_A      => s_IMemAddr,
            i_B      => x"00000004",
            o_Y      => s_PCPlusFour,
            o_Cout   => s_nil1
            );
    -- instructionSlice snips the Instruction data into smaller parts
    instructionSlice : process (s_Inst)  -- snip the Instruction data into smaller parts
    begin
        s_imm16(15 downto 0)         <= s_Inst(15 downto 0);  -- bits[15-0] into Sign Extender
        s_funcCode(5 downto 0)       <= s_Inst(5 downto 0);  -- bits[5-0] into ALU Control 
        s_shamt(4 downto 0)          <= s_Inst(10 downto 6);  -- bits[1--6] into ALU (for Barrel Shifter) 
        s_regD(4 downto 0)           <= s_Inst(15 downto 11);  -- bits[11-15] into RegDstMux bits[4-0]
        s_RegInReadData2(4 downto 0) <= s_Inst(20 downto 16);  -- bits[16-20] into RegDstMux and Register (bits[4-0])
        s_RegInReadData1(4 downto 0) <= s_Inst(25 downto 21);  -- bits[25-21] into Register (bits[4-0])
        s_opCode(5 downto 0)         <= s_Inst(31 downto 26);  -- bits[26-31] into Control Brick (bits[5-0)
        s_jumpAddress(0)             <= '0';
        s_jumpAddress(1)             <= '0';  -- Set first two bits to zero
        s_jumpAddress(27 downto 2)   <= s_Inst(25 downto 0);  -- Instruction bits[25-0] into bits[27-2] of jumpAddr
    end process;
    -- ==========================================================================
    -- Instruction Decode (ID)
    -- ==========================================================================
    -- registers is a register file
    registers : register_file
        port map(
            clk   => iCLK,
            i_wA  => s_RegWrAddr,
            i_wD  => s_RegWrData,
            i_wC  => s_RegWr,
            i_r1  => s_RegInReadData1,
            i_r2  => s_RegInReadData2,
            reset => iRST,
            o_d1  => s_RegOutReadData1,
            o_d2  => s_DMemData
            );
    control : control_unit  -- grabs the fields from the instruction after decoding that translate to control signals
        port map(
            i_opcode    => s_opCode,    -- in std_logic_vector(5 downto 0);
            i_funct     => s_funcCode,  -- in std_logic_vector(5 downto 0);
            o_Ctrl_Unit => s_Ctrl  -- out std_logic_vector(14 downto 0)); (all the control signals needed lumped into 1 vector)
            );
    -- ==========================================================================
    -- Extenders [begin] 3 Total
    -- ==========================================================================
    -- signExtender sign extends the immediate signal before it goes into the mainALU.
    signExtender : extender16t32
        port map(
            i_I => s_imm16,   ---- in std_logic_vector(15 downto 0);    
            i_C => s_SignExt,  --- in std_logic; 0 for zero, 1 for signextension
            o_O => s_imm32);  ---- out std_logic_vector(31 downto 0);   
    byteExtender : extender8t32         -- extends the byte to a word width
        port map(
            i_I => s_lbUorL,            -- holds upper or lower byte
            i_C => s_HorBExt,
            o_O => s_lb_word);
    halfExtender : extender16t32        -- extends the half to a word width
        port map(
            i_I => s_lhUorL,            -- holds upper or lower half
            i_C => s_HorBExt,
            o_O => s_lh_word);
    -- ==========================================================================
    -- Muxes [begin] 16 Total
    -- ==========================================================================
    -- luiShamt determines if ALU gets hardcoded lui shamt immediate or normal immediate value.
    luiShamt : mux2t1_N
        generic map(N => 5)
        port map(
            i_S  => s_lui,  -- selects either v or normal operations
            i_D0 => s_shamt,            -- used for sll, srl, sra
            i_D1 => "10000",  -- 16 (hardcoded for lui, lui implemented as sll with 16 shift)
            o_O  => s_lui_shamt
            );
    -- ALUShamt determines if ALU gets normal shamt value or lower 5 bits of D1.
    aluShamt : mux2t1_N
        generic map(N => 5)
        port map(
            i_S  => s_shamt_s,    -- selects either v or normal operations
            i_D0 => s_lui_shamt,        -- used for sll, srl, sra
            i_D1 => s_RegOutReadData1(4 downto 0),   -- used for sllv srlv srav
            o_O  => s_alu_shamt);
    -- ALUSrc deterines the source of the ALU (immediate or register)
    aluSrc : mux2t1_N
        generic map(N => 32)
        port map(
            i_S  => s_ALUSrc,
            i_D0 => s_DMemData,
            i_D1 => s_imm32,
            o_O  => s_immMuxOut);
    -- jumpMux determines the signal that goes back to PC (computed jump address or (PC + 4 or branch address))
    jumpMux : mux2t1_N
        generic map(N => 32)
        port map(
            i_S  => s_jr,
            i_D0 => s_jumpAddress,
            i_D1 => s_RegOutReadData1,
            o_O  => s_finalJumpAddress
            );
    -- jalData used specifically for the jal instruction, forces PC+4 into $31 (link pt2)
    jalData : mux2t1_N
        generic map(N => 32)
        port map(
            i_S  => s_jal,              -- in std_logic;
            i_D0 => s_DMemAddr,         -- this is the ALU Output
            i_D1 => s_PCPlusFour,       -- linked return address
            o_O  => s_MemToReg0         -- out std_logic_vector(31 downto 0)
            );
    -- jalAddr used specifically for the jal instruction, changes the destination to be hardcoded as $31.
    jalAddr : mux2t1_N
        generic map(N => 5)
        port map(
            i_S  => s_jal,
            i_D0 => s_RegInReadData2,   --rt is taking the place of rd,
            i_D1 => "11111",            -- register 31
            o_O  => s_RegDst0           -- out std_logic_vector(4 downto 0)
            );
    -- regDst determines the destination register.
    regDst : mux2t1_N
        generic map(N => 5)
        port map(
            i_S  => s_RegDst,           -- in std_logic;
            i_D0 => s_RegDst0,          -- output of jalAddr mux
            i_D1 => s_RegD,             -- rd
            o_O  => s_RegWrAddr         -- out std_logic_vector(4 downto 0)
            );
    -- branch determines the signal that goes back to PC (PC + 4 or branch address)
    branch : mux2t1_N
        generic map(N => 32)
        port map(
            i_S  => ((s_Branch and s_ALUBranch) or (s_BranchNE and not s_ALUBranch)),  -- in std_logic;
            i_D0 => s_PCPlusFour,       -- in std_logic_vector(31 downto 0);
            i_D1 => s_branchAddress,    -- in std_logic_vector(31 downto 0);
            o_O  => s_normalOrBranch    -- out std_logic_vector(31 downto 0)
            );
    -- memToReg selects either output of memory or alu to go back to regfile
    memtoReg : mux2t1_N
        generic map(N => 32)
        port map(
            i_S  => s_MemtoReg,         -- in std_logic;
            i_D0 => s_MemToReg0,        -- in std_logic_vector(31 downto 0);
            i_D1 => s_DMemOut1,         -- in std_logic_vector(31 downto 0);
            o_O  => s_RegWrData         -- out std_logic_vector(31 downto 0)
            );
    s_bSelect <= s_DMemAddr(1 downto 0);  --specific byte of interest
    -- lib2or3 selects between loading either immediate byte 2 or 3
    lb2or3 : mux2t1_N
        generic map(N => 8)
        port map(
            i_S  => s_bSelect(0),
            i_D0 => s_DMemOut(23 downto 16),
            i_D1 => s_DMemOut(31 downto 24),
            o_O  => s_lb3or2
            );
    -- lb0or1 selects between loading either byte 0 or 1.
    lb0or1 : mux2t1_N
        generic map(N => 8)
        port map(
            i_S  => s_bSelect(0),
            i_D0 => s_DMemOut(7 downto 0),
            i_D1 => s_DMemOut(15 downto 8),
            o_O  => s_lb1or0
            );
    -- lbUorL selects between loading an upper or lower byte.
    lbUorL : mux2t1_N
        generic map(N => 8)
        port map(
            i_S  => s_bSelect(1),
            i_D0 => s_lb1or0,
            i_D1 => s_lb3or2,
            o_O  => s_lbUorL
            );
    -- lhUorL selects between loading either upper or lower half.
    lhUorL : mux2t1_N
        generic map(N => 16)
        port map(
            i_S  => s_bSelect(1),  ------------------- selects loading the upper or lower half
            i_D0 => s_DMemOut(15 downto 0),   -- upper half
            i_D1 => s_DMemOut(31 downto 16),  -- lower half
            o_O  => s_lhUorL
            );
    -- byteOrHalf determines the selection of loading a byte or half.
    byteOrHalf : mux2t1_N
        generic map(N => 32)
        port map(
            i_S  => s_HorB,   ------------ selects loading a byte or a half.
            i_D0 => s_lb_word,          -- Byte
            i_D1 => s_lh_word,          -- Half.
            o_O  => s_lbOrlh            -- Output
            );
    -- loadByteOrHalf determines the selection of loading a byte or half.
    loadByteOrHalf : mux2t1_N  -- selects between loading normally or a byte/half signal
        generic map(N => 32)
        port map(
            i_S  => s_abnormal,
            i_D0 => s_DMemOut,
            i_D1 => s_lbOrlh,
            o_O  => s_DMemOut1          -- -> memToReg
            );
    -- ==========================================================================
    -- Execute (EX)
    -- ==========================================================================
    -- branchAdder gives the modified address for branches.
    branchAdder : adderSubtractor
        generic map(N => 32)
        port map(
            i_S      => '1',
            nAdd_Sub => '0',            -- in std_logic;
            i_A      => s_PCPlusFour,   -- in std_logic_vector(31 downto 0);
            i_B      => s_imm32x4,      -- immediate value
            o_Y      => s_branchAddress,  -- out std_logic_vector(31 downto 0);
            o_Cout   => s_nil2          -- carry out
            );
    oALUOut <= s_DMemAddr;              -- oALU is for synthesis
    -- arithmeticLogicUnit does all the arithmetic operations and interfaces with memory
    arithmeticLogicUnit : alu
        port map(
            CLK        => iCLK,
            i_Data1    => s_RegOutReadData1,
            i_Data2    => s_immMuxOut,
            i_aluOp    => s_ALUOp,
            i_shamt    => s_alu_shamt,
            o_F        => s_DMemAddr,
            o_OverFlow => s_Ovfl,
            o_Zero     => s_ALUBranch
            );
    -- jump determines the signal that goes back to program counter (computed jump address, PC + 4, or branch address).
    jump : mux2t1_N
        generic map(N => 32)
        port map(
            i_S  => s_jump,             -- in std_logic;
            i_D0 => s_normalOrBranch,   -- output of Branch mux
            i_D1 => s_finalJumpAddress,  -- output of jumpMux
            o_O  => s_inputPC           -- out std_logic_vector(31 downto 0)
            );
    -- ==========================================================================
    -- Write Back (WB)
    -- ==========================================================================
    controlSlice : process (s_Ctrl)  -- action of cutting up the lumped up control signals into other wires
    begin
        --Control Signals
        s_abnormal          <= s_Ctrl(20);  -- selects between either loading a word or a half/byte from memory
        s_HorBExt           <= s_Ctrl(19);
        s_HorB              <= s_Ctrl(18);
        s_BranchNE          <= s_Ctrl(17);
        s_shamt_s           <= s_Ctrl(16);
        s_lui               <= s_Ctrl(15);
        s_jr                <= s_Ctrl(14);
        s_jal               <= s_Ctrl(13);
        s_ALUSrc            <= s_Ctrl(12);
        s_ALUOp(3 downto 0) <= s_Ctrl(11 downto 8);  --opcode for the mainALU
        s_MemtoReg          <= s_Ctrl(7);
        s_DMemWr            <= s_Ctrl(6);
        s_RegWr             <= s_Ctrl(5);
        s_RegDst            <= s_Ctrl(4);
        s_Branch            <= s_Ctrl(3);
        s_SignExt           <= s_Ctrl(2);
        s_jump              <= s_Ctrl(1);
        s_Halt              <= s_Ctrl(0);
    end process;
    jumpAddresses : process (s_PCPlusFour, s_imm32)  -- process for converting address arguments into actual 32 bit addresses
    begin
        s_jumpAddress(31 downto 28) <= s_PCPlusFour(31 downto 28);  -- PC+4 bits[31-28] into bits[31-28] of jumpAddr
        s_imm32x4(0)                <= '0';
        s_imm32x4(1)                <= '0';
        s_imm32x4(31 downto 2)      <= s_imm32(29 downto 0);  -- imm32 bits[29-0] into bits[31-2] of jumpAddr
    end process;
end structure;

