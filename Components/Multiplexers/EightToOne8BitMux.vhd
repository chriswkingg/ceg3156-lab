-- Importing necessary VHDL libraries
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Entity Declaration: Defines the inputs and outputs of the multiplexer
ENTITY EightToOne8BitMux IS
    PORT (
        i_mux_0, i_mux_1, i_mux_2, i_mux_3 : IN STD_LOGIC_VECTOR(7 downto 0);
        i_mux_4, i_mux_5, i_mux_6, i_mux_7 : IN STD_LOGIC_VECTOR(7 downto 0);
        o_mux: OUT STD_LOGIC_VECTOR(7 downto 0);
        sel0, sel1, sel2: IN STD_LOGIC
    );
END ENTITY EightToOne8BitMux;

-- Architecture Definition for the multiplexer
ARCHITECTURE rtl OF EightToOne8BitMux IS
    -- Signal declaration for the internal multiplexer output
    SIGNAL out_mux : STD_LOGIC_VECTOR(7 downto 0);

BEGIN
    -- Multiplexer logic for the output

    out_mux(0) <= ((not sel0) and (not sel1) and (not sel2) and i_mux_0(0)) or 
                ((sel0) and (not sel1) and (not sel2) and i_mux_1(0)) or 
                ((not sel0) and (sel1) and (not sel2) and i_mux_2(0)) or 
                ((sel0) and (sel1) and (not sel2) and i_mux_3(0)) or 
                ((not sel0) and (not sel1) and (sel2) and i_mux_4(0)) or 
                ((sel0) and (not sel1) and (sel2) and i_mux_5(0)) or 
                ((not sel0) and (sel1) and (sel2) and i_mux_6(0)) or 
                ((sel0) and (sel1) and (sel2) and i_mux_7(0));

    out_mux(1) <= ((not sel0) and (not sel1) and (not sel2) and i_mux_0(1)) or 
                ((sel0) and (not sel1) and (not sel2) and i_mux_1(1)) or 
                ((not sel0) and (sel1) and (not sel2) and i_mux_2(1)) or 
                ((sel0) and (sel1) and (not sel2) and i_mux_3(1)) or 
                ((not sel0) and (not sel1) and (sel2) and i_mux_4(1)) or 
                ((sel0) and (not sel1) and (sel2) and i_mux_5(1)) or 
                ((not sel0) and (sel1) and (sel2) and i_mux_6(1)) or 
                ((sel0) and (sel1) and (sel2) and i_mux_7(1));

    out_mux(2) <= ((not sel0) and (not sel1) and (not sel2) and i_mux_0(2)) or 
                ((sel0) and (not sel1) and (not sel2) and i_mux_1(2)) or 
                ((not sel0) and (sel1) and (not sel2) and i_mux_2(2)) or 
                ((sel0) and (sel1) and (not sel2) and i_mux_3(2)) or 
                ((not sel0) and (not sel1) and (sel2) and i_mux_4(2)) or 
                ((sel0) and (not sel1) and (sel2) and i_mux_5(2)) or 
                ((not sel0) and (sel1) and (sel2) and i_mux_6(2)) or 
                ((sel0) and (sel1) and (sel2) and i_mux_7(2));
                
    out_mux(3) <= ((not sel0) and (not sel1) and (not sel2) and i_mux_0(3)) or 
                ((sel0) and (not sel1) and (not sel2) and i_mux_1(3)) or 
                ((not sel0) and (sel1) and (not sel2) and i_mux_2(3)) or 
                ((sel0) and (sel1) and (not sel2) and i_mux_3(3)) or 
                ((not sel0) and (not sel1) and (sel2) and i_mux_4(3)) or 
                ((sel0) and (not sel1) and (sel2) and i_mux_5(3)) or 
                ((not sel0) and (sel1) and (sel2) and i_mux_6(3)) or 
                ((sel0) and (sel1) and (sel2) and i_mux_7(3));

    out_mux(4) <= ((not sel0) and (not sel1) and (not sel2) and i_mux_0(4)) or 
                ((sel0) and (not sel1) and (not sel2) and i_mux_1(4)) or 
                ((not sel0) and (sel1) and (not sel2) and i_mux_2(4)) or 
                ((sel0) and (sel1) and (not sel2) and i_mux_3(4)) or 
                ((not sel0) and (not sel1) and (sel2) and i_mux_4(4)) or 
                ((sel0) and (not sel1) and (sel2) and i_mux_5(4)) or 
                ((not sel0) and (sel1) and (sel2) and i_mux_6(4)) or 
                ((sel0) and (sel1) and (sel2) and i_mux_7(4));

    out_mux(5) <= ((not sel0) and (not sel1) and (not sel2) and i_mux_0(5)) or 
                ((sel0) and (not sel1) and (not sel2) and i_mux_1(5)) or 
                ((not sel0) and (sel1) and (not sel2) and i_mux_2(5)) or 
                ((sel0) and (sel1) and (not sel2) and i_mux_3(5)) or 
                ((not sel0) and (not sel1) and (sel2) and i_mux_4(5)) or 
                ((sel0) and (not sel1) and (sel2) and i_mux_5(5)) or 
                ((not sel0) and (sel1) and (sel2) and i_mux_6(5)) or 
                ((sel0) and (sel1) and (sel2) and i_mux_7(5));

    out_mux(6) <= ((not sel0) and (not sel1) and (not sel2) and i_mux_0(6)) or 
                ((sel0) and (not sel1) and (not sel2) and i_mux_1(6)) or 
                ((not sel0) and (sel1) and (not sel2) and i_mux_2(6)) or 
                ((sel0) and (sel1) and (not sel2) and i_mux_3(6)) or 
                ((not sel0) and (not sel1) and (sel2) and i_mux_4(6)) or 
                ((sel0) and (not sel1) and (sel2) and i_mux_5(6)) or 
                ((not sel0) and (sel1) and (sel2) and i_mux_6(6)) or 
                ((sel0) and (sel1) and (sel2) and i_mux_7(6));

    out_mux(7) <= ((not sel0) and (not sel1) and (not sel2) and i_mux_0(7)) or 
                ((sel0) and (not sel1) and (not sel2) and i_mux_1(7)) or 
                ((not sel0) and (sel1) and (not sel2) and i_mux_2(7)) or 
                ((sel0) and (sel1) and (not sel2) and i_mux_3(7)) or 
                ((not sel0) and (not sel1) and (sel2) and i_mux_4(7)) or 
                ((sel0) and (not sel1) and (sel2) and i_mux_5(7)) or 
                ((not sel0) and (sel1) and (sel2) and i_mux_6(7)) or 
                ((sel0) and (sel1) and (sel2) and i_mux_7(7));


    o_mux <= out_mux;	

END rtl;
