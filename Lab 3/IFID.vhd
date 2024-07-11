LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY IFID IS
    PORT 
    (
        i_clock, i_reset : IN STD_LOGIC;
        i_instructionRegister : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
        i_PC : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_instructionRegister : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        o_PC : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END IFID;

ARCHITECTURE rtl OF IFID IS
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
    irDff0 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(0),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(0)
    );

    irDff1 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(1),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(1)
    );

    irDff2 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(2),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(2)
    );

    irDff3 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(3),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(3)
    );

    irDff4 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(4),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(4)
    );

    irDff5 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(5),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(5)
    );

    irDff6 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(6),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(6)
    );

    irDff7 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(7),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(7)
    );

    irDff8 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(8),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(8)
    );

    irDff9 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(9),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(9)
    );

    irDff10 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(10),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(10)
    );

    irDff11 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(11),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(11)
    );

    irDff12 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(12),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(12)
    );

    irDff13 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(13),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(13)
    );

    irDff14 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(14),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(14)
    );

    irDff15 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(15),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(15)
    );

    irDff16 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(16),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(16)
    );

    irDff17 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(17),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(17)
    );

    irDff18 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(18),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(18)
    );

    irDff19 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(19),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(19)
    );

    irDff20 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(20),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(20)
    );

    irDff21 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(21),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(21)
    );

    irDff22 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(22),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(22)
    );

    irDff23 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(23),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(23)
    );

    irDff24 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(24),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(24)
    );

    irDff25 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(25),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(25)
    );

    irDff26 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(26),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(26)
    );

    irDff27 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(27),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(27)
    );

    irDff28 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(28),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(28)
    );

    irDff29 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(29),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(29)
    );

    irDff30 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(30),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(30)
    );

    irDff31 : dflipflop
    PORT MAP(
        i_d => i_instructionRegister(31),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_instructionRegister(31)
    );

    pcDff0 : dflipflop
    PORT MAP(
        i_d => i_PC(0),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_PC(0)
    );

    pcDff1 : dflipflop
    PORT MAP(
        i_d => i_PC(1),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_PC(1)
    );

    pcDff2 : dflipflop
    PORT MAP(
        i_d => i_PC(2),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_PC(2)
    );

    pcDff3 : dflipflop
    PORT MAP(
        i_d => i_PC(3),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_PC(3)
    );

    pcDff4 : dflipflop
    PORT MAP(
        i_d => i_PC(4),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_PC(4)
    );

    pcDff5 : dflipflop
    PORT MAP(
        i_d => i_PC(5),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_PC(5)
    );

    pcDff6 : dflipflop
    PORT MAP(
        i_d => i_PC(6),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_PC(6)
    );

    pcDff7 : dflipflop
    PORT MAP(
        i_d => i_PC(7),
        i_clock => i_clock,
        i_enable => '1',
        i_async_reset => i_reset,
        o_q => o_PC(7)
    );

END ARCHITECTURE;