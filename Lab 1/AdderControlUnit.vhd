LIBRARY ieee;
USE  ieee.std_logic_1164.all;

ENTITY AdderControlUnit is
	PORT
	(
		i_downCounterEmpty, i_mantissaCarry, i_mantissaSumMSB : IN STD_LOGIC;
		o_loadA, o_loadB : OUT STD_LOGIC;
		o_loadDownCounter, o_decrementDownCounter : OUT STD_LOGIC;
		o_smallerMantissaLeftShift : OUT STD_LOGIC;
		o_loadSumE, o_loadSumM, o_loadSumS, o_rightShiftSum, o_incrementSumExponent, o_leftShiftSum, o_decrementSumExponent : OUT STD_LOGIC;
	);
END AdderControlUnit;

ARCHITECTURE rtl of AdderControlUnit is
BEGIN

END ARCHITECTURE;
