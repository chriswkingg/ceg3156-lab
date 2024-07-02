LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MultiplierFinalTestBench IS
END ENTITY MultiplierFinalTestBench;

ARCHITECTURE testbench_arch OF MultiplierFinalTestBench IS
    -- Signals for inputs and outputs
    SIGNAL IN1, IN2     : STD_LOGIC_VECTOR(8 downto 0);
    SIGNAL CLK, async_reset_bar : STD_LOGIC;
    SIGNAL Product : STD_LOGIC_VECTOR(17 DOWNTO 0);

    -- Instantiate the MultiplierFinal entity
    COMPONENT MultiplierFinal
        PORT (
            IN1, IN2 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
            CLK, async_reset_bar : IN STD_LOGIC;
            Product : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
    -- Instantiate the MultiplierFinal component
    UUT: MultiplierFinal PORT MAP (
        IN1 => IN1, IN2 => IN2,
        CLK => CLK, async_reset_bar => async_reset_bar,
        Product => Product
    );

    -- Apply test vectors


    PROCESS
    BEGIN
        -- Initialize inputs
        IN1 <= "000001101";             -- Modify test vectors as needed
        IN2 <= "000000010";
        async_reset_bar  <= '0';
        CLK <= '0';

        WAIT FOR 10 ns;            -- Initialize clock

        -- Reset (active low)
        async_reset_bar <= '1';
        WAIT FOR 10 ns;

        -- Clock toggle
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        -- Add more test vectors and clock toggles as needed

        -- Simulate for a while
        WAIT FOR 100 ns;

        -- End simulation
        WAIT;
    END PROCESS;

END testbench_arch;
