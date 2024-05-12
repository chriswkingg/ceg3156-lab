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
    );
    END AdderDataPath;

ARCHITECTURE rtl of AdderDataPath is

    SIGNAL SHFTAM, SHFTBM, AEGTBE, DCEMT    : STD_LOGIC;
    SIGNAL adder1_result, adder2_result     : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL downcounter_result               : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL register_Am_result               : STD_LOGIC_VECTOR(7 downto 0);

    COMPONENT EightBitComparator IS
        PORT(
            i_Ai, i_Bi			    : IN	STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_GT, o_LT, o_EQ		: OUT	STD_LOGIC
        );
        END COMPONENT;
    
    COMPONENT AdderSubtractor is 
        PORT
        (
            InputA, InputB  :   IN STD_LOGIC_VECTOR(3 downto 0);
            Operation       :   IN STD_LOGIC;
            Result          :   OUT STD_LOGIC_VECTOR(3 downto 0);
            CarryOUT        :   OUT STD_LOGIC
        );
        END COMPONENT;
    
    COMPONENT EightBitDecrementer IS
        PORT(
            i_resetBar, i_load, i_dec    : IN    STD_LOGIC;
            i_clock                      : IN    STD_LOGIC;
            i_Value                      : IN    STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_Value                      : OUT    STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
        END COMPONENT;

    COMPONENT EightBitLeftShiftRegister IS
        PORT (
            i_resetBar, i_load, i_shift : IN STD_LOGIC;
            i_clock : IN STD_LOGIC;
            i_shift_entry : IN STD_LOGIC;
            o_shift_out   : OUT STD_LOGIC;
            i_Value : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_Value : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
        END COMPONENT;

    COMPONENT EightBitRightShiftRegister IS
        PORT (
            i_resetBar, i_load, i_shift : IN STD_LOGIC;
            i_clock                     : IN STD_LOGIC;
            i_shift_entry               : IN STD_LOGIC;
            o_shift_out                 : OUT STD_LOGIC;
            i_Value                     : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_Value                     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
        END COMPONENT;

    COMPONENT EightBitRegister IS
        PORT (
            i_resetBar, i_load, i_clock : IN    STD_LOGIC;
            i_Value                     : IN    STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_Value                     : OUT   STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
        END COMPONENT;

    BEGIN

    SHFTAM <= SHFTM and AEGTBE;
    SHFTBM <= SHFTM and (not AEGTBE);

    comp1   :   EightBitComparator
        PORT MAP
        (
            i_Ai => ExponentA,
            i_Bi => ExponentB,
            o_GT => AEGTBE,
            o_LT => open,
            o_EQ => open
        );

    adder1  :   AdderSubtractor
        PORT MAP
        (
            InputA => ExponentA,
            InputB => ExponentB,
            Operation => '1',
            Result => adder1_result,
            CarryOUT => open
        );

    adder2  :   AdderSubtractor
        PORT MAP
        (
            InputA => adder1_result,
            InputB => "00000000",
            Operation => AEGTBE,
            Result => adder2_result,
            CarryOUT => open
        );

    downcounter     :   EightBitDecrementer
        PORT
        (
            i_resetBar => GReset,
            i_load => LDDC,
            i_dec => DECDC,
            i_clock => GClock,
            i_Value => adder2_result,
            o_Value => ,
        );

    comp2   :   EightBitComparator
        PORT MAP
        (
            i_Ai => downcounter_result,
            i_Bi => "00000000",
            o_GT => open,
            o_LT => open,
            o_EQ => DCEMT
        );

    register_Am     :   EightBitLeftShiftRegister
        PORT MAP
        (
            i_resetBar => GReset,
            i_load => LDAM,
            i_clock => GClock,
            i_shift_entry => '0',
            o_Value => register_Am_result,
        );
    
    register_Bm     :   EightBitLeftShiftRegister
        PORT MAP
        (
            i_resetBar => GReset,
            i_load => LDAM,
            i_clock => GClock, 
            i_shift_entry => '0',
            o_Value => register_Am_result,
        );
    END ARCHITECTURE;
