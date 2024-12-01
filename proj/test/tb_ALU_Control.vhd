library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all; -- For logic types I/O
use std.textio.all;

entity tb_alu_control is
end tb_alu_control;

architecture structural of tb_alu_control is
  component alu_control_logic is
    port (
      i_funct  : in  std_logic_vector(5 downto 0);
      i_ALUOp  : in  std_logic_vector(2 downto 0);
      o_ALUSel : out std_logic_vector(4 downto 0)
    );
  end component;

  -- Instruction inputs
  signal s_iFunct  : std_logic_vector(5 downto 0); -- 6-bit MIPS function code from instruction memory
  signal s_iALUOp  : std_logic_vector(2 downto 0); -- 3-bit ALU operation code

  -- Module outputs
  signal s_oALUSel : std_logic_vector(4 downto 0); -- ALU Select output

  -- Function to convert std_logic_vector to string
  function to_string(slv : std_logic_vector) return string is
    variable result : string(1 to slv'length);
  begin
    for i in slv'range loop
      if slv(i) = '1' then
        result(slv'length - i + 1) := '1';
      else
        result(slv'length - i + 1) := '0';
      end if;
    end loop;
    return result;
  end function;

begin
  DUT0 : alu_control_logic port map(s_iFunct, s_iALUOp, s_oALUSel);

  -- Testbench process with assertions and printing
  P_TEST : process
    variable test_count     : integer := 0;
    variable fail_count     : integer := 0;
    variable expected_oALUSel : std_logic_vector(4 downto 0);
  begin
    -- ADD instruction test
    s_iALUOp <= "000";
    s_iFunct <= "100000";
    wait for 5 ns;
    expected_oALUSel := "11010";
    test_count := test_count + 1;
    if s_oALUSel /= expected_oALUSel then
      fail_count := fail_count + 1;
      report "Test ADD failed: Expected o_ALUSel = " & to_string(expected_oALUSel) &
             ", got " & to_string(s_oALUSel) severity error;
    else
      report "Test ADD passed";
    end if;

    -- ADDI instruction test
    s_iALUOp <= "001";
    s_iFunct <= (others => '0'); -- Function code is don't care
    wait for 5 ns;
    expected_oALUSel := "11010";
    test_count := test_count + 1;
    if s_oALUSel /= expected_oALUSel then
      fail_count := fail_count + 1;
      report "Test ADDI failed: Expected o_ALUSel = " & to_string(expected_oALUSel) &
             ", got " & to_string(s_oALUSel) severity error;
    else
      report "Test ADDI passed";
    end if;

    -- ADDIU instruction test
    s_iALUOp <= "010";
    s_iFunct <= (others => '0');
    wait for 5 ns;
    expected_oALUSel := "01010";
    test_count := test_count + 1;
    if s_oALUSel /= expected_oALUSel then
      fail_count := fail_count + 1;
      report "Test ADDIU failed: Expected o_ALUSel = " & to_string(expected_oALUSel) &
             ", got " & to_string(s_oALUSel) severity error;
    else
      report "Test ADDIU passed";
    end if;

    -- ADDU instruction test
    s_iALUOp <= "000";
    s_iFunct <= "100001";
    wait for 5 ns;
    expected_oALUSel := "01010";
    test_count := test_count + 1;
    if s_oALUSel /= expected_oALUSel then
      fail_count := fail_count + 1;
      report "Test ADDU failed: Expected o_ALUSel = " & to_string(expected_oALUSel) &
             ", got " & to_string(s_oALUSel) severity error;
    else
      report "Test ADDU passed";
    end if;

    -- AND instruction test
    s_iALUOp <= "000";
    s_iFunct <= "100100";
    wait for 5 ns;
    expected_oALUSel := "00000";
    test_count := test_count + 1;
    if s_oALUSel /= expected_oALUSel then
      fail_count := fail_count + 1;
      report "Test AND failed: Expected o_ALUSel = " & to_string(expected_oALUSel) &
             ", got " & to_string(s_oALUSel) severity error;
    else
      report "Test AND passed";
    end if;

    -- ANDI instruction test
    s_iALUOp <= "011";
    s_iFunct <= (others => '0');
    wait for 5 ns;
    expected_oALUSel := "00000";
    test_count := test_count + 1;
    if s_oALUSel /= expected_oALUSel then
      fail_count := fail_count + 1;
      report "Test ANDI failed: Expected o_ALUSel = " & to_string(expected_oALUSel) &
             ", got " & to_string(s_oALUSel) severity error;
    else
      report "Test ANDI passed";
    end if;

    -- OR instruction test
    s_iALUOp <= "000";
    s_iFunct <= "100101";
    wait for 5 ns;
    expected_oALUSel := "00001";
    test_count := test_count + 1;
    if s_oALUSel /= expected_oALUSel then
      fail_count := fail_count + 1;
      report "Test OR failed: Expected o_ALUSel = " & to_string(expected_oALUSel) &
             ", got " & to_string(s_oALUSel) severity error;
    else
      report "Test OR passed";
    end if;

    -- ORI instruction test
    s_iALUOp <= "101";
    s_iFunct <= (others => '0');
    wait for 5 ns;
    expected_oALUSel := "00001";
    test_count := test_count + 1;
    if s_oALUSel /= expected_oALUSel then
      fail_count := fail_count + 1;
      report "Test ORI failed: Expected o_ALUSel = " & to_string(expected_oALUSel) &
             ", got " & to_string(s_oALUSel) severity error;
    else
      report "Test ORI passed";
    end if;

    -- XOR instruction test
    s_iALUOp <= "000";
    s_iFunct <= "100110";
    wait for 5 ns;
    expected_oALUSel := "00111";
    test_count := test_count + 1;
    if s_oALUSel /= expected_oALUSel then
      fail_count := fail_count + 1;
      report "Test XOR failed: Expected o_ALUSel = " & to_string(expected_oALUSel) &
             ", got " & to_string(s_oALUSel) severity error;
    else
      report "Test XOR passed";
    end if;

    -- XORI instruction test
    s_iALUOp <= "100";
    s_iFunct <= (others => '0');
    wait for 5 ns;
    expected_oALUSel := "00111";
    test_count := test_count + 1;
    if s_oALUSel /= expected_oALUSel then
      fail_count := fail_count + 1;
      report "Test XORI failed: Expected o_ALUSel = " & to_string(expected_oALUSel) &
             ", got " & to_string(s_oALUSel) severity error;
    else
      report "Test XORI passed";
    end if;

    -- NOR instruction test
    s_iALUOp <= "000";
    s_iFunct <= "100111";
    wait for 5 ns;
    expected_oALUSel := "00110";
    test_count := test_count + 1;
    if s_oALUSel /= expected_oALUSel then
      fail_count := fail_count + 1;
      report "Test NOR failed: Expected o_ALUSel = " & to_string(expected_oALUSel) &
             ", got " & to_string(s_oALUSel) severity error;
    else
      report "Test NOR passed";
    end if;

    -- SLT instruction test
    s_iALUOp <= "000";
    s_iFunct <= "101010";
    wait for 5 ns;
    expected_oALUSel := "01111";
    test_count := test_count + 1;
    if s_oALUSel /= expected_oALUSel then
      fail_count := fail_count + 1;
      report "Test SLT failed: Expected o_ALUSel = " & to_string(expected_oALUSel) &
             ", got " & to_string(s_oALUSel) severity error;
    else
      report "Test SLT passed";
    end if;

    -- SLTI instruction test
    s_iALUOp <= "110";
    s_iFunct <= (others => '0');
    wait for 5 ns;
    expected_oALUSel := "01111";
    test_count := test_count + 1;
    if s_oALUSel /= expected_oALUSel then
      fail_count := fail_count + 1;
      report "Test SLTI failed: Expected o_ALUSel = " & to_string(expected_oALUSel) &
             ", got " & to_string(s_oALUSel) severity error;
    else
      report "Test SLTI passed";
    end if;

    -- SLL instruction test
    s_iALUOp <= "000";
    s_iFunct <= "000000";
    wait for 5 ns;
    expected_oALUSel := "01011";
    test_count := test_count + 1;
    if s_oALUSel /= expected_oALUSel then
      fail_count := fail_count + 1;
      report "Test SLL failed: Expected o_ALUSel = " & to_string(expected_oALUSel) &
             ", got " & to_string(s_oALUSel) severity error;
    else
      report "Test SLL passed";
    end if;

    -- SRL instruction test
    s_iALUOp <= "000";
    s_iFunct <= "000010";
    wait for 5 ns;
    expected_oALUSel := "01100";
    test_count := test_count + 1;
    if s_oALUSel /= expected_oALUSel then
      fail_count := fail_count + 1;
      report "Test SRL failed: Expected o_ALUSel = " & to_string(expected_oALUSel) &
             ", got " & to_string(s_oALUSel) severity error;
    else
      report "Test SRL passed";
    end if;

    -- SRA instruction test
    s_iALUOp <= "000";
    s_iFunct <= "000011";
    wait for 5 ns;
    expected_oALUSel := "01101";
    test_count := test_count + 1;
    if s_oALUSel /= expected_oALUSel then
      fail_count := fail_count + 1;
      report "Test SRA failed: Expected o_ALUSel = " & to_string(expected_oALUSel) &
             ", got " & to_string(s_oALUSel) severity error;
    else
      report "Test SRA passed";
    end if;

    -- SUB instruction test
    s_iALUOp <= "000";
    s_iFunct <= "100010";
    wait for 5 ns;
    expected_oALUSel := "11110";
    test_count := test_count + 1;
    if s_oALUSel /= expected_oALUSel then
      fail_count := fail_count + 1;
      report "Test SUB failed: Expected o_ALUSel = " & to_string(expected_oALUSel) &
             ", got " & to_string(s_oALUSel) severity error;
    else
      report "Test SUB passed";
    end if;

    -- SUBU instruction test
    s_iALUOp <= "000";
    s_iFunct <= "100011";
    wait for 5 ns;
    expected_oALUSel := "01110";
    test_count := test_count + 1;
    if s_oALUSel /= expected_oALUSel then
      fail_count := fail_count + 1;
      report "Test SUBU failed: Expected o_ALUSel = " & to_string(expected_oALUSel) &
             ", got " & to_string(s_oALUSel) severity error;
    else
      report "Test SUBU passed";
    end if;

    -- Final report
    report "Testbench completed: " & integer'image(test_count - fail_count) & " tests passed, " &
           integer'image(fail_count) & " tests failed.";

    wait;
  end process;

end structural;
