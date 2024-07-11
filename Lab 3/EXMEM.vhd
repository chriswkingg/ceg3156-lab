LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EXMEM IS
    PORT 
    (
        i_clock, i_reset, i_zeroFlag : IN STD_LOGIC;
        i_branchAddr, i_aluResult, i_reg2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        i_regDest : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        o_branchAddr, o_aluResult, o_reg2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_regDest : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        o_zeroFlag : OUT STD_LOGIC
    );
END EXMEM;

ARCHITECTURE rtl OF EXMEM IS
    COMPONENT dflipflop IS
        PORT(
            i_d : IN STD_LOGIC;
            i_clock : IN STD_LOGIC;
            i_enable : IN STD_LOGIC;
            i_async_reset : IN STD_LOGIC;
            o_q : OUT STD_LOGIC
        );
    END COMPONENT;
BEGIN
    -- D flip-flops for i_branchAddr
    branchAddrDff0 : dflipflop PORT MAP(i_d => i_branchAddr(0), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_branchAddr(0));
    branchAddrDff1 : dflipflop PORT MAP(i_d => i_branchAddr(1), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_branchAddr(1));
    branchAddrDff2 : dflipflop PORT MAP(i_d => i_branchAddr(2), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_branchAddr(2));
    branchAddrDff3 : dflipflop PORT MAP(i_d => i_branchAddr(3), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_branchAddr(3));
    branchAddrDff4 : dflipflop PORT MAP(i_d => i_branchAddr(4), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_branchAddr(4));
    branchAddrDff5 : dflipflop PORT MAP(i_d => i_branchAddr(5), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_branchAddr(5));
    branchAddrDff6 : dflipflop PORT MAP(i_d => i_branchAddr(6), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_branchAddr(6));
    branchAddrDff7 : dflipflop PORT MAP(i_d => i_branchAddr(7), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_branchAddr(7));

    -- D flip-flops for i_aluResult
    aluResultDff0 : dflipflop PORT MAP(i_d => i_aluResult(0), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_aluResult(0));
    aluResultDff1 : dflipflop PORT MAP(i_d => i_aluResult(1), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_aluResult(1));
    aluResultDff2 : dflipflop PORT MAP(i_d => i_aluResult(2), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_aluResult(2));
    aluResultDff3 : dflipflop PORT MAP(i_d => i_aluResult(3), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_aluResult(3));
    aluResultDff4 : dflipflop PORT MAP(i_d => i_aluResult(4), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_aluResult(4));
    aluResultDff5 : dflipflop PORT MAP(i_d => i_aluResult(5), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_aluResult(5));
    aluResultDff6 : dflipflop PORT MAP(i_d => i_aluResult(6), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_aluResult(6));
    aluResultDff7 : dflipflop PORT MAP(i_d => i_aluResult(7), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_aluResult(7));

    -- D flip-flops for i_reg2
    reg2Dff0 : dflipflop PORT MAP(i_d => i_reg2(0), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg2(0));
    reg2Dff1 : dflipflop PORT MAP(i_d => i_reg2(1), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg2(1));
    reg2Dff2 : dflipflop PORT MAP(i_d => i_reg2(2), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg2(2));
    reg2Dff3 : dflipflop PORT MAP(i_d => i_reg2(3), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg2(3));
    reg2Dff4 : dflipflop PORT MAP(i_d => i_reg2(4), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg2(4));
    reg2Dff5 : dflipflop PORT MAP(i_d => i_reg2(5), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg2(5));
    reg2Dff6 : dflipflop PORT MAP(i_d => i_reg2(6), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg2(6));
    reg2Dff7 : dflipflop PORT MAP(i_d => i_reg2(7), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg2(7));

    -- D flip-flops for i_regDest
    regDestDff0 : dflipflop PORT MAP(i_d => i_regDest(0), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_regDest(0));
    regDestDff1 : dflipflop PORT MAP(i_d => i_regDest(1), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_regDest(1));
    regDestDff2 : dflipflop PORT MAP(i_d => i_regDest(2), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_regDest(2));

    -- D flip-flops for i_zeroFlag
    zeroFlagDff : dflipflop PORT MAP(i_d => i_zeroFlag, i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_zeroFlag);

END ARCHITECTURE;