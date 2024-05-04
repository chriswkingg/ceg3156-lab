-- Importing necessary VHDL libraries
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Entity Declaration for the Testbench
ENTITY EightToOne1BitMux_tb IS
END ENTITY EightToOne1BitMux_tb;

-- Architecture Definition for the Testbench
ARCHITECTURE tb OF EightToOne1BitMux_tb IS
    -- Component declaration for the EightToOne1BitMux
    COMPONENT EightToOne1BitMux
        PORT (
            i_mux: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_mux: OUT STD_LOGIC;
            sel0, sel1, sel2: IN STD_LOGIC
        );
    END COMPONENT;

    -- Signals for the testbench
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL stimulus_sel0, stimulus_sel1, stimulus_sel2 : STD_LOGIC;
    SIGNAL stimulus_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL output_result : STD_LOGIC;

BEGIN
    -- Instantiate the EightToOne1BitMux
    UUT: EightToOne1BitMux
        PORT MAP (
            i_mux => stimulus_data,
            o_mux => output_result, -- Output signal added
            sel0 => stimulus_sel0,
            sel1 => stimulus_sel1,
            sel2 => stimulus_sel2
        );

    -- Stimulus process
    stimulus : PROCESS
    BEGIN
        -- Initialize inputs
        stimulus_sel0 <= '0';
        stimulus_sel1 <= '0';
        stimulus_sel2 <= '0';
        stimulus_data <= (others => '0');

        -- Apply some input combinations
        wait for 10 ns;
        stimulus_sel0 <= '0';
        stimulus_sel1 <= '0';
        stimulus_sel2 <= '0';
        stimulus_data <= "10101010";
        
        wait for 10 ns;
        stimulus_sel0 <= '1';
        stimulus_sel1 <= '0';
        stimulus_sel2 <= '0';

        wait for 10 ns;
        stimulus_sel0 <= '0';
        stimulus_sel1 <= '1';
        stimulus_sel2 <= '0';

        wait for 10 ns;
        stimulus_sel0 <= '1';
        stimulus_sel1 <= '1';
        stimulus_sel2 <= '0';

        wait for 10 ns;
        stimulus_sel0 <= '0';
        stimulus_sel1 <= '0';
        stimulus_sel2 <= '1';

        wait for 10 ns;
        stimulus_sel0 <= '1';
        stimulus_sel1 <= '0';
        stimulus_sel2 <= '1';

        wait for 10 ns;
        stimulus_sel0 <= '0';
        stimulus_sel1 <= '1';
        stimulus_sel2 <= '1';

        wait for 10 ns;
        stimulus_sel0 <= '1';
        stimulus_sel1 <= '1';
        stimulus_sel2 <= '1';

        wait;
    END PROCESS stimulus;

END tb;
