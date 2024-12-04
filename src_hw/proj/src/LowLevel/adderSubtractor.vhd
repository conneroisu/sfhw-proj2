library IEEE;
use IEEE.std_logic_1164.all;

entity adderSubtractor is
    generic (N : integer := 32);  -- Using 16 because that is the max of the 2to1 MUX

    port (
        nAdd_Sub  : in  std_logic;
        i_A       : in  std_logic_vector(N - 1 downto 0);
        i_B       : in  std_logic_vector(N - 1 downto 0);
        o_S       : out std_logic_vector(N - 1 downto 0);
        o_C, o_OF : out std_logic
        );

end adderSubtractor;

architecture structural of adderSubtractor is

    component full_adder_N is
        generic (N : integer := 32);
        port (
            i_A        : in  std_logic_vector(N - 1 downto 0);
            i_B        : in  std_logic_vector(N - 1 downto 0);
            i_C        : in  std_logic;
            o_S        : out std_logic_vector(N - 1 downto 0);
            o_C        : out std_logic;
            o_Overflow : out std_logic
            );
    end component;

    component comp1_N is
        generic (N : integer := 32);  -- Generic of type integer for input/output data width. Default value is 32.
        port (
            i_D0 : in  std_logic_vector(N - 1 downto 0);
            o_O  : out std_logic_vector(N - 1 downto 0)
            );
    end component;

    component mux2t1_N is
        generic (N : integer := 32);  -- Generic of type integer for input/output data width. Default value is 32.
        port (
            i_S  : in  std_logic;
            i_D0 : in  std_logic_vector(N - 1 downto 0);
            i_D1 : in  std_logic_vector(N - 1 downto 0);
            o_O  : out std_logic_vector(N - 1 downto 0)
            );
    end component;

    signal n_B   : std_logic_vector(N - 1 downto 0);  --not B, used for subtraction
    signal mux_B : std_logic_vector(N - 1 downto 0);  --B after the multiplexor
begin

    OnesComp1 : comp1_N
        port map(
            i_D0 => i_B,
            o_O  => n_B
            );

    MUX1 : mux2t1_N
        port map(
            i_S  => nAdd_Sub,
            i_D0 => i_B,
            i_D1 => n_B,  --chooses regular b for a select of 0, and not b for a select of 1
            o_O  => mux_B
            );

    FullAdderN1 : Full_Adder_N
        port map(
            i_A        => i_A,
            i_B        => mux_B,
            i_C        => nAdd_Sub,
            o_S        => o_S,
            o_C        => o_C,
            o_Overflow => o_OF
            );
end structural;
