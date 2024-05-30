LIBRARY ieee;
USE  ieee.std_logic_1164.all;

ENTITY FloatingMultiplier is
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
END FloatingMultiplier;

ARCHITECTURE rtl of FloatingMultiplier is

    COMPONENT MultiplierControlUnit is
        PORT
        (
            i_clock, i_reset : IN STD_LOGIC;
            i_INCPM, i_EXPVLD : IN STD_LOGIC;
            o_LDPE, o_LDAM, o_LDBM, o_overflow, o_SHFTPM, o_INCPE, o_LDPM : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT MultiplierDataPath is
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
    END COMPONENT;

    SIGNAL INCPM, EXPVLD, LDPE, LDAM, LDBM, overflow, SHFTPM, INCPE, LDPM : STD_LOGIC; 

    BEGIN

    dp  : MultiplierDataPath
        PORT MAP
        (
            -- Multiplier Input Signals 
            SignA => i_signA,
            SignB => i_signB,
            MantissaA => i_mantissaA,
            MantissaB => i_mantissaB,
            ExponentA => i_exponentA,
            ExponentB => i_exponentB,
            GClock => i_clock,
            GReset => i_reset,
            -- Multiplier Output Signals 
            SignOut => o_sign,
            MantissaOut => o_mantissa,
            ExponentOut => o_exponent,
            Overflow => o_overflow,
            --Control Path Links
            o_INCPM => INCPM, 
            o_EXPVLD => EXPVLD,
            i_LDPE => LDPE,
            i_LDAM => LDAM,
            i_LDBM => LDBM,
            i_overflow => overflow,
            i_SHFTPM => SHFTPM,
            i_INCPE => INCPE
        );

    cp  : MultiplierControlUnit
        PORT MAP
        (
            i_clock => i_clock,
            i_reset => i_reset,
            i_INCPM => INCPM,
            i_EXPVLD => EXPVLD,
            o_LDPE => LDPE,
            o_LDAM => LDAM,
            o_LDBM => LDBM,
            o_overflow => overflow,
            o_SHFTPM => SHFTPM,
            o_INCPE => INCPE,
            o_LDPM => LDPM
        );

END ARCHITECTURE;