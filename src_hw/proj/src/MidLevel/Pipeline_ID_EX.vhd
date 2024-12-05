library IEEE;
use IEEE.std_logic_1164.all;

entity ID_EX is
        
        port (
                i_CLK          : in  std_logic;
                i_RST          : in  std_logic;
                i_stall        : in  std_logic;  --stall control
                i_PC4          : in  std_logic_vector(31 downto 0);
                i_readA        : in  std_logic_vector(31 downto 0);
                i_readB        : in  std_logic_vector(31 downto 0);
                i_signExtImmed : in  std_logic_vector(31 downto 0);
                i_IDRt         : in  std_logic_vector(4 downto 0);
                i_IDRD         : in  std_logic_vector(4 downto 0);
                i_RegDst       : in  std_logic;
                i_RegWrite     : in  std_logic;
                i_memToReg     : in  std_logic;
                i_MemWrite     : in  std_logic;
                i_ALUSrc       : in  std_logic;
                i_ALUOp        : in  std_logic_vector(3 downto 0);
                i_jal          : in  std_logic;
                i_halt         : in  std_logic;
                i_RS           : in  std_logic_vector(4 downto 0);
                i_memRd        : in  std_logic;
                o_RS           : out std_logic_vector(4 downto 0);
                o_PC4          : out std_logic_vector(31 downto 0);
                o_readA        : out std_logic_vector(31 downto 0);
                o_readB        : out std_logic_vector(31 downto 0);
                o_signExtImmed : out std_logic_vector(31 downto 0);
                o_Rt           : out std_logic_vector(4 downto 0); -- inst20_16
                o_Rd           : out std_logic_vector(4 downto 0); -- inst15_11
                o_RegDst       : out std_logic;
                o_RegWrite     : out std_logic;
                o_memToReg     : out std_logic;
                o_MemWrite     : out std_logic;
                o_ALUSrc       : out std_logic;
                o_ALUOp        : out std_logic_vector(3 downto 0);
                o_jal          : out std_logic;
                o_halt         : out std_logic;
                o_memRd        : out std_logic
                );
        
end ID_EX;

architecture structural of ID_EX is

        component dffg_N is
                generic (N : integer := 32);
                port (
                        i_CLK : in  std_logic;
                        i_RST : in  std_logic;
                        i_WE  : in  std_logic;
                        i_D   : in  std_logic_vector(N - 1 downto 0);
                        o_Q   : out std_logic_vector(N - 1 downto 0)
                        );
        end component;

        component dffg is
                port (
                        i_CLK : in  std_logic;
                        i_RST : in  std_logic;
                        i_WE  : in  std_logic;
                        i_D   : in  std_logic;
                        o_Q   : out std_logic
                        );
        end component;

        signal s_stall : std_logic;

begin
        s_stall <= not i_stall;

        instPCPlus4Reg : dffg_N
                generic map(N => 32)
                port map(
                        i_CLK => i_CLK,
                        i_RST => i_RST,
                        i_WE  => s_stall,
                        i_D   => i_PC4,
                        o_Q   => o_PC4
                        );

        instReadAReg : dffg_N
                generic map(N => 32)
                port map(
                        i_CLK => i_CLK,
                        i_RST => i_RST,
                        i_WE  => s_stall,
                        i_D   => i_readA,
                        o_Q   => o_readA
                        );

        instReadBReg : dffg_N
                generic map(N => 32)
                port map(
                        i_CLK => i_CLK,
                        i_RST => i_RST,
                        i_WE  => s_stall,
                        i_D   => i_readB,
                        o_Q   => o_readB
                        );

        instImmExtReg : dffg_N
                generic map(N => 32)
                port map(
                        i_CLK => i_CLK,
                        i_RST => i_RST,
                        i_WE  => s_stall,
                        i_D   => i_signExtImmed,
                        o_Q   => o_signExtImmed
                        );

        instRs : dffg_N
                generic map(N => 5)
                port map(
                        i_CLK => i_CLK,
                        i_RST => i_RST,
                        i_WE  => s_stall,
                        i_D   => i_RS,
                        o_Q   => o_RS);

        instRtReg : dffg_N
                generic map(N => 5)
                port map(
                        i_CLK => i_CLK,
                        i_RST => i_RST,
                        i_WE  => s_stall,
                        i_D   => i_IDRt,
                        o_Q   => o_Rt
                        );

        instRdReg : dffg_N
                generic map(N => 5)
                port map(
                        i_CLK => i_CLK,
                        i_RST => i_RST,
                        i_WE  => s_stall,
                        i_D   => i_IDRD,
                        o_Q   => o_Rd
                        );

        instRegDstReg : dffg
                port map(
                        i_CLK => i_CLK,
                        i_RST => i_RST,
                        i_WE  => s_stall,
                        i_D   => i_RegDst,
                        o_Q   => o_RegDst
                        );

        instRegWriteReg : dffg
                port map(
                        i_CLK => i_CLK,
                        i_RST => i_RST,
                        i_WE  => s_stall,
                        i_D   => i_RegWrite,
                        o_Q   => o_RegWrite
                        );

        instMemToRegReg : dffg
                port map(
                        i_CLK => i_CLK,
                        i_RST => i_RST,
                        i_WE  => s_stall,
                        i_D   => i_memToReg,
                        o_Q   => o_memToReg
                        );

        instMemWriteReg : dffg
                port map(

                        i_CLK => i_CLK,
                        i_RST => i_RST,
                        i_WE  => s_stall,
                        i_D   => i_MemWrite,
                        o_Q   => o_MemWrite
                        );

        instALUSrcReg : dffg
                port map(
                        i_CLK => i_CLK,
                        i_RST => i_RST,
                        i_WE  => s_stall,
                        i_D   => i_ALUSrc,
                        o_Q   => o_ALUSrc
                        );

        instALUOpReg : dffg_N
                generic map(N => 4)
                port map(
                        i_CLK => i_CLK,
                        i_RST => i_RST,
                        i_WE  => s_stall,
                        i_D   => i_ALUOp,
                        o_Q   => o_ALUOp);

        instJalReg : dffg
                port map(

                        i_CLK => i_CLK,
                        i_RST => i_RST,
                        i_WE  => s_stall,
                        i_D   => i_jal,
                        o_Q   => o_jal
                        );

        instHaltReg : dffg
                port map(
                        i_CLK => i_CLK,
                        i_RST => i_RST,
                        i_WE  => s_stall,
                        i_D   => i_halt,
                        o_Q   => o_halt
                        );

        instMemoryRd : dffg
                port map (
                        i_CLK => i_CLK,
                        i_RST => i_RST,
                        i_WE  => s_stall,
                        i_D   => i_memRd,
                        o_Q   => o_memRd
                        );

end structural;
