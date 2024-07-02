LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY NineBitAdderSubtractorTestBench IS
END ENTITY NineBitAdderSubtractorTestBench;

ARCHITECTURE behavior OF NineBitAdderSubtractorTestBench IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT NineBitAdderSubtractor
    PORT
    (
        InputA, InputB  : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        Operation   :   IN STD_LOGIC;
        Result    :   OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
        CarryOUT    :   OUT STD_LOGIC
    );
    END COMPONENT;

    --Inputs
    signal InputA : STD_LOGIC_VECTOR(8 DOWNTO 0);
    signal InputB : STD_LOGIC_VECTOR(8 DOWNTO 0);
    signal Operation : STD_LOGIC;
    --Outputs
    signal Result : STD_LOGIC_VECTOR(8 DOWNTO 0);
    signal CarryOUT : STD_LOGIC;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: NineBitAdderSubtractor PORT MAP (
        InputA => InputA,
        InputB => InputB,
        Operation => Operation,
        Result => Result,
        CarryOUT => CarryOUT
    );

    -- Stimulus process
    stim_proc: process
    begin        
        -- Test case 1
        InputA <= "000000001";
        InputB <= "000000001";
        Operation <= '0'; -- Addition
        wait for 10 ns;
        
        -- Test case 2
        InputA <= "000000010";
        InputB <= "000000001";
        Operation <= '1'; -- Subtraction
        wait for 10 ns;
        
        -- Test case 3
        InputA <= "000000100";
        InputB <= "000000010";
        Operation <= '0'; -- Addition
        wait for 10 ns;

        -- Test case 4
        InputA <= "001000100";
        InputB <= "000010110";
        Operation <= '0'; -- Addition
        wait for 10 ns;

        -- Add more test cases as needed

        wait;
    end process;

END;
