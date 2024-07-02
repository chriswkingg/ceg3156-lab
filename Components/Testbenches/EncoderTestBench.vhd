LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EncoderTestBench IS
END ENTITY EncoderTestBench;

ARCHITECTURE behavior OF EncoderTestBench IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT EigthToThreeEncoder
    PORT 
    (
        inputs : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        outputs : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
    END COMPONENT;

    --Inputs
    signal inputs : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
    --Outputs
    signal outputs : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: EigthToThreeEncoder PORT MAP (
        inputs => inputs,
        outputs => outputs
    );

    -- Stimulus process
    stim_proc: process
    begin        
        -- Test case 1
        inputs <= "00000000";
        wait for 10 ns;
        
        -- Test case 2
        inputs <= "00000001";
        wait for 10 ns;

        -- Test case 3
        inputs <= "00000010";
        wait for 10 ns;
        
        -- Test case 4
        inputs <= "00000100";
        wait for 10 ns;

        -- Test case 5
        inputs <= "00001000";
        wait for 10 ns;

        -- Add more test cases as needed

        wait;
    end process;

END;
