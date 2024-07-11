LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY IDEX IS
    PORT 
    (
        i_clock, i_reset : IN STD_LOGIC;
        i_PC, i_reg1, i_reg2, i_offset : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        i_rd1, i_rd2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        o_PC, o_reg1, o_reg2, o_offset : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_rd1, o_rd2 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END IDEX;

ARCHITECTURE rtl OF IDEX IS
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
    -- D flip-flops for i_PC
    pcDff0 : dflipflop PORT MAP(i_d => i_PC(0), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_PC(0));
    pcDff1 : dflipflop PORT MAP(i_d => i_PC(1), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_PC(1));
    pcDff2 : dflipflop PORT MAP(i_d => i_PC(2), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_PC(2));
    pcDff3 : dflipflop PORT MAP(i_d => i_PC(3), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_PC(3));
    pcDff4 : dflipflop PORT MAP(i_d => i_PC(4), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_PC(4));
    pcDff5 : dflipflop PORT MAP(i_d => i_PC(5), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_PC(5));
    pcDff6 : dflipflop PORT MAP(i_d => i_PC(6), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_PC(6));
    pcDff7 : dflipflop PORT MAP(i_d => i_PC(7), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_PC(7));

    -- D flip-flops for i_reg1
    reg1Dff0 : dflipflop PORT MAP(i_d => i_reg1(0), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg1(0));
    reg1Dff1 : dflipflop PORT MAP(i_d => i_reg1(1), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg1(1));
    reg1Dff2 : dflipflop PORT MAP(i_d => i_reg1(2), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg1(2));
    reg1Dff3 : dflipflop PORT MAP(i_d => i_reg1(3), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg1(3));
    reg1Dff4 : dflipflop PORT MAP(i_d => i_reg1(4), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg1(4));
    reg1Dff5 : dflipflop PORT MAP(i_d => i_reg1(5), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg1(5));
    reg1Dff6 : dflipflop PORT MAP(i_d => i_reg1(6), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg1(6));
    reg1Dff7 : dflipflop PORT MAP(i_d => i_reg1(7), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg1(7));

    -- D flip-flops for i_reg2
    reg2Dff0 : dflipflop PORT MAP(i_d => i_reg2(0), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg2(0));
    reg2Dff1 : dflipflop PORT MAP(i_d => i_reg2(1), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg2(1));
    reg2Dff2 : dflipflop PORT MAP(i_d => i_reg2(2), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg2(2));
    reg2Dff3 : dflipflop PORT MAP(i_d => i_reg2(3), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg2(3));
    reg2Dff4 : dflipflop PORT MAP(i_d => i_reg2(4), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg2(4));
    reg2Dff5 : dflipflop PORT MAP(i_d => i_reg2(5), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg2(5));
    reg2Dff6 : dflipflop PORT MAP(i_d => i_reg2(6), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg2(6));
    reg2Dff7 : dflipflop PORT MAP(i_d => i_reg2(7), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_reg2(7));

    -- D flip-flops for i_offset
    offsetDff0 : dflipflop PORT MAP(i_d => i_offset(0), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_offset(0));
    offsetDff1 : dflipflop PORT MAP(i_d => i_offset(1), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_offset(1));
    offsetDff2 : dflipflop PORT MAP(i_d => i_offset(2), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_offset(2));
    offsetDff3 : dflipflop PORT MAP(i_d => i_offset(3), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_offset(3));
    offsetDff4 : dflipflop PORT MAP(i_d => i_offset(4), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_offset(4));
    offsetDff5 : dflipflop PORT MAP(i_d => i_offset(5), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_offset(5));
    offsetDff6 : dflipflop PORT MAP(i_d => i_offset(6), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_offset(6));
    offsetDff7 : dflipflop PORT MAP(i_d => i_offset(7), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_offset(7));

    -- D flip-flops for i_rd1
    rd1Dff0 : dflipflop PORT MAP(i_d => i_rd1(0), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_rd1(0));
    rd1Dff1 : dflipflop PORT MAP(i_d => i_rd1(1), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_rd1(1));
    rd1Dff2 : dflipflop PORT MAP(i_d => i_rd1(2), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_rd1(2));

    -- D flip-flops for i_rd2
    rd2Dff0 : dflipflop PORT MAP(i_d => i_rd2(0), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_rd2(0));
    rd2Dff1 : dflipflop PORT MAP(i_d => i_rd2(1), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_rd2(1));
    rd2Dff2 : dflipflop PORT MAP(i_d => i_rd2(2), i_clock => i_clock, i_enable => '1', i_async_reset => i_reset, o_q => o_rd2(2));

END ARCHITECTURE;