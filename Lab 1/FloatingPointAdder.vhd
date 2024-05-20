LIBRARY ieee;
USE  ieee.std_logic_1164.all;

ENTITY FloatingPointAdder is
	PORT
	(
		i_clock, i_reset : IN STD_LOGIC;
		i_signA, i_signB : IN STD_LOGIC;
		i_mantissaA, i_mantissaB : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		i_exponentA, i_exponentB : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		o_sign, o_overflow : OUT STD_LOGIC;
		o_mantissa : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		o_exponent : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		
	);
END FloatingPointAdder;

ARCHITECTURE rtl of FloatingPointAdder is
COMPONENT AdderDataPath IS
PORT
    (
        SignA, SignB                    :   IN STD_LOGIC;
        MantissaA, MantissaB            :   IN STD_LOGIC_VECTOR(7 downto 0);
        ExponentA, ExponentB            :   IN STD_LOGIC_VECTOR(6 downto 0);
        GClock, GReset                  :   IN STD_LOGIC;
        SignOut                         :   OUT STD_LOGIC;
        MantissaOut                     :   OUT STD_LOGIC_VECTOR(7 downto 0);
        ExponentOut                     :   OUT STD_LOGIC_VECTOR(6 downto 0);
        Overflow                        :   OUT STD_LOGIC;
        SHFTM                           :   IN STD_LOGIC;
        LDDC, DECDC                     :   IN STD_LOGIC;
        LDAM, LDBM                      :   IN STD_LOGIC;
        LDSM, LSHFTM, RSHFTM            :   IN STD_LOGIC;
        LDSE, INCSE, DECSE              :   IN STD_LOGIC;
        CLRS, LDAS                      :   IN STD_LOGIC
    )
END COMPONENT;
COMPONENT AdderControlUnit IS
PORT
	(
		i_clock, i_reset : IN STD_LOGIC;
		i_downCounterEmpty, i_mantissaCarry, i_mantissaSumMSB : IN STD_LOGIC;
		o_loadA, o_loadB : OUT STD_LOGIC;
		o_loadDownCounter, o_decrementDownCounter : OUT STD_LOGIC;
		o_smallerMantissaLeftShift : OUT STD_LOGIC;
		o_loadSumE, o_loadSumM, o_loadSumS, o_rightShiftSum, o_incrementSumExponent, o_leftShiftSum, o_decrementSumExponent : OUT STD_LOGIC
	);
END COMPONENT;
SIGNAL int_SHFTM, int_LDDC, int_DECDC, int_LDAM, int_LDBM, int_LDSM, int_LSHFTM, int_RSHFTM, int_LDSE, int_INCSE, int_DECSE, int_CLRS, int_LDAS : STD_LOGIC
BEGIN
	dp : AdderDataPath
	PORT MAP(
		SignA => i_signA,
		SignB => i_signB
		MantissaA => i_mantissaA, 
		MantissaB => i_mantissaB,            
      ExponentA => i_exponentA,
		ExponentB => i_exponentB,
      GClock => i_clock,
		GReset => i_reset,
      SignOut => o_sign,
      MantissaOut => o_mantissa,
      ExponentOut => o_exponent
      Overflow => o_overflow,
      SHFTM => int_SHIFTM,
      LDDC => int_LLDC, 
		DECDC => int_DECDC
      LDAM => int_LDAM, 
		LDBM => int_LDBM,
      LDSM => int_LDSM, 
		LSHFTM => int_LSHFTM, 
		RSHFTM => int_RSHFTM,
      LDSE => int_LDSE,
		INCSE => int_INCSE, 
		DECSE => int_DECSE,
      CLRS => int_CLRS,
		LDAS => int_LDAS
	);
	
	
END ARCHITECTURE;