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
		o_s0, o_s1, o_s2, o_s3, o_s4, o_s5, o_s6 : OUT STD_LOGIC
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
	END COMPONENT;

SIGNAL int_s0, int_s1, int_s2, int_s3, int_s4, int_s5, int_s6 : STD_LOGIC; 
SIGNAL inp_s2, inp_s3, inp_s4, inp_s5, inp_s6 : STD_LOGIC;
BEGIN

	inp_s2 <= ((int_s1 OR int_s2)AND NOT i_DownCounterEmpty);
	inp_s3 <= (int_s1 OR int_s2) AND i_downCounterEmpty;
	inp_s4 <= int_s3 AND i_mantissaCarry;
	inp_s5 <= (int_s3 OR int_s5) AND NOT i_mantissaSumMSB AND NOT i_mantissaCarry;
	inp_s6 <= int_s4 OR int_s6 OR (int_s5 AND i_mantissaSumMSB) OR (int_s3 AND i_mantissaSumMSB AND NOT i_mantissaCarry);


	s0 : dflipflop
	PORT MAP(
		i_d => i_reset,
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => '0',
		i_async_set => i_reset,
		o_q => int_s0,
		o_qBar => OPEN
	);
	s1 : dflipflop
	PORT MAP(
		i_d => int_s0,
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => int_s1,
		o_qBar => OPEN
	);
	s2 : dflipflop
	PORT MAP(
		i_d => inp_s2,
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => int_s2,
		o_qBar => OPEN
	);
	s3 : dflipflop
	PORT MAP(
		i_d => inp_s3,
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => int_s3,
		o_qBar => OPEN
	);
	s4 : dflipflop
	PORT MAP(
		i_d => inp_s4,
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => int_s4,
		o_qBar => OPEN
	);
	s5 : dflipflop
	PORT MAP(
		i_d => inp_s5,
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => int_s5,
		o_qBar => OPEN
	);
	s6 : dflipflop
	PORT MAP(
		i_d => inp_s6,
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => int_s6,
		o_qBar => OPEN
	);
	o_loadA <= int_s0;
	o_loadB <= int_s0;
	o_loadDownCounter <= int_s1;
	o_decrementDownCounter <= int_s2;
	o_smallerMantissaLeftShift <= int_s2;
	o_loadSumE <= int_s3;
	o_loadSumM <= int_s3;
	o_loadSumS <= int_s3; 
	o_rightShiftSum <= int_s4;
	o_incrementSumExponent <= int_s4;
	o_leftShiftSum <= int_s5; 
	o_decrementSumExponent <= int_s5; 
	o_s0 <= int_s0;
	o_s1 <= int_s1;
	o_s2 <= int_s2;
	o_s3 <= int_s3;
	o_s4 <= int_s4;
	o_s5 <= int_s5;
	o_s6 <= int_s6;
	
END ARCHITECTURE;
