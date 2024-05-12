LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FourToOne8BitMux IS
    PORT (
        i_muxIn0, i_muxIn1, i_muxIn2, i_muxIn3: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_mux: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        sel0, sel1: IN STD_LOGIC
    );
END ENTITY FourToOne8BitMux;

ARCHITECTURE rtl OF FourToOne8BitMux IS
			SIGNAL out_mux : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
		out_mux(7) <= ((not sel0) and (not sel1) and (i_muxIn0(7))) or 
						 ((sel0) and (not sel1) and (i_muxIn1(7))) or 
						 ((not sel0) and (sel1) and (i_muxIn2(7))) or 
						 ((sel0) and (sel1) and (i_muxIn3(7)));
						 
		out_mux(6) <= ((not sel0) and (not sel1) and (i_muxIn0(6))) or 
						 ((sel0) and (not sel1) and (i_muxIn1(6))) or 
						 ((not sel0) and (sel1) and (i_muxIn2(6))) or 
						 ((sel0) and (sel1) and (i_muxIn3(6)));
						 
		out_mux(5) <= ((not sel0) and (not sel1) and (i_muxIn0(5))) or 
						 ((sel0) and (not sel1) and (i_muxIn1(5))) or 
						 ((not sel0) and (sel1) and (i_muxIn2(5))) or 
						 ((sel0) and (sel1) and (i_muxIn3(5)));
						 
		out_mux(4) <= ((not sel0) and (not sel1) and (i_muxIn0(4))) or 
						 ((sel0) and (not sel1) and (i_muxIn1(4))) or 
						 ((not sel0) and (sel1) and (i_muxIn2(4))) or 
						 ((sel0) and (sel1) and (i_muxIn3(4)));
						 
		out_mux(3) <= ((not sel0) and (not sel1) and (i_muxIn0(3))) or 
						 ((sel0) and (not sel1) and (i_muxIn1(3))) or 
						 ((not sel0) and (sel1) and (i_muxIn2(3))) or 
						 ((sel0) and (sel1) and (i_muxIn3(3)));
						 
		out_mux(2) <= ((not sel0) and (not sel1) and (i_muxIn0(2))) or 
						 ((sel0) and (not sel1) and (i_muxIn1(2))) or 
						 ((not sel0) and (sel1) and (i_muxIn2(2))) or 
						 ((sel0) and (sel1) and (i_muxIn3(2)));
						 
		out_mux(1) <= ((not sel0) and (not sel1) and (i_muxIn0(1))) or 
						 ((sel0) and (not sel1) and (i_muxIn1(1))) or 
						 ((not sel0) and (sel1) and (i_muxIn2(1))) or 
						 ((sel0) and (sel1) and (i_muxIn3(1)));
						 
		out_mux(0) <= ((not sel0) and (not sel1) and (i_muxIn0(0))) or 
						 ((sel0) and (not sel1) and (i_muxIn1(0))) or 
						 ((not sel0) and (sel1) and (i_muxIn2(0))) or 
						 ((sel0) and (sel1) and (i_muxIn3(0)));		
						
		o_mux <= out_mux;	
END rtl;
