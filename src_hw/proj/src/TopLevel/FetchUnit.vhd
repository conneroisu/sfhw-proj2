library IEEE;
use IEEE.std_logic_1164.all;

entity FetchUnit is
    generic (N : integer := 32);  
    
    port (
        i_PC4         : in  std_logic_vector(N - 1 downto 0);  -- Program counter
        i_branch_addr : in  std_logic_vector(N - 1 downto 0);  -- potential branch address
        i_jump_addr   : in  std_logic_vector(N - 1 downto 0);  -- potential jump address
        i_jr          : in  std_logic_vector(N - 1 downto 0);  -- potential jump register address
        i_jr_select   : in  std_logic;  -- jump register selector
        i_branch      : in  std_logic;  -- selects if a branch instruction is active
        i_bne         : in  std_logic;  -- inverts if bne
        i_jump        : in  std_logic;  -- selector for j or jal
        i_A           : in  std_logic_vector(N - 1 downto 0);  -- Reg A value
        i_B           : in  std_logic_vector(N - 1 downto 0);  -- Reg B value
        o_PC          : out std_logic_vector(N - 1 downto 0);  -- program counter output
        o_jump_branch : out std_logic   -- set to 1 if a branch or jump is taken
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

    component Barrel_Shifter is
        port (
            i_data             : in  std_logic_vector(N - 1 downto 0);
            i_logic_arithmetic : in  std_logic;  -- 0 for logical, 1 for arithmetic (sign bit)
            i_left_right       : in  std_logic;  --0 for shift left, 1 for shift right
            i_shamt            : in  std_logic_vector(4 downto 0);  --shift amount
            o_Out              : out std_logic_vector(N - 1 downto 0));  --output of the shifter
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

    component Zero_Detect is
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
    process (i_A, i_B)                  --or, and, xor, nor
    begin
        for i in 0 to 31 loop
            s_XOR(i) <= i_A(i) xor i_B(i);
        end loop;
    end process;

    zero_detector : Zero_Detect
        port map(
            i_F    => s_XOR,
            o_zero => s_zero);

    s_NOTzero    <= not s_zero;
    s_bne_branch <= s_NOTzero xor i_bne;

    --Shift the branch address by 2
    Branch_Shifter : Barrel_Shifter
        port map(
            i_data             => i_branch_addr,
            i_logic_arithmetic => '0',      --always logical shift
            i_left_right       => '0',      --left shift
            i_shamt            => "00010",  --shift left 2
            o_Out              => s_branch_addr_shifted
            );

    PC_Branch_Adder : Full_Adder_N
        port map(
            i_C => '0',                 --no carry
            i_A => i_PC4,
            i_B => s_branch_addr_shifted,
            o_S => s_PC_branch
            );

    Jump_Address_Shift : Barrel_Shifter
        port map(
            i_data             => i_jump_addr,
            i_logic_arithmetic => '0',      --always logical shift
            i_left_right       => '0',      --left shift
            i_shamt            => "00010",  --shift left 2
            o_Out              => s_j_addr_shifted
            );

    --Jump Address
    s_PC_j_addr <= i_PC4(31 downto 28) & s_j_addr_shifted(27 downto 0);

    s_toBranch <= i_branch and s_bne_branch;

    Branch_Select : mux2t1_N
        port map(
            i_S  => s_toBranch,
            i_D0 => i_PC4,
            i_D1 => s_PC_branch,
            o_O  => s_PC_or_Branch
            );

    Jump_Select : mux2t1_N
        port map(
            i_S  => i_jump,
            i_D0 => s_PC_or_Branch,
            i_D1 => s_PC_j_addr,
            o_O  => s_PC_or_j
            );

    JR_Select : mux2t1_N
        port map(
            i_S  => i_jr_select,
            i_D0 => s_PC_or_j,
            i_D1 => i_jr,
            o_O  => o_PC
            );

    o_jump_branch <= s_toBranch or i_jump;

end structural;
