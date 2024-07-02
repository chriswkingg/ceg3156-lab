LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY MultiplierDP_Testbench IS
END ENTITY;

ARCHITECTURE testbench_architecture OF MultiplierDP_Testbench IS
    -- Signals for your test bench
    SIGNAL IN1, IN2         : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL LSHFTA, RSHFTB, LDA, LDB, INCI, CLRI, LDP, CLRP, RESET, CLK    : STD_LOGIC;
    SIGNAL ILT3, B0IS1     : STD_LOGIC;
    SIGNAL Product         : STD_LOGIC_VECTOR(7 DOWNTO 0);
    
    -- Instantiate the MultiplierDP component
    COMPONENT MultiplierDP
        PORT 
        (
            IN1, IN2    :   IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            LSHFTA, RSHFTB, LDA, LDB, INCI, CLRI, LDP, CLRP, RESET, CLK    : IN STD_LOGIC;
            ILT3, B0IS1 :   OUT STD_LOGIC;
            Product     :   OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
    -- Instantiate the MultiplierDP component
    UUT : MultiplierDP
        PORT MAP
        (
            IN1 => IN1,
            IN2 => IN2,
            LSHFTA => LSHFTA,
            RSHFTB => RSHFTB,
            LDA => LDA,
            LDB => LDB,
            INCI => INCI,
            CLRI => CLRI,
            LDP => LDP,
            CLRP => CLRP,
            RESET => RESET,
            CLK => CLK,
            ILT3 => ILT3,
            B0IS1 => B0IS1,
            Product => Product
        );
    
    -- Stimulus generation
    PROCESS
    BEGIN
        -- Provide test inputs
        IN1 <= "0011";  -- Modify values as needed
        IN2 <= "0101";  -- Modify values as needed
        LSHFTA <= '1';
        RSHFTB <= '1';
        LDA <= '1';
        LDB <= '1';
        INCI <= '1';
        CLRI <= '1';
        LDP <= '1';
        CLRP <= '1';
        RESET <= '0';
        CLK <= '0';
        
        -- Wait for a few clock cycles
        WAIT FOR 10 ns;
        RESET <= '1';
        LSHFTA <= '0';
        RSHFTB <= '0';
        LDA <= '0';
        LDB <= '0';
        INCI <= '1';
        CLRI <= '0';
        LDP <= '0';
        CLRP <= '0';


        
        -- Provide additional test inputs or scenarios if needed
        WAIT FOR 10 ns;
        LDA <= '1';
        LDB <= '1';
        

        
        WAIT FOR 10 ns;
        CLK <= not CLK;
        WAIT FOR 10 ns;
        CLK <= not CLK;
        LDA <= '0';
        LDB <= '0';
        LDP <= '1';
        LSHFTA <= '1';
        RSHFTB <= '1';
        
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
        




        -- Finish the simulation
        WAIT;
    END PROCESS;
    
    -- Add waveform simulation configuration here if necessary
    -- e.g., for viewing signals in a simulator
    
END testbench_architecture;
