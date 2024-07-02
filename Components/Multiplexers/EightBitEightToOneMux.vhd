LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EightBitEightToOneMux IS
    PORT (
        i_mux_0, i_mux_1, i_mux_2, i_mux_3, i_mux_4, i_mux_5, i_mux_6, i_mux_7: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_mux: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        sel0, sel1, sel2: IN STD_LOGIC
    );
END ENTITY EightBitEightToOneMux;

ARCHITECTURE rtl OF EightBitEightToOneMux IS
    COMPONENT EightToOneMux
        PORT (
            i_mux: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_mux: OUT STD_LOGIC;
            sel0, sel1, sel2: IN STD_LOGIC
        );
    END COMPONENT;

    SIGNAL int_mux: STD_LOGIC_VECTOR(7 DOWNTO 0);
	 SIGNAL int_b0: STD_LOGIC_VECTOR(7 DOWNTO 0);
	 SIGNAL int_b1: STD_LOGIC_VECTOR(7 DOWNTO 0);
	 SIGNAL int_b2: STD_LOGIC_VECTOR(7 DOWNTO 0);
	 SIGNAL int_b3: STD_LOGIC_VECTOR(7 DOWNTO 0);
	 SIGNAL int_b4: STD_LOGIC_VECTOR(7 DOWNTO 0);
	 SIGNAL int_b5: STD_LOGIC_VECTOR(7 DOWNTO 0);
	 SIGNAL int_b6: STD_LOGIC_VECTOR(7 DOWNTO 0);
	 SIGNAL int_b7: STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
    -- First bit mux
	 int_b0(0) <= i_mux_0(0);
	 int_b0(1) <= i_mux_1(0);
	 int_b0(2) <= i_mux_2(0);
	 int_b0(3) <= i_mux_3(0);
	 int_b0(4) <= i_mux_4(0);
	 int_b0(5) <= i_mux_5(0);
	 int_b0(6) <= i_mux_6(0);
	 int_b0(7) <= i_mux_7(0);
    MUX0: EightToOneMux PORT MAP (int_b0, int_mux(0), sel0, sel1, sel2);
	 
	 -- Second bit mux
	 int_b1(0) <= i_mux_0(1);
	 int_b1(1) <= i_mux_1(1);
	 int_b1(2) <= i_mux_2(1);
	 int_b1(3) <= i_mux_3(1);
	 int_b1(4) <= i_mux_4(1);
	 int_b1(5) <= i_mux_5(1);
	 int_b1(6) <= i_mux_6(1);
	 int_b1(7) <= i_mux_7(1);
    MUX1: EightToOneMux PORT MAP (int_b1, int_mux(1), sel0, sel1, sel2);
	 
	 -- Third bit mux
	 int_b2(0) <= i_mux_0(2);
	 int_b2(1) <= i_mux_1(2);
	 int_b2(2) <= i_mux_2(2);
	 int_b2(3) <= i_mux_3(2);
	 int_b2(4) <= i_mux_4(2);
	 int_b2(5) <= i_mux_5(2);
	 int_b2(6) <= i_mux_6(2);
	 int_b2(7) <= i_mux_7(2);
    MUX2: EightToOneMux PORT MAP (int_b2, int_mux(2), sel0, sel1, sel2);
	 
	 -- Fourth bit mux
	 int_b3(0) <= i_mux_0(3);
	 int_b3(1) <= i_mux_1(3);
	 int_b3(2) <= i_mux_2(3);
	 int_b3(3) <= i_mux_3(3);
	 int_b3(4) <= i_mux_4(3);
	 int_b3(5) <= i_mux_5(3);
	 int_b3(6) <= i_mux_6(3);
	 int_b3(7) <= i_mux_7(3);
    MUX3: EightToOneMux PORT MAP (int_b3, int_mux(3), sel0, sel1, sel2);

	-- Fifth bit mux
	 int_b4(0) <= i_mux_0(4);
	 int_b4(1) <= i_mux_1(4);
	 int_b4(2) <= i_mux_2(4);
	 int_b4(3) <= i_mux_3(4);
	 int_b4(4) <= i_mux_4(4);
	 int_b4(5) <= i_mux_5(4);
	 int_b4(6) <= i_mux_6(4);
	 int_b4(7) <= i_mux_7(4);
    MUX4: EightToOneMux PORT MAP (int_b4, int_mux(4), sel0, sel1, sel2);
    
    -- Sixth bit mux
	 int_b5(0) <= i_mux_0(5);
	 int_b5(1) <= i_mux_1(5);
	 int_b5(2) <= i_mux_2(5);
	 int_b5(3) <= i_mux_3(5);
	 int_b5(4) <= i_mux_4(5);
	 int_b5(5) <= i_mux_5(5);
	 int_b5(6) <= i_mux_6(5);
	 int_b5(7) <= i_mux_7(5);
    MUX5: EightToOneMux PORT MAP (int_b5, int_mux(5), sel0, sel1, sel2);

	-- Seventh bit mux
	 int_b6(0) <= i_mux_0(6);
	 int_b6(1) <= i_mux_1(6);
	 int_b6(2) <= i_mux_2(6);
	 int_b6(3) <= i_mux_3(6);
	 int_b6(4) <= i_mux_4(6);
	 int_b6(5) <= i_mux_5(6);
	 int_b6(6) <= i_mux_6(6);
	 int_b6(7) <= i_mux_7(6);
    MUX6: EightToOneMux PORT MAP (int_b6, int_mux(6), sel0, sel1, sel2);

	-- Eighth bit mux
	 int_b7(0) <= i_mux_0(7);
	 int_b7(1) <= i_mux_1(7);
	 int_b7(2) <= i_mux_2(7);
	 int_b7(3) <= i_mux_3(7);
	 int_b7(4) <= i_mux_4(7);
	 int_b7(5) <= i_mux_5(7);
	 int_b7(6) <= i_mux_6(7);
	 int_b7(7) <= i_mux_7(7);
    MUX7: EightToOneMux PORT MAP (int_b7, int_mux(7), sel0, sel1, sel2);

    -- Output assignment
    o_mux <= int_mux;

END rtl; 