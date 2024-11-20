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
		i_regw : in std_logic; --register write signal
		i_addr : in std_logic_vector(31 downto 0);
		i_instr: in std_logic_vector(31 downto 0);
		o_instr: out std_logic_vector(31 downto 0);
		o_addr : out std_logic_vector(31 downto 0);
		o_d1   : out std_logic_vector(31 downto 0);
		o_d2   : out std_logic_vector(31 downto 0);


		--multiple outputs to make it easier to connect them to the next stage
		o_ctrl : out std_logic_vector(5 downto 0); -- bits that go to control 
		o_ex1  : out std_logic_vector(4 downto 0); -- bits that go to ID/EX 20 downto 16
		o_ex2  : out std_logic_vector(4 downto 0); -- bits that go to ID/EX  15 downto 11
		o_sign : out std_logic_vector(31 downto 0));
        
end IF_ID_STAGE;
architecture structure of IF_ID_STAGE is

--signals
signal s_instr: std_logic_vector(31 downto 0);
signal s_addr: std_logic_vector(31 downto 0);
signal s_d1, s_d2 : std_logic_vector(31 downto 0);

component dffg_n is
    generic (
        n : integer := 32
        );
    port (
        i_clk : in  std_logic;                         -- Clock Input
        i_rst : in  std_logic;                         -- Reset Input
        i_we  : in  std_logic;                         -- Write Enable Input
        i_d   : in  std_logic_vector(n - 1 downto 0);  -- Data Value input
        o_q   : out std_logic_vector(n - 1 downto 0)   -- Data Value output
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
        i_I : in  std_logic_vector(15 downto 0);      -- 16 bit immediate
        i_C : in  std_logic;            -- signed extender or unsigned
        o_O : out std_logic_vector(31 downto 0)  -- 32 bit extended immediate
        );
end component;

begin

CurrentInstruction: dffg_n 
	port map(
		i_clk => i_clk,
		i_rst => i_rst,
		i_we  => NOT i_stall,
		i_d   => (others => '0') when i_flush = '1' else i_instr;
		o_q   => s_instr);

NextInstruction: dffg_n 
	port map(
		i_clk => i_clk,
		i_rst => i_rst,
		i_we  => NOT i_stall,
		i_d   => (others => '0') when i_flush = '1' else i_addr;
		o_q   => s_addr);

RegFile0: register_file
	port map(
		clk   => i_clk,
		reset => i_rst,
		i_wC  => i_regw, -- Write enable input
		i_wA  => i_instr(15 downto 11), --write address
		i_wD  => i_instr,
		i_r1  => i_instr(25 downto 21),
		i_r2  => i_instr(20 downto 16),
		o_d1  => s_d1,
		o_d2  => s_d1);


SignExt0: extender16t32
	port map(
		i_I => i_instr(15 downto 0),
		i_C => i_sctrl,
		o_O => o_sign
	);


o_d1 <= s_d1;
o_d2 <= s_d2;
o_instr <= s_instr;
o_addr  <= s_addr;

o_ctrl <= s_instr(31 downto 26);
o_ex1  <= s_instr(20 downto 16);
o_ex2  <= s_instr(15 downto 11);


end structure;