LIBRARY ieee;
USE  ieee.std_logic_1164.all;

ENTITY AdderControlUnit is
	PORT
	(
		i_clock, i_reset : IN STD_LOGIC;
		i_downCounterEmpty, i_mantissaCarry, i_mantissaSumMSB : IN STD_LOGIC;
		o_loadA, o_loadB : OUT STD_LOGIC;
		o_loadDownCounter, o_decrementDownCounter : OUT STD_LOGIC;
		o_smallerMantissaLeftShift : OUT STD_LOGIC;
		o_loadSumE, o_loadSumM, o_loadSumS, o_rightShiftSum, o_incrementSumExponent, o_leftShiftSum, o_decrementSumExponent : OUT STD_LOGIC;
	);
END AdderControlUnit;

ARCHITECTURE rtl of AdderControlUnit is
COMPONENT dflipflop IS
	PORT(
		i_d : IN STD_LOGIC;
		i_clock : IN STD_LOGIC;
		i_enable : IN STD_LOGIC;
		i_async_reset : IN STD_LOGIC;
		i_async_set : IN STD_LOGIC;
		o_q, o_qBar : OUT STD_LOGIC
	);
END dflipflop;
);
END COMPONENT
SIGNAL int_s0, int_s1, int_s2, int_s3, int_s4, int_s5 : STD_LOGIC; 
BEGIN
	s0 : dflipflop
	PORT MAP(
		i_d => ,
		i_clock => i_clock,
		i_enable => 1
		i_async_reset => 0,
		i_async_set => i_reset,
		o_q => int_s0,
		o_qBar => OPEN
	);
	s1 : dflipflop
	PORT MAP(
		i_d => ,
		i_clock => i_clock,
		i_enable => 1
		i_async_reset => 0,
		i_async_set => i_reset,
		o_q => int_s1,
		o_qBar => OPEN
	);
	s2 : dflipflop
	PORT MAP(
		i_d => ,
		i_clock => i_clock,
		i_enable => 1
		i_async_reset => 0,
		i_async_set => i_reset,
		o_q => int_s2,
		o_qBar => OPEN
	);
	s3 : dflipflop
	PORT MAP(
		i_d => ,
		i_clock => i_clock,
		i_enable => 1
		i_async_reset => 0,
		i_async_set => i_reset,
		o_q => int_s3,
		o_qBar => OPEN
	);
	s4 : dflipflop
	PORT MAP(
		i_d => ,
		i_clock => i_clock,
		i_enable => 1
		i_async_reset => 0,
		i_async_set => i_reset,
		o_q => int_s4,
		o_qBar => OPEN
	);
	s5 : dflipflop
	PORT MAP(
		i_d => ,
		i_clock => i_clock,
		i_enable => 1
		i_async_reset => 0,
		i_async_set => i_reset,
		o_q => int_s5,
		o_qBar => OPEN
	);
	
	
	
END ARCHITECTURE;
