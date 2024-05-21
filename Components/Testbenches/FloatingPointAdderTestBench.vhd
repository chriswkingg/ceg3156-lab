LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FloatingPointAdderTestbench IS
END ENTITY FloatingPointAdderTestbench;

ARCHITECTURE tb OF FloatingPointAdderTestbench IS

    -- Component declaration for the unit under test (UUT)
    COMPONENT FloatingPointAdder
        PORT (
            i_clock, i_reset : IN STD_LOGIC;
            i_signA, i_signB : IN STD_LOGIC;
            i_mantissaA, i_mantissaB : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            i_exponentA, i_exponentB : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
            o_sign, o_overflow : OUT STD_LOGIC;
            o_mantissa : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_exponent : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
    END COMPONENT;

    -- Signals to connect to UUT
    SIGNAL i_clock, i_reset : STD_LOGIC := '0';
    SIGNAL i_signA, i_signB : STD_LOGIC := '0';
    SIGNAL i_mantissaA, i_mantissaB : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
    SIGNAL i_exponentA, i_exponentB : STD_LOGIC_VECTOR(6 DOWNTO 0) := (others => '0');
    SIGNAL o_sign, o_overflow : STD_LOGIC;
    SIGNAL o_mantissa : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL o_exponent : STD_LOGIC_VECTOR(6 DOWNTO 0);

    -- Clock period definition
    CONSTANT clock_period : time := 5 ns;
    signal clock_counter : natural := 0;

BEGIN

    -- Instantiate the UUT
    uut: FloatingPointAdder PORT MAP (
        i_clock => i_clock,
        i_reset => i_reset,
        i_signA => i_signA,
        i_signB => i_signB,
        i_mantissaA => i_mantissaA,
        i_mantissaB => i_mantissaB,
        i_exponentA => i_exponentA,
        i_exponentB => i_exponentB,
        o_sign => o_sign,
        o_overflow => o_overflow,
        o_mantissa => o_mantissa,
        o_exponent => o_exponent
    );

    -- Clock process
    CLOCK_PROCESS : PROCESS
    BEGIN
        while (clock_counter < 50) loop
            i_clock <= '0';
            wait for clock_period / 2;
            i_clock <= '1';
            wait for clock_period / 2;
            clock_counter <= clock_counter + 1;
        end loop;
        wait;
    END PROCESS;

    -- Stimulus process
    stimulus_process : PROCESS
    BEGIN
        -- Hold reset state for a few clock cycles
        i_reset <= '0';
        i_reset <= '1';
        WAIT FOR 2 * clock_period;
        

        -- Test Case 1: Add two numbers
        i_signA <= '0';
        i_signB <= '0';
        i_mantissaA <= "00011001"; -- Example mantissa A
        i_mantissaB <= "00010101"; -- Example mantissa B
        i_exponentA <= "0000011"; -- Example exponent A
        i_exponentB <= "0000010"; -- Example exponent B
        WAIT FOR 10 * clock_period;

        -- Test Case 2: Add two different numbers
        i_signA <= '1';
        i_signB <= '0';
        i_mantissaA <= "00110011"; -- Example mantissa A
        i_mantissaB <= "00001111"; -- Example mantissa B
        i_exponentA <= "0000100"; -- Example exponent A
        i_exponentB <= "0000011"; -- Example exponent B
        WAIT FOR 10 * clock_period;

        -- Additional test cases can be added here

        -- End of tests
        WAIT;
    END PROCESS;

END ARCHITECTURE tb;
