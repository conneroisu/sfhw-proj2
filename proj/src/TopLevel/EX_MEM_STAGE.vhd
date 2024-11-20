-- <header>
-- Author(s): aidanfoss
-- Name: proj/src/TopLevel/EX_MEM_STAGE.vhd
-- Notes:
--      conneroisu 2024-11-11T15:42:29Z Format-and-Header
--      aidanfoss 2024-11-07T09:50:56-06:00 fix
--      aidanfoss 2024-11-07T09:37:43-06:00 create-exmem-stage
-- </header>

library ieee;
use ieee.std_logic_1164.all;
use iee.numeric_std.all;

entity EX_MEM_STAGE is
    generic
        (
            DATA_WIDTH : natural := 32;
            ADDR_WIDTH : natural := 32;
            )
        port
        (
            i_aluOut : in  std_logic_vector((DATA_WIDTH -1) downto 0);
            o_aluOut : out std_logic_vector((DATA_WIDTH -1) downto 0);
            i_input  : in  std_logic_vector((DATA_WIDTH -1) downto 0);
            o_output : out std_logic_vector((DATA_WIDTH -1) downto 0);
            i_mux    : in  std_logic_vector((DATA_WIDTH -1) downto 0);
            o_mux    : in  std_logic_vector((DATA_WIDTH -1) downto 0);

            --THIS IS WRONG. FIX!
            i_regWrite : in std_logic;
            i_memToReg : in std_logic;
            i_memRead  : in std_logic;
            i_memWrite : in std_logic;
            i_pcSRC    : in std_logic;
            o_regWrite : in std_logic;
            o_memToReg : in std_logic;
            o_memRead  : in std_logic;
            o_memWrite : in std_logic;
            o_pcSRC    : in std_logic;
            )

