LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY dflipflopTestBench IS
END ENTITY dflipflopTestBench;

ARCHITECTURE behavior OF dflipflopTestBench IS

    -- Component declaration for the unit under test (UUT)
    COMPONENT dflipflop
        PORT(
            i_d : IN STD_LOGIC;
            i_clock : IN STD_LOGIC;
            i_enable : IN STD_LOGIC;
            i_async_reset : IN STD_LOGIC;
            i_async_set : IN STD_LOGIC;
            o_q : OUT STD_LOGIC;
            o_qBar : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Signals to connect to UUT
    SIGNAL i_d : STD_LOGIC := '0';
    SIGNAL i_clock : STD_LOGIC := '0';
    SIGNAL i_enable : STD_LOGIC := '0';
    SIGNAL i_async_reset : STD_LOGIC := '0';
    SIGNAL i_async_set : STD_LOGIC := '0';
    SIGNAL o_q : STD_LOGIC;
    SIGNAL o_qBar : STD_LOGIC;

    -- Clock period definition
    CONSTANT clock_period : time := 10 ns;
    signal clock_counter : natural := 0;

BEGIN

    -- Instantiate the UUT
    uut: dflipflop PORT MAP (
        i_d => i_d,
        i_clock => i_clock,
        i_enable => i_enable,
        i_async_reset => i_async_reset,
        i_async_set => i_async_set,
        o_q => o_q,
        o_qBar => o_qBar
    );

    -- Clock process
    clock_process : PROCESS
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
        -- Initialize inputs
        i_d <= '0';
        i_enable <= '0';
        i_async_reset <= '0';
        i_async_set <= '0';
        WAIT FOR 20 ns;
        
        -- Apply asynchronous reset
        i_async_reset <= '1';
        WAIT FOR 20 ns;
        i_async_reset <= '0';
        WAIT FOR 20 ns;
        
        -- Apply asynchronous set
        i_async_set <= '1';
        WAIT FOR 20 ns;
        i_async_set <= '0';
        WAIT FOR 20 ns;

        -- Normal operation with enable
        i_enable <= '1';
        
        -- Test Case 1: D = 1
        i_d <= '1';
        WAIT FOR 20 ns;

        -- Test Case 2: D = 0
        i_d <= '0';
        WAIT FOR 20 ns;

        -- Test Case 3: Disable latch
        i_enable <= '0';
        i_d <= '1';
        WAIT FOR 20 ns;
        
        -- Further tests can be added here
        
        -- End of tests
        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;
