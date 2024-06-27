LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY SignExtend16To32BitModuleTestBench IS
END SignExtend16To32BitModuleTestBench;

ARCHITECTURE behavior OF SignExtend16To32BitModuleTestBench IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT SignExtend16To32BitModule
    PORT(
        i_OPERAND : IN  std_logic_vector(15 downto 0);
        o_OUTPUT  : OUT std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    
    -- Inputs
    signal i_OPERAND : std_logic_vector(15 downto 0) := (others => '0');

    -- Outputs
    signal o_OUTPUT : std_logic_vector(31 downto 0);


BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: SignExtend16To32BitModule PORT MAP (
          i_OPERAND => i_OPERAND,
          o_OUTPUT  => o_OUTPUT
        );

    -- Stimulus process
    stim_proc: process
    begin		
        -- Test vector 1: Positive number
        i_OPERAND <= "0000000000000001";  -- 1
        wait for 10 ns;
        assert o_OUTPUT = "00000000000000000000000000000001";
        
        -- Test vector 2: Negative number
        i_OPERAND <= "1000000000000000";  -- -32768
        wait for 10 ns;
        assert o_OUTPUT = "11111111111111111000000000000000";

        -- Test vector 3: Mixed positive bits
        i_OPERAND <= "0111111111111111";  -- 32767
        wait for 10 ns;
        assert o_OUTPUT = "00000000000000000111111111111111";
        
        -- Test vector 4: Mixed negative bits
        i_OPERAND <= "1111111111111111";  -- -1
        wait for 10 ns;
        assert o_OUTPUT = "11111111111111111111111111111111";

        -- Test vector 5: Zero
        i_OPERAND <= "0000000000000000";  -- 0
        wait for 10 ns;
        assert o_OUTPUT = "00000000000000000000000000000000";
        
        -- Test vector 6: Random positive number
        i_OPERAND <= "0000111100001111";  -- 3855
        wait for 10 ns;
        assert o_OUTPUT = "00000000000000000000111100001111";
        
        -- Test vector 7: Random negative number
        i_OPERAND <= "1111000011110001";  -- -3855
        wait for 10 ns;
        assert o_OUTPUT = "11111111111111111111000011110001";

        -- Stop the simulation
        wait;
    end process;

END;
