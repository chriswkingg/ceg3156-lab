LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY NineBitGPRegisterTestBench IS
END NineBitGPRegisterTestBench;

ARCHITECTURE behavior OF NineBitGPRegisterTestBench IS

    -- Component declaration for the unit under test (UUT)
    COMPONENT NineBitGPRegister
        PORT 
        (
            -- Register Operations
            i_resetBar : IN STD_LOGIC;
            i_load, i_shiftLeft, i_shiftRight : IN STD_LOGIC;
            i_decrement, i_increment : IN STD_LOGIC;

            -- Register Signals
            i_serial_in_left, i_serial_in_right : IN STD_LOGIC;
            i_clock : IN STD_LOGIC;
            i_Value : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
            o_Value : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
        );
    END COMPONENT;

    -- Constants
    CONSTANT CLOCK_PERIOD : TIME := 10 ns;
    signal clock_counter : natural := 0;

    -- Signals for the inputs
    SIGNAL i_resetBar, i_load, i_shiftLeft, i_shiftRight, i_decrement, i_increment, i_serial_in_left, i_serial_in_right, i_clock : STD_LOGIC;
    SIGNAL i_Value, o_Value : STD_LOGIC_VECTOR(8 DOWNTO 0);

BEGIN

    -- Instantiate the unit under test (UUT)
    uut: NineBitGPRegister 
    PORT MAP (
        i_resetBar => i_resetBar,
        i_load => i_load,
        i_shiftLeft => i_shiftLeft,
        i_shiftRight => i_shiftRight,
        i_decrement => i_decrement,
        i_increment => i_increment,
        i_serial_in_left => i_serial_in_left,
        i_serial_in_right => i_serial_in_right,
        i_clock => i_clock,
        i_Value => i_Value,
        o_Value => o_Value
    );

    -- Clock process definitions
    CLOCK_PROCESS : PROCESS
    BEGIN
        while (clock_counter < 50) loop
            i_clock <= '0';
            wait for CLOCK_PERIOD / 2;
            i_clock <= '1';
            wait for CLOCK_PERIOD / 2;
            clock_counter <= clock_counter + 1;
        end loop;
        wait;
    END PROCESS;

    -- Stimulus process
    STIMULUS_PROCESS : PROCESS
    BEGIN
        -- Add your test stimuli here
        i_load <= '0';
        i_shiftLeft <= '0';
        i_shiftRight <= '0';
        i_decrement <= '0';
        i_increment <= '0';
        i_serial_in_left <= '0';
        i_serial_in_right <= '0';
        
        -- Example: 
        i_resetBar <= '0';  -- Release reset
        wait for CLOCK_PERIOD * 10; -- Wait for some cycles
        i_resetBar <= '1';
        
        -- Example: Load some value
        i_load <= '1';
        i_Value <= "101010101"; -- Some value to load
        wait for CLOCK_PERIOD * 5; -- Wait for some cycles
        
        -- Example: Perform shift left operation
        i_load <= '0';
        i_shiftLeft <= '1';
        wait for CLOCK_PERIOD * 5; -- Wait for some cycles

        -- Example: Perform shift rigth operation
        i_shiftLeft <= '0';
        i_shiftRight <= '1';
        wait for CLOCK_PERIOD * 5; -- Wait for some cycles

        -- Example: Increment operation
        i_shiftRight <= '0';
        i_increment <= '1';
        wait for CLOCK_PERIOD * 5; -- Wait for some cycles
        
        -- Example: Decrement operation
        i_increment <= '0';
        i_decrement <= '1';
        wait for CLOCK_PERIOD * 5; -- Wait for some 
        i_decrement <= '0';
        

        wait;
        -- Add more test scenarios as needed
    END PROCESS;

END behavior;
