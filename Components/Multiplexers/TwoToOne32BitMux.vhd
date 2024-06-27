LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TwoToOne32BitMux IS
    PORT (
        i_muxIn0, i_muxIn1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_mux              : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        sel                : IN STD_LOGIC
    );
END ENTITY TwoToOne32BitMux;

ARCHITECTURE rtl OF TwoToOne32BitMux IS
    SIGNAL out_mux : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    out_mux(31) <= ((not sel) and (i_muxIn0(31))) or 
                   (sel and (i_muxIn1(31)));
                         
    out_mux(30) <= ((not sel) and (i_muxIn0(30))) or 
                   (sel and (i_muxIn1(30)));

    out_mux(29) <= ((not sel) and (i_muxIn0(29))) or 
                   (sel and (i_muxIn1(29)));

    out_mux(28) <= ((not sel) and (i_muxIn0(28))) or 
                   (sel and (i_muxIn1(28)));

    out_mux(27) <= ((not sel) and (i_muxIn0(27))) or 
                   (sel and (i_muxIn1(27)));

    out_mux(26) <= ((not sel) and (i_muxIn0(26))) or 
                   (sel and (i_muxIn1(26)));

    out_mux(25) <= ((not sel) and (i_muxIn0(25))) or 
                   (sel and (i_muxIn1(25)));

    out_mux(24) <= ((not sel) and (i_muxIn0(24))) or 
                   (sel and (i_muxIn1(24)));  

    out_mux(23) <= ((not sel) and (i_muxIn0(23))) or 
                   (sel and (i_muxIn1(23)));
                         
    out_mux(22) <= ((not sel) and (i_muxIn0(22))) or 
                   (sel and (i_muxIn1(22)));

    out_mux(21) <= ((not sel) and (i_muxIn0(21))) or 
                   (sel and (i_muxIn1(21)));

    out_mux(20) <= ((not sel) and (i_muxIn0(20))) or 
                   (sel and (i_muxIn1(20)));

    out_mux(19) <= ((not sel) and (i_muxIn0(19))) or 
                   (sel and (i_muxIn1(19)));

    out_mux(18) <= ((not sel) and (i_muxIn0(18))) or 
                   (sel and (i_muxIn1(18)));

    out_mux(17) <= ((not sel) and (i_muxIn0(17))) or 
                   (sel and (i_muxIn1(17)));

    out_mux(16) <= ((not sel) and (i_muxIn0(16))) or 
                   (sel and (i_muxIn1(16)));

    out_mux(15) <= ((not sel) and (i_muxIn0(15))) or 
                   (sel and (i_muxIn1(15)));
                         
    out_mux(14) <= ((not sel) and (i_muxIn0(14))) or 
                   (sel and (i_muxIn1(14)));

    out_mux(13) <= ((not sel) and (i_muxIn0(13))) or 
                   (sel and (i_muxIn1(13)));

    out_mux(12) <= ((not sel) and (i_muxIn0(12))) or 
                   (sel and (i_muxIn1(12)));

    out_mux(11) <= ((not sel) and (i_muxIn0(11))) or 
                   (sel and (i_muxIn1(11)));

    out_mux(10) <= ((not sel) and (i_muxIn0(10))) or 
                   (sel and (i_muxIn1(10)));

    out_mux(9)  <= ((not sel) and (i_muxIn0(9))) or 
                   (sel and (i_muxIn1(9)));

    out_mux(8)  <= ((not sel) and (i_muxIn0(8))) or 
                   (sel and (i_muxIn1(8)));

    out_mux(7)  <= ((not sel) and (i_muxIn0(7))) or 
                   (sel and (i_muxIn1(7)));
                         
    out_mux(6)  <= ((not sel) and (i_muxIn0(6))) or 
                   (sel and (i_muxIn1(6)));

    out_mux(5)  <= ((not sel) and (i_muxIn0(5))) or 
                   (sel and (i_muxIn1(5)));

    out_mux(4)  <= ((not sel) and (i_muxIn0(4))) or 
                   (sel and (i_muxIn1(4)));

    out_mux(3)  <= ((not sel) and (i_muxIn0(3))) or 
                   (sel and (i_muxIn1(3)));

    out_mux(2)  <= ((not sel) and (i_muxIn0(2))) or 
                   (sel and (i_muxIn1(2)));

    out_mux(1)  <= ((not sel) and (i_muxIn0(1))) or 
                   (sel and (i_muxIn1(1)));

    out_mux(0)  <= ((not sel) and (i_muxIn0(0))) or 
                   (sel and (i_muxIn1(0))); 

    o_mux <= out_mux;

END rtl;
