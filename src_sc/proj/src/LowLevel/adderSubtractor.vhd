-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--      connerohnesorge 2024-12-10T09:22:24-06:00 assert-that-all-of-the-single-cycle-implementation-fits-styleguide
--      Conner Ohnesorge 2024-11-21T11:05:34-06:00 added-old-single-cycle-processor-and-added-documentation-for-the
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MIPS_types.all;

entity adderSubtractor is
    generic (
        N : integer := 32  -- Generic of type integer for input/output data width. Default value is 32.
        );

    port (
        nAdd_Sub   : in  std_logic;
        i_A        : in  std_logic_vector(N - 1 downto 0);  -- Input A
        i_B        : in  std_logic_vector(N - 1 downto 0);  -- Input B
        i_S        : in  std_logic;  -- selects between signed or unsigned operations (signed = 1)
        o_Y        : out std_logic_vector(N - 1 downto 0);  -- Output Y
        o_Cout     : out std_logic;     -- Carry out
        o_Overflow : out std_logic      -- Overflow Indicator
        );

end entity adderSubtractor;

architecture structural of adderSubtractor is
    component mux2t1_N is generic (
        N : integer := 32
        );
                          port (
                              i_s  : in  std_logic;
                              i_d0 : in  std_logic_vector(N - 1 downto 0);
                              i_d1 : in  std_logic_vector(N - 1 downto 0);
                              o_o  : out std_logic_vector(N - 1 downto 0)
                              );
    end component;
    component complementor1_N is generic (
        N : integer := 32
        );
                         port (
                             i_D0 : in  std_logic_vector(N - 1 downto 0);
                             o_O  : out std_logic_vector(N - 1 downto 0)
                             );
    end component;
    component fulladder is
        port (
            i_x0   : in  std_logic;
            i_x1   : in  std_logic;
            i_cin  : in  std_logic;
            o_y    : out std_logic;
            o_cout : out std_logic
            );
    end component;
-- Overflow occurs when:  
    -- Two negative numbers are added and an answer comes positive or 
    -- Two positive numbers are added and an answer comes as negative. 
-- used for overflow detection (if carry value into MSB doesn't match the carry out value, then overflow occured)
    component xorg2 is
        port (i_a : in  std_logic;
              i_b : in  std_logic;
              o_f : out std_logic
              );
    end component;
    component andg2 is
        port (i_a : in  std_logic;
              i_b : in  std_logic;
              o_f : out std_logic
              );
    end component;
    component mux2t1 is
        port (
            i_s  : in  std_logic;       -- selector
            i_d0 : in  std_logic;       -- data inputs
            i_d1 : in  std_logic;       -- data inputs
            o_o  : out std_logic        -- output
            );
    end component;
    signal s_overflow     : std_logic;
    signal c              : std_logic_vector(n downto 0);      -- Carry
    signal s1, s2, s3, s4 : std_logic_vector(n - 1 downto 0);  -- Signals for the 2nd input and the output of the 2nd input.
begin
    -- Invert the 2nd input and output it in wire s1. (used for signed operations)
    inverter : component complementor1_N
        port map(
            i_D0 => i_b,
            o_O  => s1
            );
    addsubctrl1 : component mux2t1_N
        port map(
            i_s  => nadd_sub,
            i_d0 => i_b,
            i_d1 => i_b,
            o_o  => s2
            );
    -- Forward either subtraction signal or addition signal
    addsubctrl2 : component mux2t1_N
        port map(
            i_s  => nadd_sub,
            i_d0 => i_b,
            i_d1 => s1,
            o_o  => s3
            );
    -- Let through either signed/unsigned addition signal, or subtraction signal (inverted)
    -- forward either current signal or inverted (for unsigned subtraction)
    OperationSigned : component mux2t1_N
        port map(
            i_s  => nadd_sub,
            i_d0 => s2,
            i_d1 => s3,
            o_o  => s4
            );
    c(0) <= nadd_sub;    --does 2s complement for signed subtraction only
    g_fulladder : for i in 0 to N - 1 generate  -- create 32 full adders in parallel
        fulladderlist : component fulladder
            port map(
                i_x0   => i_a(i),
                i_x1   => s3(i),
                i_cin  => c(i),
                o_y    => o_y(i),
                o_cout => c(i + 1)
                );
    end generate g_fulladder;
    o_cout     <= c(N);
    s_overflow <= c(N) xor c(N-1);
    overflow_suppression : component andg2
        port map(
            i_a => s_overflow,          -- carry out of MSB
            i_b => i_s,                 -- no overflow on unsigned operations
            o_f => o_overflow
            );
end architecture structural;

