LIBRARY ieee;
USE  ieee.std_logic_1164.all;

ENTITY MultiplierControlUnit is
	PORT
	(
		i_clock, i_reset : IN STD_LOGIC;
		i_INCPM, i_EXPVLD : IN STD_LOGIC;
		o_LDPE, o_LDAM, o_LDBM, o_overflow, o_SHFTPM, o_INCPE : OUT STD_LOGIC;
		o_s0, o_s1, o_s2, o_s3, o_s4 : OUT STD_LOGIC
	);
END MultiplierControlUnit;

ARCHITECTURE rtl of MultiplierControlUnit is
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
SIGNAL int_s0, int_s1, int_s2, int_s3, int_s4 : STD_LOGIC; 
BEGIN
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
		i_d => (int_s1 AND i_INCPM AND NOT i_EXPVLD) OR int_s2,
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => int_s2,
		o_qBar => OPEN
	);
	s3 : dflipflop
	PORT MAP(
		i_d => (int_s1 AND i_INCPM AND i_EXPVLD) OR (int_s3 AND i_EXPVLD),
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => int_s3,
		o_qBar => OPEN
	);
	s4 : dflipflop
	PORT MAP(
		i_d => (int_s1 AND NOT i_INCPM) OR (int_s3 AND NOT i_INCPM) OR int_s4,
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => int_s4,
		o_qBar => OPEN
	);
	
	-- Control outputs
	o_LDPE <= int_s0;
	o_LDAM <= int_s1;
	o_LDBM <= int_s1;
	o_overflow <= int_s2;
	o_SHFTPM <= int_s3;
	o_INCPE <= int_s3;
	
	--Debug
	o_s0 <= int_s0;
	o_s1 <= int_s1;
	o_s2 <= int_s2;
	o_s3 <= int_s3;
	o_s4 <= int_s4;
END ARCHITECTURE;
