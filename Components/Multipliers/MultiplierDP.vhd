LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MultiplierDP is
    PORT 
    (
        IN1, IN2    :   IN STD_LOGIC_VECTOR(3 downto 0);
        LSHFTA, RSHFTB, LDA, LDB, INCI, CLRI, LDP, CLRP, RESET, CLK    : IN STD_LOGIC;
        ILT3, B0IS1 :   OUT STD_LOGIC;
        Product     :   OUT STD_LOGIC_VECTOR(7 downto 0)

    );
    END ENTITY;

ARCHITECTURE rtl of MultiplierDP is
    SIGNAL A_IN, Adder_OUT, AdderIN1, AdderIN2    :   STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL A_OUT, B_OUT, I_OUT, BLSB       : STD_LOGIC_VECTOR(3 downto 0);

    COMPONENT EightBitLeftShiftRegister IS
        PORT (
            i_resetBar, i_load, i_shift    : IN    STD_LOGIC;
            i_clock            : IN    STD_LOGIC;
            i_shift_entry            : IN    STD_LOGIC;
            i_Value            : IN    STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_Value            : OUT    STD_LOGIC_VECTOR(7 DOWNTO 0)
            );
        END COMPONENT;
    
    COMPONENT FourBitRightShiftRegister IS
        PORT (
            i_resetBar, i_load, i_shift    : IN    STD_LOGIC;
            i_clock            : IN    STD_LOGIC;
            i_shift_entry            : IN    STD_LOGIC;
            i_Value            : IN    STD_LOGIC_VECTOR(3 DOWNTO 0);
            o_Value            : OUT    STD_LOGIC_VECTOR(3 DOWNTO 0)
            );
        END COMPONENT;  

    COMPONENT FourBitIncrementer IS
        PORT(
            i_resetBar, i_load, i_inc    : IN    STD_LOGIC;
            i_clock            : IN    STD_LOGIC;
            i_Value            : IN    STD_LOGIC_VECTOR(3 DOWNTO 0);
            o_Value            : OUT    STD_LOGIC_VECTOR(3 DOWNTO 0)
            );
        END COMPONENT; 

    COMPONENT AdderSubtractor is 
        PORT
        (
            InputA, InputB  : IN STD_LOGIC_VECTOR(7 downto 0);
            Operation   :   IN STD_LOGIC;
            Result    :   OUT STD_LOGIC_VECTOR(7 downto 0);
            CarryOUT    :   OUT STD_LOGIC
        );
        END COMPONENT; 

    COMPONENT EightBitRegister IS
        PORT(
            i_resetBar, i_load    : IN    STD_LOGIC;
            i_clock            : IN    STD_LOGIC;
            i_Value            : IN    STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_Value            : OUT    STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
        END COMPONENT;

    COMPONENT FourBitComparator IS
        PORT(
            i_Ai, i_Bi			: IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
            o_GT, o_LT, o_EQ		: OUT	STD_LOGIC
        );
        END COMPONENT;

    BEGIN
    A_IN <= (3 => IN1(3),2 => IN1(2),1 => IN1(1),0 => IN1(0), others => '0');

    RegA   : EightBitLeftShiftRegister
        PORT MAP
        (
            i_resetBar => RESET, 
            i_load => LDA, 
            i_shift => LSHFTA,
            i_clock => CLK,
            i_shift_entry => '0',      
            i_Value => A_IN,            
            o_Value => AdderIN1           
            );

    RegB   : FourBitRightShiftRegister
        PORT MAP
        (
            i_resetBar => RESET, 
            i_load => LDB, 
            i_shift => RSHFTB,
            i_clock => CLK,            
            i_shift_entry => '0',      
            i_Value => IN2,            
            o_Value => B_OUT           
        );

    RegI   : FourBitIncrementer
        PORT MAP
        (
            i_resetBar => RESET, 
            i_load => CLRI, 
            i_inc => INCI,
            i_clock => CLK,            
            i_Value => "0000",           
            o_Value => I_OUT
        );

    Adder   : AdderSubtractor
        PORT MAP
        (
            InputA =>AdderIN1, 
            InputB => AdderIN2,
            Operation => '0',
            Result => Adder_OUT,
            CarryOUT => open   
        ); -- *************** What do we do with Full Adder Carry Out? ******************
    
    RegP    : EightBitRegister
        PORT MAP
        (
            i_resetBar => RESET,
            i_load => LDP,
            i_clock => CLK,
            i_Value => Adder_OUT,
            o_Value => AdderIN2
        );
    
    Comp1   : FourBitComparator
        PORT MAP
        (
            i_Ai => I_OUT, 
            i_Bi => "0011",
            o_GT => open, 
            o_LT => ILT3, 
            o_EQ => open
        );
    BLSB <= (0 => B_OUT(0), others => '0');
    Comp2   : FourBitComparator
        PORT MAP
        (
            i_Ai => BLSB, 
            i_Bi => "0001",
            o_GT => open, 
            o_LT => open, 
            o_EQ => B0IS1
        );
    Product <= AdderIN2;
END rtl;
        