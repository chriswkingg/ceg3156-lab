LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY ALUTestBench IS
END ALUTestBench;

ARCHITECTURE rtl OF ALUTestBench IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT ALU
    PORT(
        i_OPERAND_1    : IN  STD_LOGIC_VECTOR(7 downto 0);
        i_OPERAND_2    : IN  STD_LOGIC_VECTOR(7 downto 0);
        i_OPERATION    : IN  STD_LOGIC_VECTOR(2 downto 0);
        o_RESULT       : OUT STD_LOGIC_VECTOR(7 downto 0);
        o_ZERO         : OUT STD_LOGIC;
        o_OVERFLOW     : OUT STD_LOGIC
        );
    END COMPONENT;
   
   --Inputs
   signal i_OPERAND_1 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
   signal i_OPERAND_2 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
   signal i_OPERATION : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');

    --Outputs
   signal o_RESULT    : STD_LOGIC_VECTOR(7 downto 0);
   signal o_ZERO      : STD_LOGIC;
   signal o_OVERFLOW  : STD_LOGIC;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          i_OPERAND_1 => i_OPERAND_1,
          i_OPERAND_2 => i_OPERAND_2,
          i_OPERATION => i_OPERATION,
          o_RESULT    => o_RESULT,
          o_ZERO      => o_ZERO,
          o_OVERFLOW  => o_OVERFLOW
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- Test case 1: AND operation
      i_OPERAND_1 <= "00001111";
      i_OPERAND_2 <= "00110011";
      i_OPERATION <= "000";  -- AND operation
      wait for 10 ns;

      -- Test case 2: OR operation
      i_OPERAND_1 <= "00001111";
      i_OPERAND_2 <= "00110011";
      i_OPERATION <= "001";  -- OR operation
      wait for 10 ns;

      -- Test case 3: ADD operation
      i_OPERAND_1 <= "00001111";
      i_OPERAND_2 <= "00000001";
      i_OPERATION <= "010";  -- ADD operation
      wait for 10 ns;

      -- Test case 4: SUBTRACT operation
      i_OPERAND_1 <= "00001111";
      i_OPERAND_2 <= "00000001";
      i_OPERATION <= "110";  -- SUB operation
      wait for 10 ns;

      -- Test case 5: SET LESS THAN flag
      i_OPERAND_1 <= "00000001";
      i_OPERAND_2 <= "00000001";
      i_OPERATION <= "111";  -- SUB operation resulting in zero
      wait for 10 ns;

      -- Test case 6: OVERFLOW flag
      i_OPERAND_1 <= "01111111";
      i_OPERAND_2 <= "00000001";
      i_OPERATION <= "010";  -- ADD operation resulting in overflow
      wait for 10 ns;

      -- Add more test cases as needed

      wait;
   end process;

END;
