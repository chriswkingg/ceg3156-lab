LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY MultiplierCP_Testbench IS
END ENTITY MultiplierCP_Testbench;

ARCHITECTURE testbench_arch OF MultiplierCP_Testbench IS
    -- Signals for inputs and outputs
    SIGNAL B0IS1, RESET, CLK : STD_LOGIC;
    SIGNAL LSHFTA, RSHFTB, LDA, LDB, INCI, CLRI, LDP, CLRP, DS0, DS1, DS2, DS3, ILT3 : STD_LOGIC;

    -- Instantiate the MultiplierCP entity
    COMPONENT MultiplierCP
        PORT (
            B0IS1, RESET, CLK, ILT3 : IN STD_LOGIC;
            LSHFTA, RSHFTB, LDA, LDB, INCI, CLRI, LDP, CLRP, DS0, DS1, DS2, DS3 : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN
    -- Instantiate the MultiplierCP component
    UUT: MultiplierCP PORT MAP (
        B0IS1 => B0IS1,
        RESET => RESET,
        CLK => CLK,
        LSHFTA => LSHFTA,
        RSHFTB => RSHFTB,
        LDA => LDA,
        LDB => LDB,
        INCI => INCI,
        CLRI => CLRI,
        LDP => LDP,
        CLRP => CLRP,
        DS0 => DS0, 
        DS1 => DS1, 
        DS2 => DS2,
        DS3 => DS3,
        ILT3 => ILT3

    );

    -- Apply test vectors
    PROCESS
    BEGIN
        -- Initialize inputs
        B0IS1 <= '0';
        RESET <= '1';   -- Reset is active low
        ILT3 <= '1';
        CLK <= '0';

        WAIT FOR 10 ns;            -- Initialize clock

        -- Reset (active low)
        RESET <= '0';
        WAIT FOR 10 ns;

        -- Disable Reset 
        RESET <= '1';
        WAIT FOR 10 ns;
        
        -- Clock toggle
        CLK <= not CLK;
        WAIT FOR 10 ns;

        -- Set B0IS1 to '1' or '0' as needed
        B0IS1 <= '1';
        -- Add more test vectors and clock toggles as needed
        -- Clock toggle
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        B0IS1 <= '0';
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        ILT3 <= '0';
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        -- Simulate for a while
        WAIT FOR 100 ns;

        -- End simulation`
        WAIT;
    END PROCESS;

END testbench_arch;
