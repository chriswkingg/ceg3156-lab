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
		o_s0, o_s1, o_s2, o_s3, o_s4, o_s5, o_s6 : OUT STD_LOGIC
	);
END FloatingPointAdder;

ARCHITECTURE rtl of FloatingPointAdder is
	COMPONENT AdderDataPath IS
    PORT
    (
        -- Adder Input Signals 
        SignA, SignB                    :   IN STD_LOGIC;
        MantissaA, MantissaB            :   IN STD_LOGIC_VECTOR(7 downto 0);
        ExponentA, ExponentB            :   IN STD_LOGIC_VECTOR(6 downto 0);
        GClock, GResetBAR                  :   IN STD_LOGIC;
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
        DCEMT, MantissaCarry, MantissaSumMSB : OUT STD_LOGIC;
		  o_register_Am_result, o_register_Bm_result : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
    );
	END COMPONENT;
COMPONENT AdderControlUnit IS
PORT
	(
		i_clock, i_reset : IN STD_LOGIC;
		i_downCounterEmpty, i_mantissaCarry, i_mantissaSumMSB : IN STD_LOGIC;
		o_loadA, o_loadB : OUT STD_LOGIC;
		o_loadDownCounter, o_decrementDownCounter : OUT STD_LOGIC;
		o_smallerMantissaLeftShift : OUT STD_LOGIC;
		o_loadSumE, o_loadSumM, o_loadSumS, o_rightShiftSum, o_incrementSumExponent, o_leftShiftSum, o_decrementSumExponent : OUT STD_LOGIC;
		o_s0, o_s1, o_s2, o_s3, o_s4, o_s5, o_s6 : OUT STD_LOGIC
	);
END COMPONENT;
SIGNAL int_SHFTM, int_LDDC, int_DECDC, int_LDAM, int_LDBM, int_LDSM, int_LSHFTM, int_RSHFTM, int_LDSE, int_INCSE, int_DECSE, int_CLRS, int_LDAS, i_reset_BAR : STD_LOGIC;
SIGNAL int_DCEMT, int_MantissaCarry, int_MantissaSumMSB : STD_LOGIC;
SIGNAL int_s0, int_s1, int_s2, int_s3, int_s4, int_s5, int_s6 : STD_LOGIC; 
SIGNAL int_register_Am_result, int_register_Bm_result : STD_LOGIC_VECTOR(8 DOWNTO 0);
BEGIN
	i_reset_BAR <= not i_reset;
	dp : AdderDataPath
	PORT MAP(
		SignA => i_signA,
		SignB => i_signB,
		MantissaA => i_mantissaA, 
		MantissaB => i_mantissaB,            
      ExponentA => i_exponentA,
		ExponentB => i_exponentB,
      GClock => i_clock,
		GResetBAR => i_reset_BAR,
      SignOut => o_sign,
      MantissaOut => o_mantissa,
      ExponentOut => o_exponent,
      Overflow => o_overflow,
      SHFTM => int_SHFTM,
      LDDC => int_LDDC, 
		DECDC => int_DECDC,
      LDAM => '1', 
		LDBM => '1',
      LDSM => int_LDSM, 
		LSHFTM => int_LSHFTM, 
		RSHFTM => int_RSHFTM,
      LDSE => int_LDSE,
		INCSE => int_INCSE, 
		DECSE => int_DECSE,
      CLRS => int_CLRS,
		LDAS => int_LDAS,
	DCEMT => int_DCEMT,
	MantissaCarry => int_MantissaCarry,
	MantissaSumMSB => int_MantissaSumMSB, 
	o_register_Am_result => int_register_Am_result,
	o_register_Bm_result => int_register_Bm_result
	);

	cp : AdderControlUnit
	PORT MAP
	(
		i_clock => i_clock,
		i_reset => i_reset,
		i_downCounterEmpty => int_DCEMT,
		i_mantissaCarry => int_MantissaCarry,
		i_mantissaSumMSB => int_MantissaSumMSB,
		o_loadA => int_LDAM,
		o_loadB => int_LDBM,
		o_loadDownCounter => int_LDDC,
		o_decrementDownCounter => int_DECDC,
		o_smallerMantissaLeftShift => int_SHFTM,
		o_loadSumE => int_LDSE,
		o_loadSumM => int_LDSM,
		o_loadSumS => open,
		o_rightShiftSum => int_RSHFTM,
		o_incrementSumExponent => int_INCSE,
		o_leftShiftSum => int_LSHFTM,
		o_decrementSumExponent =>  int_DECSE,
		o_s0 => int_s0,
		o_s1 => int_s1,
		o_s2 => int_s2,
		o_s3 => int_s3,
		o_s4 => int_s4,
		o_s5 => int_s5,
		o_s6 => int_s6
	);
	o_s0 <= int_s0;
	o_s1 <= int_s1;
	o_s2 <= int_s2;
	o_s3 <= int_s3;
	o_s4 <= int_s4;
	o_s5 <= int_s5;
	o_s6 <= int_s6;
END ARCHITECTURE;
