-- <header>
-- Author(s): Conner Ohnesorge
-- Name: src_sw/proj/src/TopLevel/MIPS_Processor.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-21T09:00:59-06:00 added-start-of-sf-pipeline-folder
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MIPS_types.all;

entity MIPS_Processor is
    generic (
        N : integer := DATA_WIDTH
    );

    port (
        iCLK      : in std_logic;
        iRST      : in std_logic;
        iInstLd   : in std_logic;
        iInstAddr : in std_logic_vector(N - 1 downto 0);
        iInstExt  : in std_logic_vector(N - 1 downto 0);
        oALUOut   : out std_logic_vector(N - 1 downto 0)
    );

end MIPS_Processor;

architecture structure of MIPS_Processor is
    signal s_DMemAddr     : std_logic_vector(N - 1 downto 0);
    signal s_DMemData     : std_logic_vector(N - 1 downto 0);
    signal s_IMemAddr     : std_logic_vector(N - 1 downto 0);
    signal s_NextInstAddr : std_logic_vector(N - 1 downto 0);

    signal s_Ovfl                 : std_logic;
    signal s_IF_PCSrcSel          : std_logic;
    signal s_IF_final_pc          : std_logic_vector(N - 1 downto 0);
    signal s_IF_PCP4              : std_logic_vector(N - 1 downto 0);
    signal s_Inst                 : std_logic_vector(N - 1 downto 0);
    signal s_ID_Inst              : std_logic_vector(N - 1 downto 0);
    signal s_ID_PCP4              : std_logic_vector(N - 1 downto 0);
    signal s_ID_sign_ext_en       : std_logic;
    signal s_ID_CntrlRegWrite     : std_logic;
    signal s_ID_RegDst            : std_logic_vector(1 downto 0);
    signal s_ID_jump              : std_logic_vector(1 downto 0);
    signal s_ID_MemSel            : std_logic_vector(1 downto 0);
    signal s_ID_BranchCtl         : std_logic;
    signal s_ID_ALUSrc            : std_logic;
    signal s_ID_ALUOp             : std_logic_vector(2 downto 0);
    signal s_ID_DMemWr            : std_logic;
    signal s_ID_BranchType        : std_logic_vector(2 downto 0);
    signal s_ID_Halt              : std_logic;
    signal s_ID_dest_input_bus    : bus_array(3 downto 0)(4 downto 0);
    signal s_ID_sign_ext_imm      : std_logic_vector(N - 1 downto 0);
    signal s_ID_branch_label      : std_logic_vector(N - 1 downto 0);
    signal s_ID_j_addr            : std_logic_vector(N - 1 downto 0);
    signal s_ID_dsrc1, s_ID_dsrc2 : std_logic_vector(N - 1 downto 0);
    signal s_ID_new_pc            : std_logic_vector(N - 1 downto 0);
    signal s_ID_do_branch         : std_logic;
    signal s_ID_branch_mod_out    : std_logic;
    signal s_ID_branch_addr       : std_logic_vector(N - 1 downto 0);
    signal s_ID_pcp4_branch_out   : std_logic_vector(N - 1 downto 0);
    signal s_ID_final_pc_mux_bus  : bus_array(3 downto 0)(N - 1 downto 0);
    signal s_EX_ALUSel            : std_logic_vector(4 downto 0);
    signal s_EX_alud1             : std_logic_vector(N - 1 downto 0);
    signal s_EX_alu_out           : std_logic_vector(N - 1 downto 0);
    signal s_DMemWr               : std_logic;
    signal s_DMemWrAddr           : std_logic_vector(N - 1 downto 0);
    signal s_EX_Inst_imm          : std_logic_vector(15 downto 0);
    signal s_EX_lui_val           : std_logic_vector(31 downto 0);
    signal s_MEM_Inst_imm         : std_logic_vector(15 downto 0);
    signal s_MEM_lui_val          : std_logic_vector(31 downto 0);
    signal s_MEM_PCP4             : std_logic_vector(31 downto 0);

    signal s_Halt : std_logic;

    signal s_EX_PCP4       : std_logic_vector(N - 1 downto 0);
    signal s_EX_new_pc     : std_logic_vector(N - 1 downto 0);
    signal s_EX_do_branch  : std_logic;
    signal s_EX_CntrlRegWr : std_logic;
    signal s_EX_RegDst     : std_logic_vector(1 downto 0);
    signal s_EX_jump       : std_logic_vector(1 downto 0);
    signal s_EX_memSel     : std_logic_vector(1 downto 0);
    signal s_EX_ALUSrc     : std_logic;
    signal s_EX_ALUOp      : std_logic_vector(2 downto 0);
    signal s_EX_DMemWr     : std_logic;
    signal s_EX_Halt       : std_logic;
    signal s_DMemOut       : std_logic_vector(N - 1 downto 0);

    signal s_EX_dsrc1, s_EX_dsrc2  : std_logic_vector(N - 1 downto 0);
    signal s_EX_sign_ext_imm       : std_logic_vector(N - 1 downto 0);
    signal s_EX_Inst_funct         : std_logic_vector(5 downto 0);
    signal s_EX_Inst_lui           : std_logic_vector(15 downto 0);
    signal s_EX_Inst_shamt         : std_logic_vector(4 downto 0);
    signal s_EX_Inst_rt            : std_logic_vector(4 downto 0);
    signal s_EX_Inst_rd            : std_logic_vector(4 downto 0);
    signal s_MEM_new_pc            : std_logic_vector(N - 1 downto 0);
    signal s_MEM_do_branch         : std_logic;
    signal s_MEM_memSel            : std_logic_vector(1 downto 0);
    signal s_MEM_CntrlRegWr        : std_logic;
    signal s_MEM_RegDst            : std_logic_vector(1 downto 0);
    signal s_MEM_jump              : std_logic_vector(1 downto 0);
    signal s_MEM_dsrc2             : std_logic_vector(N - 1 downto 0);
    signal s_MEM_Halt              : std_logic;
    signal s_MEM_ALUOut            : std_logic_vector(N - 1 downto 0);
    signal s_MEM_Inst_rt           : std_logic_vector(4 downto 0);
    signal s_MEM_Inst_rd           : std_logic_vector(4 downto 0);
    signal s_WB_PCP4               : std_logic_vector(N - 1 downto 0);
    signal s_WB_new_pc             : std_logic_vector(N - 1 downto 0);
    signal s_WB_do_branch          : std_logic;
    signal s_WB_memSel             : std_logic_vector(1 downto 0);
    signal s_WB_CntrlRegWr         : std_logic;
    signal s_WB_RegDst             : std_logic_vector(1 downto 0);
    signal s_WB_jump               : std_logic_vector(1 downto 0);
    signal s_WB_DMemOut            : std_logic_vector(N - 1 downto 0);
    signal s_WB_ALUOut             : std_logic_vector(N - 1 downto 0);
    signal s_WB_lui_val            : std_logic_vector(N - 1 downto 0);
    signal s_WB_Inst_rt            : std_logic_vector(4 downto 0);
    signal s_WB_Inst_rd            : std_logic_vector(4 downto 0);
    signal s_WB_reg_write_data_bus : bus_array(3 downto 0)(N - 1 downto 0);

    signal s_nil       : std_logic_vector(N - 1 downto 0);
    signal s_RegWrAddr : std_logic_vector(4 downto 0);
    signal s_RegWrData : std_logic_vector(31 downto 0);
    signal s_RegWr     : std_logic;

    component mem is
        generic (
            ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
        port (
            clk  : in std_logic;
            addr : in std_logic_vector((ADDR_WIDTH - 1) downto 0);
            data : in std_logic_vector((DATA_WIDTH - 1) downto 0);
            we   : in std_logic := '1';
            q    : out std_logic_vector((DATA_WIDTH - 1) downto 0)
        );
    end component;
    
    component mux2t1_N is
        generic (
            N : integer := 32
        );
        port (
            i_S  : in std_logic;
            i_D0 : in std_logic_vector(N - 1 downto 0);
            i_D1 : in std_logic_vector(N - 1 downto 0);
            o_O  : out std_logic_vector(N - 1 downto 0)
        );
    end component;

    component mux2t1 is
        port (
            i_S  : in std_logic;
            i_D0 : in std_logic;
            i_D1 : in std_logic;
            o_O  : out std_logic);
    end component;

    component mux_Nt1 is
        generic (
            bus_width : integer := 32;
            sel_width : integer := 5
        );
        port (
            i_reg_bus : in bus_array(2 ** sel_width - 1 downto 0)(bus_width - 1 downto 0);
            i_sel     : in std_logic_vector(sel_width - 1 downto 0);
            o_reg     : out std_logic_vector(bus_width - 1 downto 0)
        );
    end component;

    component register_file is

        port (
            clk   : in std_logic;                      -- Clock input
            i_wA  : in std_logic_vector(4 downto 0);   -- Write address input
            i_wD  : in std_logic_vector(31 downto 0);  -- Write data input
            i_wC  : in std_logic;                      -- Write enable input
            i_r1  : in std_logic_vector(4 downto 0);   -- Read address 1 input
            i_r2  : in std_logic_vector(4 downto 0);   -- Read address 2 input
            reset : in std_logic;                      -- Reset input
            o_d1  : out std_logic_vector(31 downto 0); -- Read data 1 output
            o_d2  : out std_logic_vector(31 downto 0)  -- Read data 2 output
        );

    end component;

    component sign_extender_32 is
        port (
            i_data     : in std_logic_vector(15 downto 0);
            i_signed   : in std_logic;
            o_data_ext : out std_logic_vector(31 downto 0)
        );
    end component;

    component andg2 is
        port (
            i_A : in std_logic;
            i_B : in std_logic;
            o_F : out std_logic);
    end component;

    component control_unit is
        port (
            i_Opcode        : in std_logic_vector(5 downto 0);
            i_Funct         : in std_logic_vector(5 downto 0);
            i_Rt            : in std_logic_vector(4 downto 0);
            o_RegWr         : out std_logic;
            o_RegDst        : out std_logic_vector(1 downto 0);
            o_SignExtEnable : out std_logic;
            o_Jump          : out std_logic_vector(1 downto 0);
            o_MemSel        : out std_logic_vector(1 downto 0);
            o_BranchCtl     : out std_logic;
            o_BranchType    : out std_logic_vector(2 downto 0);
            o_ALUSrc        : out std_logic;
            o_ALUOp         : out std_logic_vector(2 downto 0);
            o_MemWr         : out std_logic;
            o_Halt          : out std_logic
        );
    end component;

    component alu_control is
        port (
            i_funct  : in std_logic_vector(5 downto 0);
            i_ALUOp  : in std_logic_vector(2 downto 0);
            o_ALUSel : out std_logic_vector(4 downto 0)
        );
    end component;

    component branch_control_module is
        generic (N : integer := 32);
        port (
            i_dsrc1  : in std_logic_vector(N - 1 downto 0);
            i_dsrc2  : in std_logic_vector(N - 1 downto 0);
            i_BrType : in std_logic_vector(2 downto 0);
            o_Branch : out std_logic
        );
    end component;

    component ALU is
        generic (N : integer := 32);
        port (
            i_ALUCtrl  : in std_logic_vector(4 downto 0);
            i_Data_0   : in std_logic_vector(N - 1 downto 0);
            i_Data_1   : in std_logic_vector(N - 1 downto 0);
            i_shamt    : in std_logic_vector(4 downto 0);
            o_ALUOut   : out std_logic_vector(N - 1 downto 0);
            o_Cout     : out std_logic;
            o_Overflow : out std_logic
        );
    end component;

    component ripple_adder is
        generic (N : integer := 32);
        port (
            i_A    : in std_logic_vector(N - 1 downto 0);
            i_B    : in std_logic_vector(N - 1 downto 0);
            i_Cin  : in std_logic;
            o_Sum  : out std_logic_vector(N - 1 downto 0);
            o_Cout : out std_logic
        );
    end component;

    component program_counter is
        generic (N : integer := 32);
        port (
            i_CLK  : in std_logic;
            i_RST  : in std_logic;
            i_Data : in std_logic_vector(N - 1 downto 0);
            o_Data : out std_logic_vector(N - 1 downto 0)
        );
    end component;

    component shift_left_2 is
        generic (
            INPUT_WIDTH : integer   := 26;
            RESIZE      : std_logic := '0');
        port (
            i_data             : in std_logic_vector(INPUT_WIDTH - 1 downto 0);
            o_shft_data_resize : out std_logic_vector((INPUT_WIDTH + 1) downto 0);
            o_shft_data_norsze : out std_logic_vector(INPUT_WIDTH - 1 downto 0)
        );
    end component;

    component program_counter_source is
        port (
            i_do_branch : in std_logic;
            i_jump      : in std_logic_vector(1 downto 0);
            o_PCSrcSel  : out std_logic
        );
    end component;

    component if_id_reg is
        port (
            i_CLK  : in std_logic;
            i_RST  : in std_logic;
            i_PCP4 : in std_logic_vector(31 downto 0);
            i_Inst : in std_logic_vector(31 downto 0);
            o_PCP4 : out std_logic_vector(31 downto 0);
            o_Inst : out std_logic_vector(31 downto 0)
        );
    end component;

    component id_ex_reg is
        port (
            i_CLK           : in std_logic;
            i_RST           : in std_logic;
            i_PCP4          : in std_logic_vector(31 downto 0);
            i_new_pc        : in std_logic_vector(31 downto 0);
            i_do_branch     : in std_logic;
            i_CntrlRegWrite : in std_logic;
            i_RegDst        : in std_logic_vector(1 downto 0);
            i_jump          : in std_logic_vector(1 downto 0);
            i_memSel        : in std_logic_vector(1 downto 0);
            i_ALUSrc        : in std_logic;
            i_ALUOp         : in std_logic_vector(2 downto 0);
            i_DMemWr        : in std_logic;
            i_Halt          : in std_logic;
            i_dsrc1         : in std_logic_vector(31 downto 0);
            i_dsrc2         : in std_logic_vector(31 downto 0);
            i_sign_ext_imm  : in std_logic_vector(31 downto 0);
            i_Inst_rt       : in std_logic_vector(4 downto 0);
            i_Inst_rd       : in std_logic_vector(4 downto 0);
            i_Inst_funct    : in std_logic_vector(5 downto 0);
            i_Inst_lui      : in std_logic_vector(15 downto 0);
            i_Inst_shamt    : in std_logic_vector(4 downto 0);
            o_PCP4          : out std_logic_vector(31 downto 0);
            o_new_pc        : out std_logic_vector(31 downto 0);
            o_do_branch     : out std_logic;
            o_CntrlRegWrite : out std_logic;
            o_RegDst        : out std_logic_vector(1 downto 0);
            o_jump          : out std_logic_vector(1 downto 0);
            o_memSel        : out std_logic_vector(1 downto 0);
            o_ALUSrc        : out std_logic;
            o_ALUOp         : out std_logic_vector(2 downto 0);
            o_DMemWr        : out std_logic;
            o_Halt          : out std_logic;
            o_dsrc1         : out std_logic_vector(31 downto 0);
            o_dsrc2         : out std_logic_vector(31 downto 0);
            o_sign_ext_imm  : out std_logic_vector(31 downto 0);
            o_Inst_rt       : out std_logic_vector(4 downto 0);
            o_Inst_rd       : out std_logic_vector(4 downto 0);
            o_Inst_funct    : out std_logic_vector(5 downto 0);
            o_Inst_lui      : out std_logic_vector(15 downto 0);
            o_Inst_shamt    : out std_logic_vector(4 downto 0)
        );
    end component;

    component ex_mem_reg is
        port (
            i_CLK           : in std_logic;
            i_RST           : in std_logic;
            i_PCP4          : in std_logic_vector(31 downto 0);
            i_new_pc        : in std_logic_vector(31 downto 0);
            i_do_branch     : in std_logic;
            i_memSel        : in std_logic_vector(1 downto 0);
            i_CntrlRegWrite : in std_logic;
            i_RegDst        : in std_logic_vector(1 downto 0);
            i_DMemWr        : in std_logic;
            i_jump          : in std_logic_vector(1 downto 0);
            i_dsrc2         : in std_logic_vector(31 downto 0);
            i_Halt          : in std_logic;
            i_ALUOut        : in std_logic_vector(31 downto 0);
            i_lui_val       : in std_logic_vector(31 downto 0);
            i_Inst_rt       : in std_logic_vector(4 downto 0);
            i_Inst_rd       : in std_logic_vector(4 downto 0);
            o_PCP4          : out std_logic_vector(31 downto 0);
            o_new_pc        : out std_logic_vector(31 downto 0);
            o_do_branch     : out std_logic;
            o_memSel        : out std_logic_vector(1 downto 0);
            o_CntrlRegWrite : out std_logic;
            o_RegDst        : out std_logic_vector(1 downto 0);
            o_DMemWr        : out std_logic;
            o_jump          : out std_logic_vector(1 downto 0);
            o_dsrc2         : out std_logic_vector(31 downto 0);
            o_Halt          : out std_logic;
            o_ALUOut        : out std_logic_vector(31 downto 0);
            o_Inst_lui      : out std_logic_vector(31 downto 0);
            o_Inst_rt       : out std_logic_vector(4 downto 0);
            o_Inst_rd       : out std_logic_vector(4 downto 0)
        );
    end component;

    component mem_wb_reg is
        port (
            i_CLK           : in std_logic;
            i_RST           : in std_logic;
            i_PCP4          : in std_logic_vector(31 downto 0);
            i_new_pc        : in std_logic_vector(31 downto 0);
            i_do_branch     : in std_logic;
            i_memSel        : in std_logic_vector(1 downto 0);
            i_CntrlRegWrite : in std_logic;
            i_RegDst        : in std_logic_vector(1 downto 0);
            i_jump          : in std_logic_vector(1 downto 0);
            i_Halt          : in std_logic;
            i_DMemOut       : in std_logic_vector(31 downto 0);
            i_ALUOut        : in std_logic_vector(31 downto 0);
            i_lui_val       : in std_logic_vector(31 downto 0);
            i_Inst_rt       : in std_logic_vector(4 downto 0);
            i_Inst_rd       : in std_logic_vector(4 downto 0);
            o_PCP4          : out std_logic_vector(31 downto 0);
            o_new_pc        : out std_logic_vector(31 downto 0);
            o_do_branch     : out std_logic;
            o_memSel        : out std_logic_vector(1 downto 0);
            o_CntrlRegWrite : out std_logic;
            o_RegDst        : out std_logic_vector(1 downto 0);
            o_jump          : out std_logic_vector(1 downto 0);
            o_Halt          : out std_logic;
            o_DMemOut       : out std_logic_vector(31 downto 0);
            o_ALUOut        : out std_logic_vector(31 downto 0);
            o_lui_val       : out std_logic_vector(31 downto 0);
            o_Inst_rt       : out std_logic_vector(4 downto 0);
            o_Inst_rd       : out std_logic_vector(4 downto 0)
        );
    end component;

begin
    s_nil <= x"CCCCCCCC";
    oALUOut <= s_EX_alu_out;

    s_EX_lui_val <= s_EX_Inst_lui & x"0000";
    s_ID_j_addr(31 downto 28) <= s_ID_PCP4(31 downto 28);

    s_WB_reg_write_data_bus <= (
        0 => s_WB_ALUOut,
        1 => s_WB_DMemOut,
        2 => s_WB_PCP4,
        3 => s_WB_lui_val
        );

    with iInstLd select
        s_IMemAddr <= s_NextInstAddr when '0',
        iInstAddr when others;

    mux2t1_alusrc2 : mux2t1_N
    generic map(32)
    port map(
        s_EX_ALUSrc,
        s_EX_dsrc2,
        s_EX_sign_ext_imm,
        s_EX_alud1
    );

    instALU_CONTROL : alu_control
    port map(
        s_EX_Inst_funct,
        s_EX_ALUOp,
        s_EX_ALUSel);

    branch_and : andg2
    port map(
        s_ID_branchCtl,
        s_ID_branch_mod_out,
        s_ID_do_branch);

    branch_mux : mux2t1_N
    port map(
        s_ID_do_branch,
        s_ID_PCP4,
        s_ID_branch_addr,
        s_ID_pcp4_branch_out);
    
    pc_src_ctrl : program_counter_source
    port map
    (
        s_WB_do_branch,
        s_WB_jump,
        s_IF_PCSrcSel
    );

    pc_src_mux : mux2t1_N
    port map(
        s_IF_PCSrcSel,
        s_IF_PCP4,
        s_WB_new_pc,
        s_IF_final_pc
    );

    PC : program_counter
    port map(
        iCLK,
        iRST,
        s_IF_final_pc,
        s_NextInstAddr
    );

    PC_plus_4_adder : ripple_adder
    port map(
        s_NextInstAddr,
        std_logic_vector(to_unsigned(4, N)),
        '0',
        s_IF_PCP4,
        open
    );

    IMem : mem
    generic map(
        ADDR_WIDTH => 32,
        DATA_WIDTH => N
    )
    port map(
        clk  => iCLK,
        addr => s_IMemAddr(11 downto 2),
        data => iInstExt,
        we   => iInstLd,
        q    => s_Inst
    );

    IF_ID_pipe_reg : if_id_reg
    port map(
        iCLK,
        iRST,
        s_IF_PCP4,
        s_Inst,
        s_ID_PCP4,
        s_ID_Inst
    );

    s_ID_dest_input_bus <= (
                           0 => s_WB_Inst_rt,
        1                         => s_WB_Inst_rd,
        2                         => std_logic_vector(to_unsigned(31, 5)),
        3 => s_nil(4 downto 0)
    );

    reg_dest_mux : mux_Nt1
    generic map(
        bus_width => 5,
        sel_width => 2)
    port map(
        s_ID_dest_input_bus,
        s_WB_RegDst,
        s_RegWrAddr
    );

    reg_write_mux : mux2t1
    port map(
        s_WB_RegDst(1),
        s_WB_CntrlRegWr,
        s_WB_do_branch or s_WB_CntrlRegWr,
        s_RegWr
    );

    reg_file : register_file port map(
        iCLK,
        s_RegWrAddr,
        s_RegWrData,
        s_RegWr,
        s_ID_Inst(25 downto 21),
        s_ID_Inst(20 downto 16),
        iRST,
        s_ID_dsrc1,
        s_ID_dsrc2
    );

    sign_extend_32 : sign_extender_32
    port map(
        s_ID_Inst(15 downto 0),
        s_ID_sign_ext_en,
        s_ID_sign_ext_imm
    );

    sl2_jaddr : shift_left_2
    generic map(
        INPUT_WIDTH => 26,
        RESIZE      => '1'
    )
    port map(
        s_ID_Inst(25 downto 0),
        s_ID_j_addr(27 downto 0),
        open
    );

    alu_dmem_mux : mux_Nt1
    generic map(
        bus_width => 32,
        sel_width => 2)
    port map(
        s_WB_reg_write_data_bus,
        s_WB_MemSel,
        s_RegWrData
    );

    

    sl2_branch : shift_left_2
    generic map(
        INPUT_WIDTH => 32,
        RESIZE      => '0')
    port map(
        s_ID_sign_ext_imm,
        open,
        s_ID_branch_label
    );

    central_control : control_unit
    port map(
        s_ID_Inst(31 downto 26),
        s_ID_Inst(5 downto 0),
        s_ID_Inst(20 downto 16),
        s_ID_CntrlRegWrite,
        s_ID_RegDst,
        s_ID_sign_ext_en,
        s_ID_jump,
        s_ID_MemSel,
        s_ID_BranchCtl,
        s_ID_BranchType,
        s_ID_ALUSrc,
        s_ID_ALUOp,
        s_ID_DMemWr,
        s_ID_Halt);

    branch_control : branch_control_module
    port map(
        s_ID_dsrc1,
        s_ID_dsrc2,
        s_ID_BranchType,
        s_ID_branch_mod_out
    );

    branch_adder : ripple_adder
    port map(
        s_ID_PCP4,
        s_ID_branch_label,
        '0',
        s_ID_branch_addr,
        open
    );


    s_ID_final_pc_mux_bus <= (
        0 => s_ID_pcp4_branch_out,
        1 => s_ID_j_addr,
        2 => s_ID_dsrc1,
        3 => s_nil
        );

    j_jr_b_mux : mux_Nt1
    generic map(
        bus_width => 32,
        sel_width => 2)
    port map(
        s_ID_final_pc_mux_bus,
        s_ID_jump,
        s_ID_new_pc
    );

    ID_EX_pipe_reg : id_ex_reg
    port map(
        iCLK,
        iRST,
        s_ID_PCP4,
        s_ID_new_pc,
        s_ID_do_branch,
        s_ID_CntrlRegWrite,
        s_ID_RegDst,
        s_ID_jump,
        s_ID_MemSel,
        s_ID_ALUSrc,
        s_ID_ALUOp,
        s_ID_DMemWr,
        s_ID_Halt,
        s_ID_dsrc1,
        s_ID_dsrc2,
        s_ID_sign_ext_imm,
        s_ID_Inst(20 downto 16),
        s_ID_Inst(15 downto 11),
        s_ID_Inst(5 downto 0),
        s_ID_Inst(15 downto 0),
        s_ID_Inst(10 downto 6),
        s_EX_PCP4,
        s_EX_new_pc,
        s_EX_do_branch,
        s_EX_CntrlRegWr,
        s_EX_RegDst,
        s_EX_jump,
        s_EX_memSel,
        s_EX_ALUSrc,
        s_EX_ALUOp,
        s_EX_DMemWr,
        s_EX_Halt,
        s_EX_dsrc1,
        s_EX_dsrc2,
        s_EX_sign_ext_imm,
        s_EX_Inst_rt,
        s_EX_Inst_rd,
        s_EX_Inst_funct,
        s_EX_Inst_lui,
        s_EX_Inst_shamt
    );

    proc_alu : ALU
    generic map(32)
    port map(
        s_EX_ALUSel,
        s_EX_dsrc1,
        s_EX_alud1,
        s_EX_Inst_shamt,
        s_EX_alu_out,
        open,
        s_Ovfl
    );


    EX_MEM_pipe_reg : ex_mem_reg
    port map(
        iCLK,
        iRST,
        s_EX_PCP4,
        s_EX_new_pc,
        s_EX_do_branch,
        s_EX_memSel,
        s_EX_CntrlRegWr,
        s_EX_RegDst,
        s_EX_DMemWr,
        s_EX_jump,
        s_EX_dsrc2,
        s_EX_Halt,
        s_EX_alu_out,
        s_EX_lui_val,
        s_EX_Inst_rt,
        s_EX_Inst_rd,
        s_MEM_PCP4,
        s_MEM_new_pc,
        s_MEM_do_branch,
        s_MEM_memSel,
        s_MEM_CntrlRegWr,
        s_MEM_RegDst,
        s_DMemWr,
        s_MEM_jump,
        s_MEM_dsrc2,
        s_MEM_Halt,
        s_MEM_ALUOut,
        s_MEM_lui_val,
        s_MEM_Inst_rt,
        s_MEM_Inst_rd);

    s_DMemAddr <= s_MEM_ALUOut;
    s_DMemData <= s_MEM_dsrc2;

    DMem : mem
    generic map(
        ADDR_WIDTH => ADDR_WIDTH,
        DATA_WIDTH => N)
    port map(
        clk  => iCLK,
        addr => s_DMemAddr(11 downto 2),
        data => s_DMemData,
        we   => s_DMemWr,
        q    => s_DMemOut
    );

    MEM_WB_pipe_reg : mem_wb_reg
    port map(
        iCLK,
        iRST,
        s_MEM_PCP4,
        s_MEM_new_pc,
        s_MEM_do_branch,
        s_MEM_memSel,
        s_MEM_CntrlRegWr,
        s_MEM_RegDst,
        s_MEM_jump,
        s_MEM_Halt,
        s_DMemOut,
        s_MEM_ALUOut,
        s_MEM_lui_val,
        s_MEM_Inst_rt,
        s_MEM_Inst_rd,
        s_WB_PCP4,
        s_WB_new_pc,
        s_WB_do_branch,
        s_WB_memSel,
        s_WB_CntrlRegWr,
        s_WB_RegDst,
        s_WB_jump,
        s_Halt,
        s_WB_DMemOut,
        s_WB_ALUOut,
        s_WB_lui_val,
        s_WB_Inst_rt,
        s_WB_Inst_rd
    );

end structure;
