LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EXMEM IS
    PORT 
    (
        i_clock, i_reset : IN STD_LOGIC;
        i_memReadData, i_aluResult : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        i_regDest : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        o_memReadData, o_aluResult : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_regDest : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
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
    -- D flip-flops for i_memReadData
    memReadDataDff0 : dflipflop PORT MAP(i_d => i_memReadData(0), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_memReadData(0));
    memReadDataDff1 : dflipflop PORT MAP(i_d => i_memReadData(1), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_memReadData(1));
    memReadDataDff2 : dflipflop PORT MAP(i_d => i_memReadData(2), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_memReadData(2));
    memReadDataDff3 : dflipflop PORT MAP(i_d => i_memReadData(3), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_memReadData(3));
    memReadDataDff4 : dflipflop PORT MAP(i_d => i_memReadData(4), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_memReadData(4));
    memReadDataDff5 : dflipflop PORT MAP(i_d => i_memReadData(5), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_memReadData(5));
    memReadDataDff6 : dflipflop PORT MAP(i_d => i_memReadData(6), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_memReadData(6));
    memReadDataDff7 : dflipflop PORT MAP(i_d => i_memReadData(7), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_memReadData(7));

    -- D flip-flops for i_aluResult
    aluResultDff0 : dflipflop PORT MAP(i_d => i_aluResult(0), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_aluResult(0));
    aluResultDff1 : dflipflop PORT MAP(i_d => i_aluResult(1), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_aluResult(1));
    aluResultDff2 : dflipflop PORT MAP(i_d => i_aluResult(2), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_aluResult(2));
    aluResultDff3 : dflipflop PORT MAP(i_d => i_aluResult(3), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_aluResult(3));
    aluResultDff4 : dflipflop PORT MAP(i_d => i_aluResult(4), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_aluResult(4));
    aluResultDff5 : dflipflop PORT MAP(i_d => i_aluResult(5), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_aluResult(5));
    aluResultDff6 : dflipflop PORT MAP(i_d => i_aluResult(6), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_aluResult(6));
    aluResultDff7 : dflipflop PORT MAP(i_d => i_aluResult(7), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_aluResult(7));

    -- D flip-flops for i_regDest
    regDestDff0 : dflipflop PORT MAP(i_d => i_regDest(0), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_regDest(0));
    regDestDff1 : dflipflop PORT MAP(i_d => i_regDest(1), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_regDest(1));
    regDestDff2 : dflipflop PORT MAP(i_d => i_regDest(2), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_regDest(2));

END ARCHITECTURE;