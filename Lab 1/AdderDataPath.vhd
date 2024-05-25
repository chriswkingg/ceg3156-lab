LIBRARY ieee;
USE  ieee.std_logic_1164.all;

ENTITY AdderDataPath is
    PORT
    (
        -- Adder Input Signals 
        SignA, SignB                    :   IN STD_LOGIC;
        MantissaA, MantissaB            :   IN STD_LOGIC_VECTOR(7 downto 0);
        ExponentA, ExponentB            :   IN STD_LOGIC_VECTOR(6 downto 0);
        GClock, GReset                  :   IN STD_LOGIC;
        -- Adder Output Signals 
        SignOut                         :   OUT STD_LOGIC;
        MantissaOut                     :   OUT STD_LOGIC_VECTOR(7 downto 0);
        ExponentOut                     :   OUT STD_LOGIC_VECTOR(6 downto 0);
        Overflow                        :   OUT STD_LOGIC;
        --Control Path Links
        SHFTM                           :   IN STD_LOGIC;
        LDDC, DECDC                     :   IN STD_LOGIC;
        LDAM, LDBM                      :   IN STD_LOGIC;
        LDSM, LSHFTM, RSHFTM            :   IN STD_LOGIC;
        LDSE, INCSE, DECSE              :   IN STD_LOGIC;
        CLRS, LDAS                      :   IN STD_LOGIC;
        DCEMT, MantissaCarry, MantissaSubMSB : OUT STD_LOGIC;
		  -- Debug
		  o_register_Am_result, o_register_Bm_result, o_mantissaAddResult : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
    );
    END AdderDataPath;

ARCHITECTURE rtl of AdderDataPath is

    SIGNAL SHFTAM, SHFTBM, AEGTBE, AELTBE, DCEMT_SIG    : STD_LOGIC;
    SIGNAL SignAorSignBNegative             : STD_LOGIC;
    SIGNAL exponentSubtractor_result        : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL exponentDifferenceNegator_result : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL ExponentA_8Bit, ExponentB_8Bit   : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL MantissaA_9Bit, MantissaB_9Bit   : STD_LOGIC_VECTOR(8 downto 0);
    SIGNAL downcounter_result               : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL register_Am_result               : STD_LOGIC_VECTOR(8 downto 0);
    SIGNAL register_Bm_result               : STD_LOGIC_VECTOR(8 downto 0);
    SIGNAL register_Am_negator_result       : STD_LOGIC_VECTOR(8 downto 0);
    SIGNAL register_Bm_negator_result       : STD_LOGIC_VECTOR(8 downto 0);
    SIGNAL mantissa_adder_result            : STD_LOGIC_VECTOR(8 downto 0);
    SIGNAL complementer_Sm_result           : STD_LOGIC_VECTOR(8 downto 0);
    SIGNAL mantissa_adder_8Bit              : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL register_Sm_result               : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL larger_exponent                  : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL register_Se_result               : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL register_Sum_input               : STD_LOGIC_VECTOR(15 downto 0);
    SIGNAL mantissaAddCarry					  : STD_LOGIC;

    COMPONENT EightBitComparator IS
        PORT(
            i_Ai, i_Bi			    : IN	STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_GT, o_LT, o_EQ		: OUT	STD_LOGIC
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
    
    COMPONENT EightBitGPRegister
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
    END COMPONENT;


    
    COMPONENT NineBitAdderSubtractor
        PORT
        (
            InputA, InputB  : IN STD_LOGIC_VECTOR(8 downto 0);
            Operation   :   IN STD_LOGIC;
            Result    :   OUT STD_LOGIC_VECTOR(8 downto 0);
            CarryOUT    :   OUT STD_LOGIC
        );
        END COMPONENT;
    
    COMPONENT NineBitGPRegister
        PORT 
        (
            -- Register Operations
            i_resetBar : IN STD_LOGIC;
            i_load, i_shiftLeft, i_shiftRight : IN STD_LOGIC;
            i_decrement, i_increment : IN STD_LOGIC;

            -- Register Signals
            i_serial_in_left, i_serial_in_right : IN STD_LOGIC;
            i_clock : IN STD_LOGIC;
            i_Value : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
            o_Value : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT TwoToOne8BitMux
        PORT (
            i_muxIn0, i_muxIn1	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_mux				: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            sel					: IN STD_LOGIC
        );
    END COMPONENT;

    COMPONENT mux_2to1_top
        Port ( SEL : in  STD_LOGIC;
            A   : in  STD_LOGIC;
            B   : in  STD_LOGIC;
            X   : out STD_LOGIC);
    END COMPONENT;

    BEGIN

    SHFTAM <= SHFTM and AELTBE;
    SHFTBM <= SHFTM and AEGTBE;

    ExponentA_8Bit <= '0' & ExponentA;
    ExponentB_8Bit <= '0' & ExponentB;
    MantissaA_9Bit <= '1' & MantissaA;
    MantissaB_9Bit <= '1' & MantissaB;

    mantissa_adder_8Bit <=  complementer_Sm_result(7 downto 0);

    SignAorSignBNegative <= SignA xor SignB;

    DCEMT <= DCEMT_SIG;
    MantissaCarry <= mantissaAddCarry;
    MantissaSubMSB <= mantissa_adder_result(8);


    exponentComparator   :   EightBitComparator
        PORT MAP
        (
            i_Ai => ExponentA_8Bit,
            i_Bi => ExponentB_8Bit,
            o_GT => AEGTBE,
            o_LT => AELTBE,
            o_EQ => open
        );

    exponentSubtractor  :   EightBitAdderSubtractor
        PORT MAP
        (
            InputA => ExponentA_8Bit,
            InputB => ExponentB_8Bit,
            Operation => '1', -- Which means subtract
            Result => exponentSubtractor_result,
            CarryOUT => open
        );

    exponentDifferenceNegator  :   EightBitAdderSubtractor
        PORT MAP
        (
            InputA => "00000000",
            InputB => exponentSubtractor_result,
            Operation => AELTBE,
            Result => exponentDifferenceNegator_result,
            CarryOUT => open
        );

    downcounter     :   EightBitGPRegister
        PORT MAP
        (

            i_resetBar => GReset,
            i_load => LDDC, 
            i_shiftLeft => '0',
            i_shiftRight => '0',
            i_decrement => DECDC,
            i_increment => '0',
            i_serial_in_left => '0',
            i_serial_in_right => '0',
            i_clock => GClock,
            i_Value => exponentDifferenceNegator_result,
            o_Value => downcounter_result

        );

    downcounterEmptyComparator   :   EightBitComparator
        PORT MAP
        (
            i_Ai => downcounter_result,
            i_Bi => "00000000",
            o_GT => open,
            o_LT => open,
            o_EQ => DCEMT_SIG
        );

    register_Am     : NineBitGPRegister
        PORT MAP
        (
        
            i_resetBar => GReset,
            i_load => LDAM, 
            i_shiftLeft => '0',
            i_shiftRight => SHFTAM,
            i_decrement => '0',
            i_increment => '0',
            i_serial_in_left => '0',
            i_serial_in_right => '0',
            i_clock => GClock,
            i_Value => MantissaA_9Bit,
            o_Value => register_Am_result

        );  
    
    register_Bm     : NineBitGPRegister
        PORT MAP
        (
        
            i_resetBar => GReset,
            i_load => LDBM, 
            i_shiftLeft => '0',
            i_shiftRight => SHFTBM,
            i_decrement => '0',
            i_increment => '0',
            i_serial_in_left => '0',
            i_serial_in_right => '0',
            i_clock => GClock,
            i_Value => MantissaB_9Bit,
            o_Value => register_Bm_result

        ); 
    
    register_Am_negator  :   NineBitAdderSubtractor
        PORT MAP
        (
            InputA => "000000000",
            InputB => MantissaA_9Bit,
            Operation => SignA, 
            Result => register_Am_negator_result,
            CarryOUT => open
        );

    register_Bm_negator  :   NineBitAdderSubtractor
        PORT MAP
        (
            InputA => "000000000",
            InputB => MantissaB_9Bit,
            Operation => SignB,
            Result => register_Bm_negator_result,
            CarryOUT => open
        );
    
    mantissa_adder  :   NineBitAdderSubtractor
        PORT MAP
        (
            InputA => register_Am_result,
            InputB => register_Bm_result,
            Operation => '0',
            Result => mantissa_adder_result,
            CarryOUT => mantissaAddCarry
        );

    complementer_Sm     : NineBitAdderSubtractor
        PORT MAP
        (
            InputA => "000000000",
            InputB => mantissa_adder_result,
            Operation => SignAorSignBNegative,
            Result => complementer_Sm_result,
            CarryOUT => Overflow
        );
    
    register_Sm          : EightBitGPRegister
        PORT MAP
        (
        
            i_resetBar => GReset,
            i_load => LDSM, 
            i_shiftLeft => LSHFTM,
            i_shiftRight => RSHFTM,
            i_decrement => '0',
            i_increment => '0',
            i_serial_in_left => '0',
            i_serial_in_right => '1',
            i_clock => GClock,
            i_Value => mantissa_adder_8Bit,
            o_Value => register_Sm_result

        );
    
    expoenntChoser      : TwoToOne8BitMux
        PORT MAP
        (
            i_muxIn0 => ExponentB_8Bit,
            i_muxIn1 => ExponentA_8Bit,
            o_mux => larger_exponent,
            sel	=> AEGTBE
        );
    
    register_Se          : EightBitGPRegister
        PORT MAP
        (
        
            i_resetBar => GReset,
            i_load => LDSE, 
            i_shiftLeft => '0',
            i_shiftRight => '0',
            i_decrement => DECSE,
            i_increment => INCSE,
            i_serial_in_left => '0',
            i_serial_in_right => '0',
            i_clock => GClock,
            i_Value => larger_exponent,
            o_Value => register_Se_result

        );
    
    SignOutChoser      : mux_2to1_top
    PORT MAP
    ( 
        SEL => AEGTBE,
        A => SignA,
        B => SignB,
        X => SignOut
    );
    
    MantissaOut <= register_Sm_result;
    ExponentOut <= register_Se_result(6 downto 0);
	 o_register_Am_result <= register_Am_result;
	 o_register_Bm_result <= register_Bm_result;
	 o_mantissaAddResult <= mantissa_adder_result;
	 	 END ARCHITECTURE;