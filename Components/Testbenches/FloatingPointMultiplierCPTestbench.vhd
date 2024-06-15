LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FloatingMultiplierCPTestbench IS
END FloatingMultiplierCPTestbench;

ARCHITECTURE testbench OF FloatingMultiplierCPTestbench IS
    -- Component declaration for the unit under test
    COMPONENT MultiplierControlUnit
        PORT (
            i_clock, i_reset : IN STD_LOGIC;
            i_INCPM, i_EXPVLD : IN STD_LOGIC;
            o_LDPE, o_LDAM, o_LDBM, o_overflow, o_SHFTPM, o_INCPE, o_LDPM : OUT STD_LOGIC
        );
    END COMPONENT;
    
    -- Testbench signals
    SIGNAL clock : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL INCPM : STD_LOGIC := '0';
    SIGNAL EXPVLD : STD_LOGIC := '0';
    SIGNAL LDPE, LDAM, LDBM, overflow, SHFTPM, INCPE, LDPM : STD_LOGIC;

BEGIN
    -- Instantiate the unit under test
    uut : MultiplierControlUnit
    PORT MAP (
        i_clock => clock,
        i_reset => reset,
        i_INCPM => INCPM,
        i_EXPVLD => EXPVLD,
        o_LDPE => LDPE,
        o_LDAM => LDAM,
        o_LDBM => LDBM,
        o_overflow => overflow,
        o_SHFTPM => SHFTPM,
        o_INCPE => INCPE,
        o_LDPM => LDPM
    );
    
    -- Clock process
    clock_process: PROCESS
    BEGIN
        while now < 100 ns loop
            clock <= not clock;
            wait for 5 ns;
        end loop;
        wait;
    END PROCESS;

    -- Stimulus process
    stimulus: PROCESS
    BEGIN
        -- Reset initialization
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;
        
        -- Example input sequence
        INCPM <= '0';
        EXPVLD <= '1';
        wait for 10 ns;
        INCPM <= '1';
        EXPVLD <= '0';
        wait for 10 ns;
        INCPM <= '1';
        EXPVLD <= '1';
        wait for 10 ns;
        
        -- Add more test cases as needed
        
        wait;
    END PROCESS;
    
END testbench;
