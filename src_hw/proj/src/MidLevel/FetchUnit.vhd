library IEEE;
use IEEE.std_logic_1164.all;

entity FetchUnit is
    generic (N : integer := 32);

    port (
        i_PC4          : in  std_logic_vector(N - 1 downto 0);
        i_BranchAddr   : in  std_logic_vector(N - 1 downto 0);
        i_JumpAddr     : in  std_logic_vector(N - 1 downto 0);
        i_A            : in  std_logic_vector(N - 1 downto 0);
        i_B            : in  std_logic_vector(N - 1 downto 0);
        i_Jr           : in  std_logic;
        i_Branch       : in  std_logic;
        i_Bne          : in  std_logic;
        i_Jump         : in  std_logic;
        o_PC           : out std_logic_vector(N - 1 downto 0);
        o_JumpOrBranch : out std_logic
        );

end FetchUnit;

architecture structural of FetchUnit is

    component mux2t1_N is
        port (
            i_S  : in  std_logic;
            i_D0 : in  std_logic_vector(N - 1 downto 0);
            i_D1 : in  std_logic_vector(N - 1 downto 0);
            o_O  : out std_logic_vector(N - 1 downto 0));
    end component;

    component BarrelShifter is
        port (
            i_data             : in  std_logic_vector(N-1 downto 0);
            i_logic_arithmetic : in  std_logic;  -- 0: logical, 1: arithmetic shift
            i_left_right       : in  std_logic;  -- 0: left shift, 1: right shift
            i_shamt            : in  std_logic_vector(4 downto 0);
            o_Out              : out std_logic_vector(N-1 downto 0)
            );
    end component;

    component Full_Adder_N is
        port (
            i_C        : in  std_logic;  --initial carry
            i_A        : in  std_logic_vector(N - 1 downto 0);
            i_B        : in  std_logic_vector(N - 1 downto 0);
            o_S        : out std_logic_vector(N - 1 downto 0);
            o_C        : out std_logic;
            o_Overflow : out std_logic
            );
    end component;

    component ZeroDetector is
        port (
            i_F    : in  std_logic_vector(31 downto 0);
            o_zero : out std_logic);
    end component;

    signal s_branch_addr_shifted : std_logic_vector(N - 1 downto 0);  --signal for the branch address after shifted left 2
    signal s_PC_branch           : std_logic_vector(N - 1 downto 0);  --signal for PC+4+branchaddr
    signal s_j_addr_shifted      : std_logic_vector(N - 1 downto 0);  --signal for jump address after shift
    signal s_PC_j_addr           : std_logic_vector(N - 1 downto 0);  --signal for PC(31 - 28) + jump address(27 - 0)
    signal s_PC_or_Branch        : std_logic_vector(N - 1 downto 0);  --signal for PC+4 or branch address
    signal s_PC_or_j             : std_logic_vector(N - 1 downto 0);  --signal for PC or branch or jump
    signal s_toBranch            : std_logic;  --signal to determine if you should branch
    signal s_bne_branch          : std_logic;  --signal if bne is active, should invert the zero
    signal s_XOR                 : std_logic_vector(N - 1 downto 0);  --determines if 0
    signal s_NOTzero, s_zero     : std_logic;  --inverse of 0 detection

begin
    process (i_A, i_B)
    begin
        for i in 0 to 31 loop
            s_XOR(i) <= i_A(i) xor i_B(i);
        end loop;
    end process;

    zero_detector : ZeroDetector
        port map(
            i_F    => s_XOR,
            o_zero => s_zero
            );

    s_NOTzero    <= not s_zero;
    s_bne_branch <= s_NOTzero xor i_Bne;

    --Shift the branch address by 2
    instBranchShifter : BarrelShifter
        port map(
            i_data             => i_BranchAddr,
            i_logic_arithmetic => '0',      --always logical shift
            i_left_right       => '0',      --left shift
            i_shamt            => "00010",  --shift left 2
            o_Out              => s_branch_addr_shifted
            );

    instPCBranchAdder : Full_Adder_N
        port map(
            i_C => '0',                 --no carry
            i_A => i_PC4,
            i_B => s_branch_addr_shifted,
            o_S => s_PC_branch
            );

    instJumpAddressShift : BarrelShifter
        port map(
            i_data             => i_JumpAddr,
            i_logic_arithmetic => '0',      --always logical shift
            i_left_right       => '0',      --left shift
            i_shamt            => "00010",  --shift left 2
            o_Out              => s_j_addr_shifted
            );

    --Jump Address
    s_PC_j_addr <= i_PC4(31 downto 28) & s_j_addr_shifted(27 downto 0);

    s_toBranch <= i_Branch and s_bne_branch;

    Branch_Select : mux2t1_N
        port map(
            i_S  => s_toBranch,
            i_D0 => i_PC4,
            i_D1 => s_PC_branch,
            o_O  => s_PC_or_Branch
            );

    Jump_Select : mux2t1_N
        port map(
            i_S  => i_Jump,
            i_D0 => s_PC_or_Branch,
            i_D1 => s_PC_j_addr,
            o_O  => s_PC_or_j
            );

    JR_Select : mux2t1_N
        port map(
            i_S  => i_Jr,
            i_D0 => s_PC_or_j,
            i_D1 => i_A,
            o_O  => o_PC
            );

    o_JumpOrBranch <= s_toBranch or i_Jump;

end structural;
