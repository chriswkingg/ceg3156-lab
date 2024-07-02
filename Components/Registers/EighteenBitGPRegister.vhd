LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EighteenBitGPRegister IS
    PORT 
    (
        -- Register Operations
        i_resetBar : IN STD_LOGIC;
        i_load, i_shiftLeft, i_shiftRight : IN STD_LOGIC;
        i_decrement, i_increment : IN STD_LOGIC;

        -- Register Signals
        i_serial_in_left, i_serial_in_right : IN STD_LOGIC;
        i_clock : IN STD_LOGIC;
        i_Value : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        o_Value : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
    );
END ENTITY EighteenBitGPRegister;

ARCHITECTURE structural OF EighteenBitGPRegister IS
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

    COMPONENT EigthToThreeEncoder
        PORT 
        (
            inputs : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            outputs : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT;


    COMPONENT EighteenBitAdderSubtractor 
        PORT
        (
            InputA, InputB  : IN STD_LOGIC_VECTOR(17 downto 0);
            Operation   :   IN STD_LOGIC;
            Result    :   OUT STD_LOGIC_VECTOR(17 downto 0);
            CarryOUT    :   OUT STD_LOGIC
        );
        END COMPONENT;

    SIGNAL d_in : STD_LOGIC_VECTOR(17 DOWNTO 0);
    SIGNAL q_out : STD_LOGIC_VECTOR(17 DOWNTO 0);
    SIGNAL enable_reg : STD_LOGIC;
    SIGNAL operation_selectors : STD_LOGIC_VECTOR(2 downto 0);
    SIGNAL operation_decoder : STD_LOGIC_VECTOR(7 downto 0);

    -- Results of Operations
    SIGNAL incrementer_result : STD_LOGIC_VECTOR(17 DOWNTO 0);
    SIGNAL decrementer_result : STD_LOGIC_VECTOR(17 DOWNTO 0);
    SIGNAL mux_in_0 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_1 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_2 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_3 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_4 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_5 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_6 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_7 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_8 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_9 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_10 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_11 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_12 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_13 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_14 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_15 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_16 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_17 : STD_LOGIC_VECTOR(7 downto 0);
    


BEGIN

    enable_reg <= i_load or i_shiftLeft or i_shiftRight or i_increment or i_decrement;
    operation_decoder <= (5 => i_decrement, 4 => i_increment, 3 => i_shiftRight, 2 => i_shiftLeft, 1 => i_load, others => '0');

    mux_in_0 <= (0 => q_out(0), 1 => i_Value(0), 2 => i_serial_in_right, 3 => q_out(1), 4 => incrementer_result(0), 5 => decrementer_result(0), others => '1');
    mux_in_1 <= (0 => q_out(1), 1 => i_Value(1), 2 => q_out(0), 3 => q_out(2), 4 => incrementer_result(1), 5 => decrementer_result(1), others => '1');
    mux_in_2 <= (0 => q_out(2), 1 => i_Value(2), 2 => q_out(1), 3 => q_out(3), 4 => incrementer_result(2), 5 => decrementer_result(2), others => '1');
    mux_in_3 <= (0 => q_out(3), 1 => i_Value(3), 2 => q_out(2), 3 => q_out(4), 4 => incrementer_result(3), 5 => decrementer_result(3), others => '1');
    mux_in_4 <= (0 => q_out(4), 1 => i_Value(4), 2 => q_out(3), 3 => q_out(5), 4 => incrementer_result(4), 5 => decrementer_result(4), others => '1');
    mux_in_5 <= (0 => q_out(5), 1 => i_Value(5), 2 => q_out(4), 3 => q_out(6), 4 => incrementer_result(5), 5 => decrementer_result(5), others => '1');
    mux_in_6 <= (0 => q_out(6), 1 => i_Value(6), 2 => q_out(5), 3 => q_out(7), 4 => incrementer_result(6), 5 => decrementer_result(6), others => '1');
    mux_in_7 <= (0 => q_out(7), 1 => i_Value(7), 2 => q_out(6), 3 => q_out(8), 4 => incrementer_result(7), 5 => decrementer_result(7), others => '1');
    mux_in_8 <= (0 => q_out(8), 1 => i_Value(8), 2 => q_out(7), 3 => q_out(9), 4 => incrementer_result(8), 5 => decrementer_result(8), others => '1');
    mux_in_9 <= (0 => q_out(9), 1 => i_Value(9), 2 => q_out(8), 3 => q_out(10), 4 => incrementer_result(9), 5 => decrementer_result(9), others => '1');
    mux_in_10 <= (0 => q_out(10), 1 => i_Value(10), 2 => q_out(9), 3 => q_out(11), 4 => incrementer_result(10), 5 => decrementer_result(10), others => '1');
    mux_in_11 <= (0 => q_out(11), 1 => i_Value(11), 2 => q_out(10), 3 => q_out(12), 4 => incrementer_result(11), 5 => decrementer_result(11), others => '1');
    mux_in_12 <= (0 => q_out(12), 1 => i_Value(12), 2 => q_out(11), 3 => q_out(13), 4 => incrementer_result(12), 5 => decrementer_result(12), others => '1');
    mux_in_13 <= (0 => q_out(13), 1 => i_Value(13), 2 => q_out(12), 3 => q_out(14), 4 => incrementer_result(13), 5 => decrementer_result(13), others => '1');
    mux_in_14 <= (0 => q_out(14), 1 => i_Value(14), 2 => q_out(13), 3 => q_out(15), 4 => incrementer_result(14), 5 => decrementer_result(14), others => '1');
    mux_in_15 <= (0 => q_out(15), 1 => i_Value(15), 2 => q_out(14), 3 => q_out(16), 4 => incrementer_result(15), 5 => decrementer_result(15), others => '1');
    mux_in_16 <= (0 => q_out(16), 1 => i_Value(16), 2 => q_out(15), 3 => q_out(17), 4 => incrementer_result(16), 5 => decrementer_result(16), others => '1');
    mux_in_17 <= (0 => q_out(17), 1 => i_Value(17), 2 => q_out(16), 3 => i_serial_in_left, 4 => incrementer_result(17), 5 => decrementer_result(17), others => '1');

    OperationEncoder: EigthToThreeEncoder 
    PORT MAP(
        inputs => operation_decoder,
        outputs => operation_selectors
    );

    incrementer_adder: EighteenBitAdderSubtractor
        PORT MAP
        (
            InputA => q_out,
            InputB => "000000000000000001",
            Operation => '0',
            Result => incrementer_result,
            CarryOUT => open
        );
    
    decrementer_adder: EighteenBitAdderSubtractor
        PORT MAP
        (
            InputA => q_out,
            InputB => "000000000000000001",
            Operation => '1',
            Result => decrementer_result,
            CarryOUT => open
        );

    mux0: EightToOneMux
    PORT MAP
    (
        i_mux => mux_in_0,
        o_mux => d_in(0),
        sel0 => operation_selectors(0),
        sel1 => operation_selectors(1),
        sel2 => operation_selectors(2)
    );

    dff0: enARdFF_2
    PORT MAP (
        i_d => d_in(0),
        i_clock => i_clock,
        i_enable => enable_reg,
		i_resetBar => i_resetBar,
        o_q => q_out(0),
        o_qBar => open
    );

    mux1: EightToOneMux
    PORT MAP
    (
        i_mux => mux_in_1,
        o_mux => d_in(1),
        sel0 => operation_selectors(0),
        sel1 => operation_selectors(1),
        sel2 => operation_selectors(2)
    );

    dff1: enARdFF_2
    PORT MAP (
        i_d => d_in(1),
        i_clock => i_clock,
        i_enable => enable_reg,
		i_resetBar => i_resetBar,
        o_q => q_out(1),
        o_qBar => open
    );

    mux2: EightToOneMux
    PORT MAP
    (
        i_mux => mux_in_2,
        o_mux => d_in(2),
        sel0 => operation_selectors(0),
        sel1 => operation_selectors(1),
        sel2 => operation_selectors(2)
    );

    dff2: enARdFF_2
    PORT MAP (
        i_d => d_in(2),
        i_clock => i_clock,
        i_enable => enable_reg,
		i_resetBar => i_resetBar,
        o_q => q_out(2),
        o_qBar => open
    );

    mux3: EightToOneMux
    PORT MAP
    (
        i_mux => mux_in_3,
        o_mux => d_in(3),
        sel0 => operation_selectors(0),
        sel1 => operation_selectors(1),
        sel2 => operation_selectors(2)
    );

    dff3: enARdFF_2
    PORT MAP (
        i_d => d_in(3),
        i_clock => i_clock,
        i_enable => enable_reg,
		i_resetBar => i_resetBar,
        o_q => q_out(3),
        o_qBar => open
    );

    mux4: EightToOneMux
    PORT MAP
    (
        i_mux => mux_in_4,
        o_mux => d_in(4),
        sel0 => operation_selectors(0),
        sel1 => operation_selectors(1),
        sel2 => operation_selectors(2)
    );

    dff4: enARdFF_2
    PORT MAP (
        i_d => d_in(4),
        i_clock => i_clock,
        i_enable => enable_reg,
		i_resetBar => i_resetBar,
        o_q => q_out(4),
        o_qBar => open
    );

    mux5: EightToOneMux
    PORT MAP
    (
        i_mux => mux_in_5,
        o_mux => d_in(5),
        sel0 => operation_selectors(0),
        sel1 => operation_selectors(1),
        sel2 => operation_selectors(2)
    );

    dff5: enARdFF_2
    PORT MAP (
        i_d => d_in(5),
        i_clock => i_clock,
        i_enable => enable_reg,
		i_resetBar => i_resetBar,
        o_q => q_out(5),
        o_qBar => open
    );

    mux6: EightToOneMux
    PORT MAP
    (
        i_mux => mux_in_6,
        o_mux => d_in(6),
        sel0 => operation_selectors(0),
        sel1 => operation_selectors(1),
        sel2 => operation_selectors(2)
    );

    dff6: enARdFF_2
    PORT MAP (
        i_d => d_in(6),
        i_clock => i_clock,
        i_enable => enable_reg,
		i_resetBar => i_resetBar,
        o_q => q_out(6),
        o_qBar => open
    );

    mux7: EightToOneMux
    PORT MAP
    (
        i_mux => mux_in_7,
        o_mux => d_in(7),
        sel0 => operation_selectors(0),
        sel1 => operation_selectors(1),
        sel2 => operation_selectors(2)
    );

    dff7: enARdFF_2
    PORT MAP (
        i_d => d_in(7),
        i_clock => i_clock,
        i_enable => enable_reg,
		i_resetBar => i_resetBar,
        o_q => q_out(7),
        o_qBar => open
    );

    mux8: EightToOneMux
    PORT MAP
    (
        i_mux => mux_in_8,
        o_mux => d_in(8),
        sel0 => operation_selectors(0),
        sel1 => operation_selectors(1),
        sel2 => operation_selectors(2)
    );

    dff8: enARdFF_2
    PORT MAP (
        i_d => d_in(8),
        i_clock => i_clock,
        i_enable => enable_reg,
		i_resetBar => i_resetBar,
        o_q => q_out(8),
        o_qBar => open
    );

    mux9: EightToOneMux
    PORT MAP
    (
        i_mux => mux_in_9,
        o_mux => d_in(9),
        sel0 => operation_selectors(0),
        sel1 => operation_selectors(1),
        sel2 => operation_selectors(2)
    );

    dff9: enARdFF_2
    PORT MAP (
        i_d => d_in(9),
        i_clock => i_clock,
        i_enable => enable_reg,
		i_resetBar => i_resetBar,
        o_q => q_out(9),
        o_qBar => open
    );

    mux10: EightToOneMux
    PORT MAP
    (
        i_mux => mux_in_10,
        o_mux => d_in(10),
        sel0 => operation_selectors(0),
        sel1 => operation_selectors(1),
        sel2 => operation_selectors(2)
    );

    dff10: enARdFF_2
    PORT MAP (
        i_d => d_in(10),
        i_clock => i_clock,
        i_enable => enable_reg,
		i_resetBar => i_resetBar,
        o_q => q_out(10),
        o_qBar => open
    );

    mux11: EightToOneMux
    PORT MAP
    (
        i_mux => mux_in_11,
        o_mux => d_in(11),
        sel0 => operation_selectors(0),
        sel1 => operation_selectors(1),
        sel2 => operation_selectors(2)
    );

    dff11: enARdFF_2
    PORT MAP (
        i_d => d_in(11),
        i_clock => i_clock,
        i_enable => enable_reg,
		i_resetBar => i_resetBar,
        o_q => q_out(11),
        o_qBar => open
    );

    mux12: EightToOneMux
    PORT MAP
    (
        i_mux => mux_in_12,
        o_mux => d_in(12),
        sel0 => operation_selectors(0),
        sel1 => operation_selectors(1),
        sel2 => operation_selectors(2)
    );

    dff12: enARdFF_2
    PORT MAP (
        i_d => d_in(12),
        i_clock => i_clock,
        i_enable => enable_reg,
		i_resetBar => i_resetBar,
        o_q => q_out(12),
        o_qBar => open
    );

    mux13: EightToOneMux
    PORT MAP
    (
        i_mux => mux_in_13,
        o_mux => d_in(13),
        sel0 => operation_selectors(0),
        sel1 => operation_selectors(1),
        sel2 => operation_selectors(2)
    );

    dff13: enARdFF_2
    PORT MAP (
        i_d => d_in(13),
        i_clock => i_clock,
        i_enable => enable_reg,
		i_resetBar => i_resetBar,
        o_q => q_out(13),
        o_qBar => open
    );

    mux14: EightToOneMux
    PORT MAP
    (
        i_mux => mux_in_14,
        o_mux => d_in(14),
        sel0 => operation_selectors(0),
        sel1 => operation_selectors(1),
        sel2 => operation_selectors(2)
    );

    dff14: enARdFF_2
    PORT MAP (
        i_d => d_in(14),
        i_clock => i_clock,
        i_enable => enable_reg,
		i_resetBar => i_resetBar,
        o_q => q_out(14),
        o_qBar => open
    );

    mux15: EightToOneMux
    PORT MAP
    (
        i_mux => mux_in_15,
        o_mux => d_in(15),
        sel0 => operation_selectors(0),
        sel1 => operation_selectors(1),
        sel2 => operation_selectors(2)
    );

    dff15: enARdFF_2
    PORT MAP (
        i_d => d_in(15),
        i_clock => i_clock,
        i_enable => enable_reg,
		i_resetBar => i_resetBar,
        o_q => q_out(15),
        o_qBar => open
    );

    mux16: EightToOneMux
    PORT MAP
    (
        i_mux => mux_in_16,
        o_mux => d_in(16),
        sel0 => operation_selectors(0),
        sel1 => operation_selectors(1),
        sel2 => operation_selectors(2)
    );

    dff16: enARdFF_2
    PORT MAP (
        i_d => d_in(16),
        i_clock => i_clock,
        i_enable => enable_reg,
		i_resetBar => i_resetBar,
        o_q => q_out(16),
        o_qBar => open
    );

    mux17: EightToOneMux
    PORT MAP
    (
        i_mux => mux_in_17,
        o_mux => d_in(17),
        sel0 => operation_selectors(0),
        sel1 => operation_selectors(1),
        sel2 => operation_selectors(2)
    );

    dff17: enARdFF_2
    PORT MAP (
        i_d => d_in(17),
        i_clock => i_clock,
        i_enable => enable_reg,
		i_resetBar => i_resetBar,
        o_q => q_out(17),
        o_qBar => open
    );
    o_Value <= q_out;
END structural;
