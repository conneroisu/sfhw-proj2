-- <header>
-- Author(s): Kariniux
-- Name: proj/src/TopLevel/IF_ID_STAGE.vhd
-- Notes:
--      Kariniux 2024-11-14T09:50:52-06:00 Merge-branch-main-into-IF-ID
--      Kariniux 2024-11-14T09:46:15-06:00 updates-to-the-IF-ID-stage.-still-not-complete
--      Kariniux 2024-11-14T08:17:43-06:00 IF_ID-stage
-- </header>

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IF_ID_STAGE is

	    port
        (
		i_clk  : in std_logic;
		i_rst  : in std_logic;
		i_flush: in std_logic;
		i_stall: in std_logic;
		i_sctrl: in std_logic; --sign control signal
		i_wA   : in std_logic_vector(4 downto 0); -- input write address from the later stage
		i_write: in std_logic_vector(31 downto 0); --input write data which should come from later stage
		i_addr : in std_logic_vector(31 downto 0); --saved address where the instruction lives
		i_instr: in std_logic_vector(31 downto 0); --saved instruction
		o_regw : out std_logic; --register write signal
		o_instr: out std_logic_vector(31 downto 0);
		o_addr : out std_logic_vector(31 downto 0);
		o_d1   : out std_logic_vector(31 downto 0);
		o_d2   : out std_logic_vector(31 downto 0);
		o_sign : out std_logic_vector(31 downto 0));
        
end IF_ID_STAGE;
architecture structure of IF_ID_STAGE is


component dffg_n is
    generic(N : integer := 32);
    port(
        i_CLK : in  std_logic;                       -- Clock input
        i_RST : in  std_logic;                       -- Reset input
        i_WrE : in  std_logic;                       -- Write enable input
        i_D   : in  std_logic_vector(N-1 downto 0);  -- Data input
        o_Q   : out std_logic_vector(N-1 downto 0)   -- Data output
        );
end component;

component register_file is
    port
        (   clk   : in  std_logic;                      -- Clock input
            i_wA  : in  std_logic_vector(4 downto 0);   -- Write address input
            i_wD  : in  std_logic_vector(31 downto 0);  -- Write data input
            i_wC  : in  std_logic;                      -- Write enable input
            i_r1  : in  std_logic_vector(4 downto 0);   -- Read address 1 input
            i_r2  : in  std_logic_vector(4 downto 0);   -- Read address 2 input
            reset : in  std_logic;                      -- Reset input
            o_d1  : out std_logic_vector(31 downto 0);  -- Read data 1 output
            o_d2  : out std_logic_vector(31 downto 0)   -- Read data 2 output
            );
end component;

component extender16t32 is
    port(
        i_I : in  std_logic_vector(15 downto 0);  -- 16 bit immediate
        i_C : in  std_logic;            -- signed extender or unsigned
        o_O : out std_logic_vector(31 downto 0)   -- 32 bit extended immediate
        );
end component;


--signals
    signal s_instr: std_logic_vector(31 downto 0);
    signal s_d1   : std_logic_vector(31 downto 0);
    signal s_d2   : std_logic_vector(31 downto 0);
    signal s_addr: std_logic_vector(31 downto 0);
    signal s_addrFlush, s_instrFlush : std_logic_vector(31 downto 0);
    signal s_regw, s_en   : std_logic;
    signal s_Shamt  : std_logic_vector(4 downto 0);
    signal s_Rs     : std_logic_vector(4 downto 0);
    signal s_Rt     : std_logic_vector(4 downto 0);
    signal s_Rd     : std_logic_vector(4 downto 0);
    signal s_Imm    : std_logic_vector(15 downto 0);
    signal s_Funct  : std_logic_vector(5 downto 0);

    signal s_opcode : std_logic_vector(5 downto 0);
    signal si_Rs    : std_logic_vector(4 downto 0);
    signal si_Rt    : std_logic_vector(4 downto 0);
    signal si_Rd    : std_logic_vector(4 downto 0);
    signal si_Shamt : std_logic_vector(4 downto 0);
    signal si_Funct : std_logic_vector(5 downto 0);
    signal si_Imm   : std_logic_vector(15 downto 0);
begin


	    ----------------------------------------------------------------------logic

		InstProc : process(s_opcode, i_instr, s_Rt, s_Rs, s_Rd, s_Shamt, s_Funct, s_Imm)
    begin
        s_opcode <= i_instr(31 downto 26);
        case s_opcode is
            --      R-format instructions (opcode = 000000)
            -- |31    26|25  21|20  16|15  11|10    6|5     0|
            -- |---------------------------------------------|
            -- | opcode |  rs  |  rt  |  rd  | shamt | funct |
            -- |---------------------------------------------|
            -- |6 bits  |5 bits|5 bits|5 bits|5 bits |6 bits |
            when "000000" =>
                si_Rs    <= i_instr(25 downto 21);
                si_Rt    <= i_instr(20 downto 16);
                si_Rd    <= i_instr(15 downto 11);
                si_Shamt <= i_instr(10 downto 6);
                si_Funct <= i_instr(5 downto 0);
                si_Imm   <= (others => '0');
            --      J-format instructions (opcode = 000010 or 000011)
            -- |31    26|25                                 0|
            -- |---------------------------------------------|
            -- | opcode |         address                    |
            -- |---------------------------------------------|
            -- |6 bits  |        26 bits                     |
            when "000010" | "000011" =>
                si_Rs    <= (others => '0');
                si_Rt    <= (others => '0');
                si_Rd    <= (others => '0');
                si_Shamt <= (others => '0');
                si_Funct <= (others => '0');
                si_Imm   <= (others => '0');
            --      I-format instructions (all other opcodes)
            -- |31    26|25  21|20  16|15                   0|
            -- |---------------------------------------------|
            -- | opcode |  rs  |  rt  |       immediate      |
            -- |---------------------------------------------|
            -- |6 bits  |5 bits|5 bits|       16 bits        |
            when others =>
                si_Rs    <= i_instr(25 downto 21);
                si_Rt    <= i_instr(20 downto 16);
                si_Rd    <= (others => '0');
                si_Shamt <= (others => '0');
                si_Funct <= (others => '0');
                si_Imm   <= i_instr(15 downto 0);
        end case;
    end process;


s_addrFlush <= (others => '0') when i_flush = '1' else i_addr;
s_instrFlush <= (others => '0') when i_flush = '1' else i_instr;

s_en <= '0' when (i_rst = '1' or i_stall = '1') else '1';
s_regw <= '0' when (i_rst = '1' or i_stall = '1') else
          '1' when (i_instr(31 downto 26) = "000000" and i_instr(5 downto 0) /= "001000") else -- R-format, excluding `jr`
          '1' when (i_instr(31 downto 26) /= "000000" and i_instr(31 downto 26) /= "000010" and i_instr(31 downto 26) /= "000011") else -- I-format
          '1' when (i_instr(31 downto 26) = "000011") else -- jal
          '0'; -- Default case for all other instructions



CurrentInstruction: dffg_n 
	port map(
		i_CLK => i_clk, -- rising edge?
		i_RST => i_rst,
		i_WrE  => s_en,
		i_D   => s_instrFlush,
		o_Q   => s_instr);

NextInstruction: dffg_n 
	port map(
		i_CLK => i_clk,
		i_RST => i_rst,
		i_WrE  => s_en,
		i_D   => s_addrFlush,
		o_Q   => s_addr);

RegFile0: register_file
	port map(
		clk   => i_clk,
		reset => i_rst,
		i_wC  => s_regw, -- Write enable input
		i_wA  => i_wA, --write address
		i_wD  => i_write,
		i_r1  => i_instr(25 downto 21),
		i_r2  => i_instr(20 downto 16),
		o_d1  => s_d1,
		o_d2  => s_d2);


SignExt0: extender16t32
	port map(
		i_I => i_instr(15 downto 0),
		i_C => i_sctrl,
		o_O => o_sign
	);
--o_d1 <= si_Rs;
--o_d2 <= si_Rt;
o_d1 <= s_d1;
o_d2 <= s_d2;
o_regw <= s_regw;
o_instr <= s_instr;
o_addr <= s_addr;

end structure;