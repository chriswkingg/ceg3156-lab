library IEEE;
use IEEE.std_logic_1164.all;

entity AdderTop is 
	port(
		i_mantissa : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		i_exponent : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		i_resetAdder, i_resetReg, i_clock, i_loadA, i_loadB : IN STD_LOGIC;
		o_sign, o_overflow : OUT STD_LOGIC;
		o_mantissa : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		o_exponent : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
end AdderTop;

architecture rtl of AdderTop is
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
component FloatingPointAdder
PORT
	(
		i_clock, i_reset : IN STD_LOGIC;
		i_signA, i_signB : IN STD_LOGIC;
		i_mantissaA, i_mantissaB : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		i_exponentA, i_exponentB : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		o_sign, o_overflow : OUT STD_LOGIC;
		o_mantissa : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		o_exponent : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
	end component;
signal int_resetBAR : STD_LOGIC;
signal int_mantissaA, int_mantissaB : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal int_exponentA, int_exponentB : STD_LOGIC_VECTOR(7 DOWNTO 0);
begin
int_resetBAR <= not i_resetReg;
	mantissaA     :   EightBitGPRegister
        PORT MAP
        (

            i_resetBar => int_resetBAR,
            i_load => i_loadA, 
            i_shiftLeft => '0',
            i_shiftRight => '0',
            i_decrement => '0',
            i_increment => '0',
            i_serial_in_left => '0',
            i_serial_in_right => '0',
            i_clock => i_clock,
            i_Value => i_mantissa,
            o_Value => int_mantissaA

        );
		  exponentA     :   EightBitGPRegister
        PORT MAP
        (

            i_resetBar => int_resetBAR,
            i_load => i_loadA, 
            i_shiftLeft => '0',
            i_shiftRight => '0',
            i_decrement => '0',
            i_increment => '0',
            i_serial_in_left => '0',
            i_serial_in_right => '0',
            i_clock => i_clock,
            i_Value => i_exponent,
            o_Value => int_exponentA

        );
		  mantissaB     :   EightBitGPRegister
        PORT MAP
        (

            i_resetBar => int_resetBAR,
            i_load => i_loadB, 
            i_shiftLeft => '0',
            i_shiftRight => '0',
            i_decrement => '0',
            i_increment => '0',
            i_serial_in_left => '0',
            i_serial_in_right => '0',
            i_clock => i_clock,
            i_Value => i_mantissa,
            o_Value => int_mantissaB

        );
		  exponentB     :   EightBitGPRegister
        PORT MAP
        (

            i_resetBar => int_resetBAR,
            i_load => i_loadB, 
            i_shiftLeft => '0',
            i_shiftRight => '0',
            i_decrement => '0',
            i_increment => '0',
            i_serial_in_left => '0',
            i_serial_in_right => '0',
            i_clock => i_clock,
            i_Value => i_exponent,
            o_Value => int_exponentB

        );
		  
		  FPA:FloatingPointAdder
PORT MAP
	(
		i_clock => i_clock, 
		i_reset => i_resetAdder,
		i_signA => int_exponentA(7),
		i_signB => int_exponentB(7),
		i_mantissaA => int_mantissaA,
		i_mantissaB => int_mantissaB,
		i_exponentA => int_exponentA(6 DOWNTO 0),
		i_exponentB => int_exponentB(6 DOWNTO 0),
		o_sign => o_sign, 
		o_overflow => o_overflow,
		o_mantissa => o_mantissa,
		o_exponent => o_exponent
	);
end rtl;