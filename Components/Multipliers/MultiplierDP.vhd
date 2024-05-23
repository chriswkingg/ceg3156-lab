LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MultiplierDP is
    PORT 
    (
        IN1, IN2    :   IN STD_LOGIC_VECTOR(8 downto 0);
        LSHFTA, RSHFTB, LDA, LDB, INCI, CLRI, LDP, CLRP, RESET, CLK    : IN STD_LOGIC;
        ILT7, B0IS1 :   OUT STD_LOGIC;
        Product     :   OUT STD_LOGIC_VECTOR(17 downto 0)

    );
    END ENTITY;

ARCHITECTURE rtl of MultiplierDP is
    SIGNAL A_IN, Adder_OUT, AdderIN1, AdderIN2    :   STD_LOGIC_VECTOR(17 downto 0);
    SIGNAL A_OUT, B_OUT, I_OUT, BLSB       : STD_LOGIC_VECTOR(8 downto 0);

    COMPONENT EighteenBitGPRegister IS
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
    END COMPONENT;
    
    COMPONENT NineBitGPRegister IS
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

    COMPONENT EighteenBitAdderSubtractor is 
        PORT
        (
            InputA, InputB  : IN STD_LOGIC_VECTOR(17 downto 0);
            Operation   :   IN STD_LOGIC;
            Result    :   OUT STD_LOGIC_VECTOR(17 downto 0);
            CarryOUT    :   OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT NineBitComparator IS
        PORT(
            i_Ai, i_Bi			: IN	STD_LOGIC_VECTOR(8 DOWNTO 0);
            o_GT, o_LT, o_EQ		: OUT	STD_LOGIC
        );
    END COMPONENT;

    BEGIN
    A_IN(8 downto 0) <= IN1;
    A_IN(17 downto 9) <= "000000000";

    RegA   : EighteenBitGPRegister
        PORT MAP
        (
        
            i_resetBar => RESET,
            i_load => LDA, 
            i_shiftLeft => LSHFTA,
            i_shiftRight => '0',
            i_decrement => '0',
            i_increment => '0',
            i_serial_in_left => '0',
            i_serial_in_right => '0',
            i_clock => CLK,
            i_Value => A_IN,
            o_Value => AdderIN1

        );

    RegB   : NineBitGPRegister
        PORT MAP
        (
        
            i_resetBar => RESET,
            i_load => LDB, 
            i_shiftLeft => '0',
            i_shiftRight => RSHFTB,
            i_decrement => '0',
            i_increment => '0',
            i_serial_in_left => '0',
            i_serial_in_right => '0',
            i_clock => CLK,
            i_Value => IN2,
            o_Value => B_OUT

        );

    RegI   : NineBitGPRegister
        PORT MAP
        (
        
            i_resetBar => RESET,
            i_load => CLRI, 
            i_shiftLeft => '0',
            i_shiftRight => '0',
            i_decrement => '0',
            i_increment => INCI,
            i_serial_in_left => '0',
            i_serial_in_right => '0',
            i_clock => CLK,
            i_Value => "000000000",
            o_Value => I_OUT

        );

    Adder   : EighteenBitAdderSubtractor
        PORT MAP
        (
            InputA =>AdderIN1, 
            InputB => AdderIN2,
            Operation => '0',
            Result => Adder_OUT,
            CarryOUT => open   
        ); -- *************** What do we do with Full Adder Carry Out? ******************
    
    RegP    : EighteenBitGPRegister
        PORT MAP
        (
        
            i_resetBar => RESET,
            i_load => LDP, 
            i_shiftLeft => '0',
            i_shiftRight => '0',
            i_decrement => '0',
            i_increment => '0',
            i_serial_in_left => '0',
            i_serial_in_right => '0',
            i_clock => CLK,
            i_Value => Adder_OUT,
            o_Value => AdderIN2

        );        
    
    Comp1   : NineBitComparator
        PORT MAP
        (
            i_Ai => I_OUT, 
            i_Bi => "000001001",
            o_GT => open, 
            o_LT => ILT7, 
            o_EQ => open
        );
    BLSB <= (0 => B_OUT(0), others => '0');
    Comp2   : NineBitComparator
        PORT MAP
        (
            i_Ai => BLSB, 
            i_Bi => "000000001",
            o_GT => open, 
            o_LT => open, 
            o_EQ => B0IS1
        );
    Product <= AdderIN2;
END rtl;
        