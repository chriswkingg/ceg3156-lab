LIBRARY ieee;
USE  ieee.std_logic_1164.all;

ENTITY MultiplierDataPath is
    PORT
    (
        -- Multiplier Input Signals 
        SignA, SignB                    :   IN STD_LOGIC;
        MantissaA, MantissaB            :   IN STD_LOGIC_VECTOR(7 downto 0);
        ExponentA, ExponentB            :   IN STD_LOGIC_VECTOR(6 downto 0);
        GClock, GReset                  :   IN STD_LOGIC;
        -- Multiplier Output Signals 
        SignOut                         :   OUT STD_LOGIC;
        MantissaOut                     :   OUT STD_LOGIC_VECTOR(7 downto 0);
        ExponentOut                     :   OUT STD_LOGIC_VECTOR(6 downto 0);
        Overflow                        :   OUT STD_LOGIC;
        --Control Path Links
		  o_INCPM, o_EXPVLD : OUT STD_LOGIC;
		  i_LDPE, i_LDAM, i_LDBM, i_overflow, i_SHFTPM, i_INCPE : IN STD_LOGIC
		  
        
    );
    END MultiplierDataPath;

ARCHITECTURE rtl of MultiplierDataPath is

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
SIGNAL int_exponentsum, int_finalexponent : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL int_exponentA8Bit, int_exponentB8Bit : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	int_exponentA8Bit <= '0' & ExponentA;
	int_exponentB8Bit <= '0' & ExponentB;
	exponentAdder : EightBitAdderSubtractor
	PORT MAP
	  (
			InputA => int_exponentA8Bit,
			InputB => int_exponentB8Bit,
			Operation => '0',
			Result => int_exponentsum,
			CarryOUT => open
	  );
	exponentSubtractor : EightBitAdderSubtractor
	PORT MAP
	  (
			InputA => int_exponentsum,
			InputB => '00111111',
			Operation => '1',
			Result => int_exponentsum,
			CarryOUT => open
	  );
	productExponent : EightBitGPRegister
	  PORT MAP
	  (
			i_resetBar => NOT Greset,
			i_load => '0', 
			i_shiftLeft => '0', 
			i_shiftRight => '0',
			i_decrement => '0', 
			i_increment => '0'
			i_serial_in_left => '0', 
			i_serial_in_right => '0',
			i_clock => Gclock,
			i_Value => int_exponentsum,
			o_Value => int_finalexponent
	  );
	exponentComparator : EightBitComparator 
	  PORT MAP
	  (
			i_Ai => int_finalexponent,
			i_Bi => '01111111'
			o_GT => open, 
			o_LT => o_eXPVLD, 
			o_EQ => open
	  );
    
END ARCHITECTURE;