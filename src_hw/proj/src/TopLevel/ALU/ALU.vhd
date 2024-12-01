-- <header>
-- Author(s): Conner Ohnesorge, Kariniux
-- Name: proj/src/TopLevel/ALU/ALU.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-21T10:25:45-06:00 remove-unused-declarations-from-the-ALU
--      Kariniux 2024-11-21T09:04:48-06:00 pushing-pulling
--      Conner Ohnesorge 2024-11-18T10:09:46-06:00 fix-spacing-in-alu.vhd
--      Conner Ohnesorge 2024-11-13T10:12:57-06:00 save-stage-progess
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use work.MIPS_types.all;

entity ALU is
  generic (N : integer := 32);

  port (
    i_ALUCtrl : in std_logic_vector(4 downto 0);
    i_Data_0  : in std_logic_vector(N-1 downto 0);
    i_Data_1  : in std_logic_vector(N-1 downto 0);
    i_shamt   : in std_logic_vector(4 downto 0);

    o_ALUOut   : out std_logic_vector(N-1 downto 0);
    o_Cout     : out std_logic;
    o_Overflow : out std_logic
    );

end ALU;

architecture mixed of ALU is
  signal s_nData_1     : std_logic_vector(N-1 downto 0);
  signal s_AddSub_Data : std_logic_vector(N-1 downto 0);
  signal s_sum         : std_logic_vector(N-1 downto 0);
  signal s_overflow    : std_logic;

  signal s_and_or        : std_logic_vector(N-1 downto 0);
  signal s_slt           : std_logic_vector(N-1 downto 0);
  signal s_bshift_out    : std_logic_vector(N-1 downto 0);
  signal s_alu_bus_array : bus_array(15 downto 0)(N-1 downto 0);

  signal s_nil : std_logic_vector(N-1 downto 0);
  --Output of the 2t1 n-bit mux that controls immediate/register op

  component inverter_N is
    generic (
      N : integer := 16
      );

    port (
      i_Data : in  std_logic_vector(N-1 downto 0);
      o_Data : out std_logic_vector(N-1 downto 0)
      );

  end component;

  component mux2t1_N is
    generic(
      N : integer := 16
      );

    port (
      i_S  : in  std_logic;
      i_D0 : in  std_logic_vector(N-1 downto 0);
      i_D1 : in  std_logic_vector(N-1 downto 0);
      o_O  : out std_logic_vector(N-1 downto 0)
      );

  end component;

  component mux_Nt1 is
    generic (
      bus_width : integer := 32;
      sel_width : integer := 5
      );

    port (
      --2D array of [2^sel_width][bus_width] size
      --Array width must be an int that represents the size, not treated as a binary
      i_reg_bus : in  bus_array(2**sel_width - 1 downto 0)(bus_width-1 downto 0);
      i_sel     : in  std_logic_vector(sel_width-1 downto 0);
      o_reg     : out std_logic_vector(bus_width-1 downto 0)
      );

  end component;

  component logic_N
    generic (N : integer := 32);

    port (
      i_D0     : in  std_logic_vector(N-1 downto 0);
      i_D1     : in  std_logic_vector(N-1 downto 0);
      i_op     : in  std_logic_vector(1 downto 0);
      o_result : out std_logic_vector(N-1 downto 0)
      );
  end component;

  component ripple_adder is
    generic(
      N : integer := 32
      );

    port (
      i_A    : in  std_logic_vector(N-1 downto 0);
      i_B    : in  std_logic_vector(N-1 downto 0);
      i_Cin  : in  std_logic;
      o_Sum  : out std_logic_vector(N-1 downto 0);
      o_Cout : out std_logic
      );
  end component;

  component size_filter is
    generic (N : integer := 32);
    port (
      i_D0     : in  std_logic_vector(N-1 downto 0);
      i_D1     : in  std_logic_vector(N-1 downto 0);
      o_result : out std_logic_vector(N-1 downto 0)
      );
  end component;

  component barrel_shifter is
    port (
      i_shamt       : in  std_logic_vector(4 downto 0);  --01001 would do shift 3 and shift 0, mux each bit to decide how much to shift
      i_data        : in  std_logic_vector(N - 1 downto 0);
      i_leftOrRight : in  std_logic;    --0=right, 1=left
      i_shiftType   : in  std_logic;  --0 for logicical shift, 1 for arithmetic shift
      o_O           : out std_logic_vector(N - 1 downto 0)  --shifted output
      );

  end component;

begin
  s_nil <= x"CCCCCCCC";

  inverter       : inverter_N generic map (N) port map (i_Data_1, s_nData_1);
  mux_2t1_addsub : mux2t1_N generic map (N) port map (i_ALUCtrl(2), i_Data_1, s_nData_1, s_AddSub_Data);
  adder          : ripple_adder generic map (N) port map (i_Data_0, s_AddSub_Data, i_ALUCtrl(2), s_sum, o_Cout);

  inst_Logic : logic_N
    port map (i_Data_0, i_Data_1, i_ALUCtrl(1 downto 0), s_and_or);

  slt_mod : size_filter
    port map (i_Data_0, i_Data_1, s_slt);

  barrel_shift : barrel_shifter
    generic map (N => 32)
    port map (
      i_shamt,
      i_Data_1,
      (i_ALUCtrl(0) and i_ALUCtrl(1)),
      i_ALUCtrl(0) xor i_ALUCtrl(1),
      s_bshift_out
      );

  -- s_nli is used to satisfy compiler 
  s_alu_bus_array <= (0  => s_and_or,
                      1  => s_and_or,
                      2  => s_nil,
                      3  => s_nil,
                      4  => s_nil,
                      5  => s_nil,
                      6  => s_and_or,
                      7  => s_and_or,
                      8  => s_nil,
                      9  => s_dummy,
                      10 => s_sum,
                      11 => s_bshift_out,
                      12 => s_bshift_out,
                      13 => s_bshift_out,
                      14 => s_sum,
                      15 => s_slt
                      );

  out_mux : mux_Nt1
    generic map (
      bus_width => N,
      sel_width => 4
      )
    port map (
      s_alu_bus_array,
      i_ALUCtrl(3 downto 0),
      o_ALUOut
      );

  with i_ALUCtrl select
    -- Addition overflow, if input signs are the same and output different then overflow has occurred
    s_Overflow <= (
      (i_Data_0(31) and i_Data_1(31) and (not s_sum(31)))
      or
      ((not i_Data_0(31)) and (not i_Data_1(31)) and s_sum(31))) when b"11010",
    -- Subtraction overflow, if input signs are different, and result has same sign of input data 1 then overflow has occurred
    ((i_Data_0(31) xor i_Data_1(31)) and (s_sum(31) and i_Data_1(31)))
    or
    ((i_Data_0(31) xor i_Data_1(31)) and (not s_sum(31) and not i_Data_1(31))) when b"11110",
    '0'                                                                        when others;

  --Overflow depends on whether the instruction is for signed/unsigned operation
  o_Overflow <= (s_Overflow and i_ALUCtrl(4));
end mixed;
