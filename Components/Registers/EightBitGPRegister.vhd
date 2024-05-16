LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EightBitGPRegister IS
    PORT 
    (
        -- Register Operations
        i_resetBar : IN STD_LOGIC;
        i_load, i_shiftLeft, i_shiftRight : IN STD_LOGIC;
        i_decrement, i_increment : IN STD_LOGIC;

        -- Register Signals
        i_serial_in_left, i_serial_in_right : IN STD_LOGIC;
        i_clock : IN STD_LOGIC;
        i_Value : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_Value : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END EightBitGPRegister;

ARCHITECTURE structural OF EightBitGPRegister IS
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


    COMPONENT EightBitAdderSubtractor 
        PORT
        (
            InputA, InputB  : IN STD_LOGIC_VECTOR(7 downto 0);
            Operation   :   IN STD_LOGIC;
            Result    :   OUT STD_LOGIC_VECTOR(7 downto 0);
            CarryOUT    :   OUT STD_LOGIC
        );
        END COMPONENT;
	 COMPONENT NineBitAdderSubtractor
	 PORT (
		InputA, InputB  : IN STD_LOGIC_VECTOR(8 downto 0);
      Operation   :   IN STD_LOGIC;
      Result    :   OUT STD_LOGIC_VECTOR(8 downto 0);
      CarryOUT    :   OUT STD_LOGIC
		
	 );
	 END COMPONENT;

    SIGNAL d_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL q_out : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL enable_reg : STD_LOGIC;
    SIGNAL operation_selectors : STD_LOGIC_VECTOR(2 downto 0);
    SIGNAL operation_decoder : STD_LOGIC_VECTOR(7 downto 0);

    -- Results of Operations
    SIGNAL incrementer_result : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL decrementer_result : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL mux_in_0 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_1 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_2 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_3 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_4 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_5 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_6 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_7 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL mux_in_8 : STD_LOGIC_VECTOR(7 downto 0);
    


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
    -- wtf lol - CK
	 mux_in_8 <= (0 => q_out(8), 1 => i_Value(8), 2 => q_out(7), 3 => i_serial_in_left, 4 => incrementer_result(8), 5 => decrementer_result(8), others => '1');

    OperationEncoder: EigthToThreeEncoder 
    PORT MAP(
        inputs => operation_decoder,
        outputs => operation_selectors
    );

    incrementer_adder: NineBitAdderSubtractor
        PORT MAP
        (
            InputA => q_out,
            InputB => "000000001",
            Operation => '0',
            Result => incrementer_result,
            CarryOUT => open
        );
    
    decrementer_adder: NineBitAdderSubtractor
        PORT MAP
        (
            InputA => q_out,
            InputB => "000000001",
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
    o_Value <= q_out;
END structural;
