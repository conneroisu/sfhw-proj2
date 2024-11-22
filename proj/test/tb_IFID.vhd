-- <header>
-- Author(s): Karina Hernandez
-- Name: proj/test/tb_IFID.vhd
-- Notes:
--      Karina Hernandez 2024-11-21T10:51:06-06:00 new-IFID-testbench
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_IFID is
end tb_IFID;

architecture behavior of tb_IFID is
component IF_ID_STAGE is
	    port
        (
		i_clk  : in std_logic;
		i_rst  : in std_logic;
		i_flush: in std_logic;
		i_stall: in std_logic;
		i_sctrl: in std_logic; --sign control signal
		o_regw : out std_logic; --register write signal
		i_instr: in std_logic_vector(31 downto 0);
		i_addr : in std_logic_vector(31 downto 0);
		o_instr: out std_logic_vector(31 downto 0);
		o_addr : out std_logic_vector(31 downto 0);
		o_d1   : out std_logic_vector(31 downto 0);
		o_d2   : out std_logic_vector(31 downto 0);
		o_sign : out std_logic_vector(31 downto 0));
        
end component;

signal s_clk 			: std_logic;
signal s_rst 			: std_logic;
signal s_flush 			: std_logic;
signal s_stall 			: std_logic;
signal s_sctrl		   	: std_logic;
signal s_regw 			: std_logic;
signal s_instr  	    	: std_logic_vector(31 downto 0);
signal s_addr 	 		: std_logic_vector(31 downto 0);
signal s_oinstr 	    	: std_logic_vector(31 downto 0);
signal s_oaddr 	 		: std_logic_vector(31 downto 0);
signal s_od1 		        : std_logic_vector(31 downto 0);
signal s_od2    		: std_logic_vector(31 downto 0);
signal s_osign    		: std_logic_vector(31 downto 0);


begin
  
  
DUT0: IF_ID_STAGE
port map(i_clk => s_clk,
	i_rst  => s_rst,
	i_flush=> s_flush,
	i_stall=> s_stall,
	i_sctrl=> s_sctrl,
	o_regw => s_regw, 
	i_instr=> s_instr,
	i_addr => s_addr,
	o_instr=> s_oinstr,
	o_addr => s_oaddr,
	o_d1   => s_od1,
	o_d2   => s_od2,
	o_sign => s_osign);

P_TB: process
begin

----Simple First Test------
	s_clk <= '0';
	s_rst <= '1';
	wait for 10 ns;
	s_rst <= '0';
	wait for 10 ns;
	
	s_stall <= '0';
	s_flush <= '0';
	s_instr <= x"012A4020";
	s_addr <= x"00000001";


	wait for 10 ns;
	s_clk <= '1';
	wait for 10 ns ;
	s_clk <= '0';
	wait for 10 ns ;

	s_stall <= '1';
	s_flush <= '1';
	s_instr <= x"02528022";
	s_addr <= x"00000001";
	



        wait;


    end process;
end behavior;

