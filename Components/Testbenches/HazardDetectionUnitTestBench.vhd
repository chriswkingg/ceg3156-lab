LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY HazardDetectionUnitTestBench IS
END HazardDetectionUnitTestBench;

ARCHITECTURE behavior OF HazardDetectionUnitTestBench IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT HazardDetectionUnit IS
        PORT
        (
            ID_EX_MemRead        : IN STD_LOGIC;
            ID_EX_RegisterRt     : IN STD_LOGIC_VECTOR(2 downto 0);
            IF_ID_RegisterRs     : IN STD_LOGIC_VECTOR(2 downto 0);
            IF_ID_RegisterRt     : IN STD_LOGIC_VECTOR(2 downto 0);
            Hazard_Detected      : OUT STD_LOGIC
        );
    END COMPONENT;
    
    -- Signals for the test bench
    SIGNAL ID_EX_MemRead        : STD_LOGIC := '0';
    SIGNAL ID_EX_RegisterRt     : STD_LOGIC_VECTOR(2 downto 0) := "000";
    SIGNAL IF_ID_RegisterRs     : STD_LOGIC_VECTOR(2 downto 0) := "000";
    SIGNAL IF_ID_RegisterRt     : STD_LOGIC_VECTOR(2 downto 0) := "000";
    SIGNAL Hazard_Detected      : STD_LOGIC;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: HazardDetectionUnit 
    PORT MAP (
          ID_EX_MemRead => ID_EX_MemRead,
          ID_EX_RegisterRt => ID_EX_RegisterRt,
          IF_ID_RegisterRs => IF_ID_RegisterRs,
          IF_ID_RegisterRt => IF_ID_RegisterRt,
          Hazard_Detected => Hazard_Detected
        );

    -- Stimulus process
    stim_proc: process
    begin		
        -- Test case 1: No hazard
        ID_EX_MemRead <= '0';
        ID_EX_RegisterRt <= "000";
        IF_ID_RegisterRs <= "000";
        IF_ID_RegisterRt <= "000";
        wait for 10 ns;
        
        -- Test case 2: Hazard on Rs
        ID_EX_MemRead <= '1';
        ID_EX_RegisterRt <= "001";
        IF_ID_RegisterRs <= "001";
        IF_ID_RegisterRt <= "010";
        wait for 10 ns;
        
        -- Test case 3: Hazard on Rt
        ID_EX_MemRead <= '1';
        ID_EX_RegisterRt <= "010";
        IF_ID_RegisterRs <= "001";
        IF_ID_RegisterRt <= "010";
        wait for 10 ns;
        
        -- Test case 4: No hazard with MemRead
        ID_EX_MemRead <= '1';
        ID_EX_RegisterRt <= "011";
        IF_ID_RegisterRs <= "100";
        IF_ID_RegisterRt <= "101";
        wait for 10 ns;

        -- Test case 5: Hazard on both Rs and Rt
        ID_EX_MemRead <= '1';
        ID_EX_RegisterRt <= "111";
        IF_ID_RegisterRs <= "111";
        IF_ID_RegisterRt <= "111";
        wait for 10 ns;
        
        -- Test case 6: No hazard with MemRead and different registers
        ID_EX_MemRead <= '1';
        ID_EX_RegisterRt <= "010";
        IF_ID_RegisterRs <= "100";
        IF_ID_RegisterRt <= "110";
        wait for 10 ns;

        -- End simulation
        wait;
    end process;

END;
