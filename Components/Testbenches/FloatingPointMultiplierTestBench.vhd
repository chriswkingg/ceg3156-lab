LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY FloatingMultiplierTestbench IS
END FloatingMultiplierTestbench;

ARCHITECTURE behavior OF FloatingMultiplierTestbench IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT FloatingMultiplier
    PORT(
        i_clock       : IN  STD_LOGIC;
        i_reset       : IN  STD_LOGIC;
        i_signA       : IN  STD_LOGIC;
        i_signB       : IN  STD_LOGIC;
        i_mantissaA   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        i_mantissaB   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        i_exponentA   : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
        i_exponentB   : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
        o_sign        : OUT STD_LOGIC;
        o_overflow    : OUT STD_LOGIC;
        o_mantissa    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_exponent    : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
    END COMPONENT;
    
    -- Testbench signals
    SIGNAL tb_clock       : STD_LOGIC := '0';
    SIGNAL tb_reset       : STD_LOGIC := '0';
    SIGNAL tb_signA       : STD_LOGIC := '0';
    SIGNAL tb_signB       : STD_LOGIC := '0';
    SIGNAL tb_mantissaA   : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tb_mantissaB   : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tb_exponentA   : STD_LOGIC_VECTOR(6 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tb_exponentB   : STD_LOGIC_VECTOR(6 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tb_o_sign      : STD_LOGIC;
    SIGNAL tb_o_overflow  : STD_LOGIC;
    SIGNAL tb_o_mantissa  : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL tb_o_exponent  : STD_LOGIC_VECTOR(6 DOWNTO 0);
    
    -- Clock period definition
    CONSTANT clock_period : time := 5 ns;
    signal clock_counter : natural := 0;
    
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: FloatingMultiplier PORT MAP (
          i_clock => tb_clock,
          i_reset => tb_reset,
          i_signA => tb_signA,
          i_signB => tb_signB,
          i_mantissaA => tb_mantissaA,
          i_mantissaB => tb_mantissaB,
          i_exponentA => tb_exponentA,
          i_exponentB => tb_exponentB,
          o_sign => tb_o_sign,
          o_overflow => tb_o_overflow,
          o_mantissa => tb_o_mantissa,
          o_exponent => tb_o_exponent
        );

    -- Clock process definitions
    CLOCK_PROCESS : PROCESS
    BEGIN
        while (clock_counter < 50) loop
            tb_clock <= '0';
            wait for clock_period / 2;
            tb_clock <= '1';
            wait for clock_period / 2;
            clock_counter <= clock_counter + 1;
        end loop;
        wait;
    END PROCESS;

    -- Stimulus process
    stim_proc: process
    begin		
        -- Reset the system
        tb_reset <= '0';
        wait for 20 ns;
        tb_reset <= '1';

        -- Apply stimulus
        tb_signA <= '0';
        tb_signB <= '0';
        tb_mantissaA <= "00011011";  -- Example mantissa value
        tb_mantissaB <= "00010101";  -- Example mantissa value
        tb_exponentA <= "0111100";   -- Example exponent value
        tb_exponentB <= "0111001";   -- Example exponent value
        wait for 100 ns;
        

        -- End simulation
        wait;
    end process;

END;
