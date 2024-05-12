LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY NineBitGPRegister IS
    PORT 
    (
        -- Register Operations
        i_resetBar : IN STD_LOGIC;
        i_load, i_shiftLeft, i_shiftRight : IN STD_LOGIC;
        i_decrement, i_increment : IN STD_LOGIC;

        -- Register Signals
        i_clock : IN STD_LOGIC;
        i_Value : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        o_Value : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
    );
END NineBitGPRegister;

ARCHITECTURE structural OF NineBitGPRegister IS
    COMPONENT enARdFF_2
        PORT (
            i_d : IN STD_LOGIC;
            i_clock : IN STD_LOGIC;
            i_enable : IN STD_LOGIC;
            i_resetBar : IN STD_LOGIC;
            o_q, o_qBar : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT EightToOneMux
        PORT (
            i_mux: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_mux: OUT STD_LOGIC;
            sel0, sel1, sel2: IN STD_LOGIC
        );
    END COMPONENT;

    SIGNAL d_in : STD_LOGIC_VECTOR(8 DOWNTO 0);
    SIGNAL q_out : STD_LOGIC_VECTOR(8 DOWNTO 0);
    SIGNAL int_muxSelect0, int_muxSelect1 : STD_LOGIC;

BEGIN

    int_muxSelect0 <=  i_shiftLeft and not i_shiftRight;
	int_muxSelect1 <= i_load;
	 
    dff0: enARdFF_2
    PORT MAP (
        i_d => d_in(0),
        i_clock => i_clock,
        i_enable => i_load or i_shiftLeft or i_shiftRight,
		i_resetBar => i_reset,
        o_q => q_out(0),
        o_qBar => open
    );

    mux0: EightToOneMux
    PORT MAP (
        w0 => q_out(1),
        w1 => q_out(8),
        w2 => i_Value(0),
        w3 => '0',
        s0 => int_muxSelect0,
        s1 => int_muxSelect1,
        f => d_in(0)
    );

    dff1: enARdFF_2
    PORT MAP (
        i_d => d_in(1),
        i_clock => i_clock,
        i_enable => i_load or i_shiftLeft or i_shiftRight,
		i_resetBar => i_reset,
        o_q => q_out(1),
        o_qBar => open
    );

    mux1: EightToOneMux
    PORT MAP (
        w0 => q_out(2),
        w1 => q_out(0),
        w2 => i_value(1),
        w3 => '0',
        s0 => int_muxSelect0,
        s1 => int_muxSelect1,
        f => d_in(1)
    );

    dff2: enARdFF_2
    PORT MAP (
        i_d => d_in(2),
        i_clock => i_clock,
        i_enable => i_load or i_shiftLeft or i_shiftRight,
		i_resetBar => i_reset,
        o_q => q_out(2),
        o_qBar => open
    );

    mux2: EightToOneMux
    PORT MAP (
        w0 => q_out(3),
        w1 => q_out(1),
        w2 => i_value(2),
        w3 => '0',
        s0 => int_muxSelect0,
        s1 => int_muxSelect1,
        f => d_in(2)
    );

    dff3: enARdFF_2
    PORT MAP (
        i_d => d_in(3),
        i_clock => i_clock,
        i_enable => i_load or i_shiftLeft or i_shiftRight,
		i_resetBar => i_reset,
        o_q => q_out(3),
        o_qBar => open
    );

    mux3: EightToOneMux
    PORT MAP (
        w0 => q_out(4),
        w1 => q_out(2),
        w2 => i_value(3),
        w3 => '0',
        s0 => int_muxSelect0,
        s1 => int_muxSelect1,
        f => d_in(3)
    );

    dff4: enARdFF_2
    PORT MAP (
        i_d => d_in(4),
        i_clock => i_clock,
        i_enable => i_load or i_shiftLeft or i_shiftRight,
		i_resetBar => i_reset,
        o_q => q_out(4),
        o_qBar => open
    );

    mux4: EightToOneMux
    PORT MAP (
        w0 => q_out(5),
        w1 => q_out(3),
        w2 => i_value(4),
        w3 => '0',
        s0 => int_muxSelect0,
        s1 => int_muxSelect1,
        f => d_in(4)
    );

    dff5: enARdFF_2
    PORT MAP (
        i_d => d_in(5),
        i_clock => i_clock,
        i_enable => i_load or i_shiftLeft or i_shiftRight,
		i_resetBar => i_reset,
        o_q => q_out(5),
        o_qBar => open
    );

    mux5: EightToOneMux
    PORT MAP (
        w0 => q_out(6),
        w1 => q_out(4),
        w2 => i_value(5),
        w3 => '0',
        s0 => int_muxSelect0,
        s1 => int_muxSelect1,
        f => d_in(5)
    );

    dff6: enARdFF_2
    PORT MAP (
        i_d => d_in(6),
        i_clock => i_clock,
        i_enable => i_load or i_shiftLeft or i_shiftRight,
		i_resetBar => i_reset,
        o_q => q_out(6),
        o_qBar => open
    );

    mux6: EightToOneMux
    PORT MAP (
        w0 => q_out(8),
        w1 => q_out(5),
        w2 => i_value(6),
        w3 => '0',
        s0 => int_muxSelect0,
        s1 => int_muxSelect1,
        f => d_in(6)
    );

    dff8: enARdFF_2
    PORT MAP (
        i_d => d_in(8),
        i_clock => i_clock,
        i_enable => i_load or i_shiftLeft or i_shiftRight,
		i_resetBar => i_reset,
        o_q => q_out(8),
        o_qBar => open
    );
	mux8: EightToOneMux
	PORT MAP (
		 w0 => q_out(0),
		 w1 => q_out(6),
		 w2 => i_value(8),
		 w3 => '0',
		 s0 => int_muxSelect0,
		 s1 => int_muxSelect1,
		 f => d_in(8)
	);
    o_Value <= q_out;
END structural;
