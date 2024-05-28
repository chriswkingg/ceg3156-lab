LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MultiplierCP is
    PORT
    (
        B0IS1, RESET, CLK, ILT7    : IN  STD_LOGIC;
        LSHFTA, RSHFTB, LDA, LDB, INCI, CLRI, LDP, CLRP    : OUT STD_LOGIC
    );
    END MultiplierCP;

ARCHITECTURE rtl of MultiplierCP is
    SIGNAL SReset, S0, S1, S2,S3, RegS1_IN, RegS2_IN, RegS0_IN, RegS3_IN   : STD_LOGIC;
    COMPONENT enARdFF_2 IS
        PORT(
            i_resetBar	: IN	STD_LOGIC;
            i_d		: IN	STD_LOGIC;
            i_enable	: IN	STD_LOGIC;
            i_clock		: IN	STD_LOGIC;
            o_q, o_qBar	: OUT	STD_LOGIC);
        END COMPONENT;
    
    COMPONENT enARdFF_2_resetON IS
        PORT(
            i_resetBar	: IN	STD_LOGIC;
            i_d		: IN	STD_LOGIC;
            i_enable	: IN	STD_LOGIC;
            i_clock		: IN	STD_LOGIC;
            o_q, o_qBar	: OUT	STD_LOGIC);
        END COMPONENT;
    BEGIN
        LDP <= S1;
        RegReset  :   enARdFF_2_resetON
        PORT MAP(
            i_resetBar => RESET,
            i_d => '0',
            i_enable => '1',	
            i_clock => CLK,
            o_q => SReset, 
            o_qBar  => open
            );
        RegS0  :   enARdFF_2
        PORT MAP(
            i_resetBar => RESET,
            i_d => SReset,
            i_enable => '1',	
            i_clock => CLK,
            o_q => S0, 
            o_qBar  => open
            );

        RegS1_IN <= (S0 or S1 or S2) and B0IS1  and ILT7;
        RegS2_IN <= (S0 or S1 or S2) and not B0IS1 and ILT7;
        RegS3_IN <= not ILT7 or S3;

        RegS1  :   enARdFF_2
        PORT MAP(
            i_resetBar => RESET,
            i_d => RegS1_IN,
            i_enable => '1',	
            i_clock => CLK,
            o_q => S1, 
            o_qBar  => open
            );

        RegS2  :   enARdFF_2
        PORT MAP(
            i_resetBar => RESET,
            i_d => RegS2_IN,
            i_enable => '1',	
            i_clock => CLK,
            o_q => S2, 
            o_qBar  => open
            );
        RegS3  :   enARdFF_2
        PORT MAP(
            i_resetBar => RESET,
            i_d => RegS3_IN,
            i_enable => '1',	
            i_clock => CLK,
            o_q => S3, 
            o_qBar  => open
            );

        LSHFTA <= S1 or S2;
        RSHFTB <= S1 or S2;
        LDA <= SReset;
        LDB <= SReset;
        INCI <= S1 or S2;
        CLRI <= SReset;
    
        CLRP <= SReset;

        -- DS0 <= S0;
        -- DS1 <= S1;
        -- DS2 <= S2;
        -- DS3 <= S3;
END rtl;